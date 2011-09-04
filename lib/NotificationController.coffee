Controller = require("./Controller").Controller
DailyNotification = require("./Notification").DailyNotification

class NotificationController extends Controller
  constructor: ->
    @name = "Notification"

  executeAddStandup: (subscriber)->
    if undefined == @notification
      @notification = new DailyNotification "Standup Meeting", "11:43", false
    @notification.subscribe subscriber

    @render "standup_notification", @notification

module.exports = {NotificationController: NotificationController}