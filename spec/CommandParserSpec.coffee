CommandParser = require("../lib/CommandParser").CommandParser;

describe 'CommandParser', ->
	
	it 'should parse a subscribe command', ->
		parser = new CommandParser
		expect(parser.parse "Notify me about Standup Meeting").toEqual ["AddNotification", "Standup Meeting"]
		
	it 'should parse a help command', ->
		parser = new CommandParser
		expect(parser.parse "help").toEqual ["ShowHelp"]		
		
	it 'should return undefined on an unknown command', ->
		parser = new CommandParser
		expect(parser.parse "Lorem ipsum dolor").toEqual undefined