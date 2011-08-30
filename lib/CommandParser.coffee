class CommandParser

	parse: (command) ->
		matches = command.match /Notify me about (.*)/
		return ["AddNotification", matches[1]] if matches
		
		matches = command.match /help/
		return ["Help"] if matches

		matches = command.match /Add (.*) as a new teammember/
		return ["AddUser"] if matches
		
module.exports = {CommandParser: CommandParser}