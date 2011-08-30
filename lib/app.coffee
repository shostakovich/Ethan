sys = require 'sys'
xmpp = require 'node-xmpp'
argv = process.argv

if (argv.length != 4)
    sys.puts('Usage: coffee app.coffee <my-jid> <my-password>')
    process.exit(1)

Notification = require("./Notification").Notification
DailyNotification = require("./Notification").DailyNotification

NotificationManager = require("./Notification").NotificationManager
Notifier = require("./Notification").Notifier
XmppHelper = require("./XmppHelper").XmppHelper
CommandParser = require("./CommandParser").CommandParser

cl = new xmpp.Client { jid: argv[2], password: argv[3] }

notifier = new Notifier( cl  )

manager = new NotificationManager(notifier)
manager.addNotification(new DailyNotification "Standup Meeting", "19:11")

setInterval () ->
	manager.try_notify()
, 2000

helper = new XmppHelper

cl.on 'stanza', (stanza) ->
	body = helper.get_stanza_message(stanza)
	return if body == undefined
				
	parser = new CommandParser
	command = parser.parse body
	recipient = stanza.attrs.from
				
	if command != undefined && command[0] == "AddNotification"
		console.log(command)
		try
			manager.subscribe recipient, command[1]
			message = "I will notify you off #{command[1]} in the future"
		catch error
			message = "This notificaion does not exist"
		return notifier.send_message recipient, message
	if command != undefined && command[0] == "ShowHelp"
		 return notifier.send_message recipient, "Type: Notify me about Standup Meeting"

	return notifier.send_message recipient, "I did not understand '#{body}'? Please type 'help' to get a list of things I can do."

cl.on 'online', () ->
	cl.send new xmpp.Element('presence', { }).
		c('show').t('chat').up().
		c('status').t('Happily assisting the team!')

cl.on 'error', (e) -> sys.puts(e)