Milk = require 'Milk'
fs = require 'fs'

class HelpController
  constructor: ->
    @name = "Help"

  execute: (args)->
    template = fs.readFileSync('./views/help.milk', 'utf8')
    Milk.render template

module.exports = {HelpController: HelpController}