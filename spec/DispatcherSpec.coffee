Dispatcher = require("../lib/Dispatcher").Dispatcher

class HelpAction

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

    d.dispatch ["Help"]