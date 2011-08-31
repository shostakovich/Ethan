class NotificationController
  constructor: ->
    @name = "Notification"

  executeAddStandup: (args)->
		 return "You will recive the notifications in the future."

module.exports = {NotificationController: NotificationController}