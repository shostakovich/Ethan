class XmppHelper

	get_stanza_message: (stanza) ->
		unless stanza.is("message")
			return

		if stanza.attrs.type == 'error'
			return

		for children in stanza.children
			if children.name != "body"
				continue
			if children.children[0] != undefined
				return children.children[0]
		
module.exports = {XmppHelper: XmppHelper}