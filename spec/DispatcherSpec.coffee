Dispatcher = require("../lib/Dispatcher").Dispatcher
HelpAction = require("../lib/HelpAction").HelpAction

describe 'Dispatcher', ->

  it 'allows to register one ore more actions', ->
    d = new Dispatcher
    h = new HelpAction
    d.register_action h

    d.actions
    expect(d.actions.length).toEqual 1

  it 'executes the right action', ->
    d = new Dispatcher

    h = new HelpAction
    d.register_action h

    spyOn(h, 'execute')
    d.dispatch "Help"
    expect(h.execute).toHaveBeenCalledWith([])

  it 'throws an exception if action does not exist', ->
    d = new Dispatcher
    try
      d.dispatch "Foobar"
      expect(true).toEqual false
    catch error
      expect(error).toEqual "Action was not registered"

  it 'dispatches a command to the proper action', ->
    d = new Dispatcher

    h = new HelpAction
    d.register_action h

    spyOn(h, 'execute')
    d.execute_command 'help'
    expect(h.execute).toHaveBeenCalledWith([])

