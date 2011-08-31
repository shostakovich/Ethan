Dispatcher = require("../lib/Dispatcher").Dispatcher
HelpController = require("../lib/HelpController").HelpController
NotificationController = require("../lib/NotificationController").NotificationController

describe 'Dispatcher', ->
  beforeEach ->
    @d = new Dispatcher

  it 'allows to register one ore more controllers', ->
    c = new HelpController
    @d.register_controller c

    c = new NotificationController
    @d.register_controller c

    expect(@d.controllers.length).toEqual 2

  it 'executes the right controller', ->
    h = new HelpController
    @d.register_controller h

    spyOn(h, 'execute')
    @d.dispatch "Help"
    expect(h.execute).toHaveBeenCalledWith([])

  it 'passes additional parameters to the action', ->
    n = new NotificationController
    @d.register_controller n

    spyOn(n, 'executeAddStandup')
    @d.dispatch "Notification", "AddStandup"
    expect(n.executeAddStandup).toHaveBeenCalledWith([])

  it 'throws an exception if controller does not exist', ->
    try
      @d.dispatch "Foobar"
      expect(true).toEqual false
    catch error
      expect(error).toEqual "Controller was not registered"

  it 'dispatches a command to the proper controller and action', ->
    h = new HelpController
    @d.register_controller h

    spyOn(h, 'execute')
    @d.execute_command 'help'
    expect(h.execute).toHaveBeenCalledWith([])

