Milk = require 'Milk'
fs = require 'fs'

class Controller
  render: (view_name, parameters={}) ->
    template = fs.readFileSync("./views/#{view_name}.milk", 'utf8')
    Milk.render template, parameters

module.exports = {Controller: Controller}