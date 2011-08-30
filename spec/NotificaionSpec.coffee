Notification = require("../lib/Notification").Notification
NotificationManager = require("../lib/Notification").NotificationManager
DailyNotification = require("../lib/Notification").DailyNotification

describe 'NotificaionManager', ->
	it 'should contain one or more notificaions', ->
		m = new NotificationManager
		m.addNotification(new Notification "Standup")
		m.addNotification(new Notification "Standup2")
		expect(m.notifications.length).toEqual 2
		
	it 'should subscribe a user to a notificaion', ->
		m = new NotificationManager
		m.addNotification(new Notification "Standup")
		m.subscribe 'robert@rocu.de', 'Standup'
		
		expect(m.notifications[0].subscribers).toEqual ['robert@rocu.de']
		
	it 'should throw an exception if the notificaion does not exist', ->
		m = new NotificationManager
		try
			m.subscribe 'robert@rocu.de', 'Standup'
			expect(false).toEqual true
		catch error
			expect(true).toEqual true	

describe 'DailyNotification', ->
	
	it 'should have a time', ->
		n = new DailyNotification "Standup", "09:45"
		expect(n.time).toEqual "09:45"
		
	it 'should set the alarm to today if time is bigger than the current_time', ->
		now = new Date
		hours = now.getHours()
		minutes = now.getMinutes() + 1
		
		wanted_time = now
		wanted_time.setMinutes(minutes)
		wanted_time.setSeconds(0)
		
		n = new DailyNotification "Standup", "#{hours}:#{minutes}"
		expect(n.next_notificaion.toGMTString()).toEqual wanted_time.toGMTString()
		
	it 'should set the alarm to tommorow if time is smaller than the current_time', ->
		now = new Date
		hours = now.getHours()
		minutes = now.getMinutes() - 1
		
		wanted_time = now
		wanted_time.setMinutes(minutes)
		wanted_time.setDate(wanted_time.getDate() + 1)
		wanted_time.setSeconds(0)
		
		n = new DailyNotification "Standup", "#{hours}:#{minutes}"
		expect(n.next_notificaion.toGMTString()).toEqual wanted_time.toGMTString()
		
	it 'should recognize if it needs to notify a user', ->
		now = new Date
		hours = now.getHours()
		minutes = now.getMinutes()
		n = new DailyNotification "Standup", "#{hours}:#{minutes}"
		
		# Schedule it for 1 minute ago
		now.setMinutes(minutes - 1)
		n.next_notificaion = now
		

		expect(n.needs_to_notify()).toEqual true
		

describe 'Notification', ->

	it 'should have a name', ->
		n = new Notification "Standup"
		expect(n.name).toEqual "Standup"

	it 'should contain one or more subscribers', ->
		n = new Notification "Standup"
		n.subscribe "1@test.de"	
		n.subscribe "2@test.de"
		expect(n.subscribers).toEqual ["1@test.de", "2@test.de"]
		
	it 'should not subscribe the same address twice', ->
		n = new Notification "Standup"
		n.subscribe "1@test.de"
		n.subscribe "1@test.de"
		expect(n.subscribers).toEqual ["1@test.de"]
		
	it 'should delete a subscription', ->
		n = new Notification "Standup"
		n.subscribe "1@test.de"
		n.unsubscribe "1@test.de"
		expect(n.subscribers).toEqual []