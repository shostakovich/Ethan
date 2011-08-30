HelpAction = require("../lib/HelpAction").HelpAction

describe 'HelpAction', ->

  it 'should have the name "Help"', ->
    h = new HelpAction
    expect(h.name).toEqual "Help"

  it 'should return a simple help text', ->
    h = new HelpAction
    expect(h.execute()).toEqual "Type: Notify me about Standup Meeting"

