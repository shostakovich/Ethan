Controller = require("./Controller").Controller
DailyNotification = require("./Notification").DailyNotification

class NotificationController extends Controller
  constructor: ->
    @name = "Notification"
    @notification = new DailyNotification "Standup Meeting", "11:43", false


  executeAddStandup: (subscriber)->
    @notification.subscribe subscriber
    @render "standup_notification", @notification

  send_notifications: (notifier)->
    @notification.send_if_necessary(notifier)

module.exports = {NotificationController: NotificationController}