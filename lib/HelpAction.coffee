class HelpAction
  constructor: ->
    @name = "Help"

  execute: (args)->
		 return "Type: Notify me about Standup Meeting"

module.exports = {HelpAction: HelpAction}