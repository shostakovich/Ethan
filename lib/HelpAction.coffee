class HelpAction
  constructor: ->
    @name = "Help"

  execute: ->
    @executed = Help

module.exports = {HelpAction: HelpAction}