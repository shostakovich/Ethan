DailyNotification = require("../lib/Notification").DailyNotification

describe 'DailyNotification', ->

	it 'should have a time', ->
		n = new DailyNotification "Standup", "09:45", false
		expect(n.time).toEqual "09:45"

	it 'should set the alarm to today if time is bigger than the current_time', ->
		now = new Date
		hours = now.getHours()
		minutes = now.getMinutes() + 1

		wanted_time = now
		wanted_time.setMinutes(minutes)
		wanted_time.setSeconds(0)
		minutes =  "0#{minutes}" if minutes < 10

		n = new DailyNotification "Standup", "#{hours}:#{minutes}", false
		expect(n.next_notificaion.toGMTString()).toEqual wanted_time.toGMTString()

	it 'should set the alarm to tommorow if time is smaller than the current_time', ->
		now = new Date
		hours = now.getHours()
		minutes = now.getMinutes() - 1

		wanted_time = now
		wanted_time.setMinutes(minutes)
		wanted_time.setDate(wanted_time.getDate() + 1)
		wanted_time.setSeconds(0)
		minutes =  "0#{minutes}" if minutes < 10


		n = new DailyNotification "Standup", "#{hours}:#{minutes}", false
		expect(n.next_notificaion.toGMTString()).toEqual wanted_time.toGMTString()

	it 'should recognize if it needs to notify a user', ->
		now = new Date
		hours = now.getHours()
		minutes = now.getMinutes()
		minutes =  "0#{minutes}" if minutes < 10

		n = new DailyNotification "Standup", "#{hours}:#{minutes}", false

		# Schedule it for 1 minute ago
		now.setMinutes(minutes - 1)
		n.next_notificaion = now


		expect(n.needs_to_notify()).toEqual true