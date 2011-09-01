Controller = require("./Controller").Controller
os = require 'os'
fs = require 'fs'

class DebugController extends Controller
  constructor: ->
    @name = "Debug"

  execute: (args)->
    @render "debug", @get_debug_parameter()


  get_debug_parameter: ->
    {
      hostname: os.hostname(),
      os_name: os.type(),
      os_release: os.release(),
      load_avg: os.loadavg()
      node_version: process.version,
      node_memory_usage: process.memoryUsage(),
    }

module.exports = {DebugController: DebugController}