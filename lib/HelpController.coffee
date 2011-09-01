Controller = require("./Controller").Controller

class HelpController extends Controller
  constructor: ->
    @name = "Help"

  execute: (args)->
    @render "help"

module.exports = {HelpController: HelpController}