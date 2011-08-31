class HelpController
  constructor: ->
    @name = "Help"

  execute: (args)->
		 return "Type: Notify me about Standup Meeting"

module.exports = {HelpController: HelpController}