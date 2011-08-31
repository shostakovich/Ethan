CommandParser = require("../lib/CommandParser").CommandParser

class Dispatcher
  constructor: ->
    @parser = new CommandParser
    @controllers = []

  register_controller: (controller) ->
    @controllers.push controller

  dispatch: (controller_name, action_name="execute", args=[]) ->
    action_name = "execute#{action_name}" if action_name != "execute"
    for controller in @controllers
      return eval "controller.#{action_name}(args)" if controller.name is controller_name
    throw "Controller was not registered"

  execute_command: (command) ->
    parts = @parser.parse command
    try
      @dispatch(parts[0], parts[1])
    catch error
      "I did not understand this command"

module.exports = {Dispatcher: Dispatcher}