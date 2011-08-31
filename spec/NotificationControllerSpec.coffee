NotificationController = require("../lib/NotificationController").NotificationController

describe 'NotificationController', ->

  it 'should have the name "Notification"', ->
    n = new NotificationController
    expect(n.name).toEqual "Notification"

  it 'should register a user to a standup meeting notification', ->
    n = new NotificationController

    expect(n.executeAddStandup()).toEqual "You will recive the notifications in the future."