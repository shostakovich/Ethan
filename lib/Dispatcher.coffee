CommandParser = require("../lib/CommandParser").CommandParser

class Dispatcher
  constructor: ->
    @parser = new CommandParser
    @actions = []

  register_action: (action) ->
    @actions.push action

  dispatch: (action_name, args=[]) ->
    for action in @actions
      return action.execute(args) if action.name is action_name
    throw "Action was not registered"

module.exports = {Dispatcher: Dispatcher}