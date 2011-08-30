CommandParser = require("../lib/CommandParser").CommandParser

class Dispatcher
  constructor: ->
    @parser = new CommandParser
    @actions = []

  register_action: (action) ->
    @actions.push action

  dispatch: (command) ->

module.exports = {Dispatcher: Dispatcher}