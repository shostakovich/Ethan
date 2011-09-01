HelpController = require("../lib/HelpController").HelpController

describe 'HelpController', ->

  it 'should have the name "Help"', ->
    h = new HelpController
    expect(h.name).toEqual "Help"

  it 'should return a simple help text', ->
    h = new HelpController
    expect(h.execute()).toMatch "My name is ethan"