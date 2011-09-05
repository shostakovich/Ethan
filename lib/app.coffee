sys = require 'sys'
xmpp = require 'node-xmpp'
argv = process.argv

if (argv.length != 4)
    sys.puts('Usage: coffee app.coffee <my-jid> <my-password>')
    process.exit(1)

Notifier = require("./Notification").Notifier
XmppHelper = require("./XmppHelper").XmppHelper
Dispatcher = require("./Dispatcher").Dispatcher
HelpController = require("./HelpController").HelpController
DebugController = require("./DebugController").DebugController
NotificationController = require("./NotificationController").NotificationController

cl = new xmpp.Client { jid: argv[2], password: argv[3] }

notifier = new Notifier( cl  )
helper = new XmppHelper
dispatcher = new Dispatcher
dispatcher.register_controller(new HelpController)
dispatcher.register_controller(new DebugController)

notification_controller = new NotificationController
dispatcher.register_controller(notification_controller)

setInterval(
  ->
    notification_controller.send_notifications(notifier)
  1000)


cl.on 'stanza', (stanza) ->
	body = helper.get_stanza_message(stanza)
	return if body == undefined
				
	recipient = stanza.attrs.from

	response = dispatcher.execute_command(body, recipient)
	return notifier.send_message recipient, response

cl.on 'online', () ->
	cl.send new xmpp.Element('presence', { }).
		c('show').t('chat').up().
		c('status').t('Happily assisting the team!')

cl.on 'error', (e) -> sys.puts(e)