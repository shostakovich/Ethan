class CommandParser

	parse: (command) ->
		matches = command.match /subscribe: Standup/
		return ["Notification", "AddStandup"] if matches
		
		matches = command.match /help/
		return ["Help"] if matches

		matches = command.match /Add (.*) as a new teammember/
		return ["AddUser"] if matches

		matches = command.match /debug/
		return ["Debug"] if matches
		
module.exports = {CommandParser: CommandParser}