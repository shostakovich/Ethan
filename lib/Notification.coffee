xmpp = require 'node-xmpp'
fs = require 'fs'

class Notification
	
	constructor: (@name, @access_db = true) ->
		@subscribers = []
		@load_subscribers() if @access_db
	
	subscribe: (address) ->
		unless address in @subscribers
			@subscribers.push address
			@save_subscribers()  if @access_db
		
	unsubscribe: (address) ->
		if address in @subscribers
			idx = @subscribers.indexOf address
			@subscribers.splice idx, 1

	save_subscribers: ->
	  fs.writeFileSync "./db/subscribers_#{@name}.txt", JSON.stringify(@subscribers), 'utf8'

	load_subscribers: ->
	  data = fs.readFileSync "./db/subscribers_#{@name}.txt", 'utf8'
	  @subscribers = JSON.parse data if data.length != 0

class DailyNotification extends Notification
	constructor: (@name, @time, @access_db=true) ->
		@subscribers = []
		@load_subscribers() if @access_db
		@next_notificaion = ""
		this.get_next_notifiacion_time()

	get_next_notifiacion_time: ->
		matches = @time.match /([0-2][0-9]):([0-5][0-9])/
		now = new Date

		@next_notificaion = now
		@next_notificaion.setHours(matches[1])
		@next_notificaion.setMinutes(matches[2])
		@next_notificaion.setSeconds 0
		
		if @needs_to_notify()
			@next_notificaion.setDate(now.getDate() + 1)
		
	needs_to_notify: () ->
		now = new Date
		Date.parse(now.toGMTString()) > Date.parse(@next_notificaion.toGMTString())
		
	send_if_necessary: (notifier) ->
		if @needs_to_notify()
			notifier.send_messages(@subscribers, "Dont forget #{@name}")
			this.get_next_notifiacion_time()
		

class Notifier
	constructor: (@client) ->
	
	send_messages: (recipients, message) ->
		this.send_message(recipient, message) for recipient in recipients
	
	send_message: (recipient, message) ->
		console.log("Sending message #{message} to #{recipient}")
		@client.send(new xmpp.Element('message', { to: recipient, type: 'chat'}).
			c('body').
			t(message))
		

module.exports = {Notification: Notification, Notifier: Notifier, DailyNotification, DailyNotification}