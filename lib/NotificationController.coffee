Milk = require 'Milk'
fs = require 'fs'

DailyNotification = require("./Notification").DailyNotification

class NotificationController
  constructor: ->
    @name = "Notification"

  executeAddStandup: (subscriber)->
    if undefined == @notification
      @notification = new DailyNotification "Standup Meeting", "11:43"
    @notification.subscribe subscriber

    template = fs.readFileSync('./views/standup_notification.milk', 'utf8')
    Milk.render template, {notification: @notification}

module.exports = {NotificationController: NotificationController}