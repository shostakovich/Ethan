NotificationController = require("../lib/NotificationController").NotificationController

describe 'NotificationController', ->

  it 'should have the name "Notification"', ->
    n = new NotificationController
    expect(n.name).toEqual "Notification"

  it 'should register a user to a standup meeting notification', ->
    n = new NotificationController
    n.executeAddStandup("rocurth@test.de")
    expect(n.notification.subscribers).toEqual ["rocurth@test.de"]

  it 'should return a message with the excact time for standup meeting notification', ->
    n = new NotificationController
    expect(n.executeAddStandup("rocurth@test.de")).toMatch "I will ping you every day at 11:43"

