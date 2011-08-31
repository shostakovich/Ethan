CommandParser = require("../lib/CommandParser").CommandParser;

describe 'CommandParser', ->
  beforeEach ->
    @parser = new CommandParser

  it 'should parse a add user command', ->
    expect(@parser.parse "Add test@test.de as a new teammember").toEqual ["AddUser"]

  it 'should parse a subscribe command', ->
    expect(@parser.parse "Notify me about Standup Meeting").toEqual ["Notification", "AddStandup"]

  it 'should parse a help command', ->
    expect(@parser.parse "help").toEqual ["Help"]

  it 'should return undefined on an unknown command', ->
    expect(@parser.parse "Lorem ipsum dolor").toEqual undefined