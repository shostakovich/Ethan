Notification = require("../lib/Notification").Notification

describe 'Notification', ->

  beforeEach ->
    @n = new Notification("Standup", false)

  it 'should have a name', ->
    expect(@n.name).toEqual "Standup"

  it 'should contain one or more subscribers', ->
    @n.subscribe "1@test.de"
    @n.subscribe "2@test.de"
    expect(@n.subscribers).toEqual ["1@test.de", "2@test.de"]

  it 'should not subscribe the same address twice', ->
    @n.subscribe "1@test.de"
    @n.subscribe "1@test.de"
    expect(@n.subscribers).toEqual ["1@test.de"]

  it 'should delete a subscription', ->
    @n.subscribe "1@test.de"
    @n.unsubscribe "1@test.de"
    expect(@n.subscribers).toEqual []

  it 'should memorize its subscribers', ->
    @n = new Notification "SubscriberTest"
    @n.subscribe "1@test.de"

    @n = new Notification "SubscriberTest"
    expect(@n.subscribers).toEqual ["1@test.de"]

