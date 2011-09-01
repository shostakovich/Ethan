DebugController = require("../lib/DebugController").DebugController

describe 'DebugController', ->

  it 'should have the name "Debug"', ->
    d = new DebugController
    expect(d.name).toEqual "Debug"

  it 'should return a list off debug a list off debug information', ->
    d = new DebugController
    expect(d.execute()).toMatch "Debug Informations"
    expect(d.execute()).toMatch "Hostname: .+"
    expect(d.execute()).toMatch "OS: .+/.+"
    expect(d.execute()).toMatch "Load Average: .+"
    expect(d.execute()).toMatch "Nodejs Version: .+"
    expect(d.execute()).toMatch "Memory Usage: .+"