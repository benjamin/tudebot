class Tracker

  constructor: (@robot, @sender) ->
    @sightings = @robot.brain.data.whereis[@sender.room] ?= {}

  isRobot: (name) ->
    name.toLowerCase() == @robot.name.toLowerCase()

  isSender: (name) ->
    name.toLowerCase() == @sender.name.toLowerCase()

  senderWasSeen: (action) ->
    @sightings[@sender.name.toLowerCase()] = {name: @sender.name, action: action, when: new Date()} unless @isRobot(@sender.name)

  senderWasSeenAskingRhetoricalQuestions: ->
    @senderWasSeen("asking rhetorical questions in")

  lastSightingOf: (name) ->
    @sightings[name.toLowerCase()]

  nameFor: (nameOrPronoun) ->
    switch nameOrPronoun.toLowerCase()
      when "i", "me" then @sender.name
      when "you", "yourself" then @robot.name
      else nameOrPronoun

  whereIs: (nameOrPronoun) ->
    name = @nameFor(nameOrPronoun)
    if @isRobot(name)
      @senderWasSeenAskingRhetoricalQuestions()
      "I was last seen answering rhetorical questions in this room just now"
    else
      if @isSender(name)
        @senderWasSeenAskingRhetoricalQuestions()
        subject = "You were"

      sighting = @lastSightingOf(name)
      if sighting?
        subject ?= "#{sighting.name} was"
        "#{subject} last seen #{sighting.action} this room #{@timeAgoInWords(sighting.when)}"
      else
        "Sorry, I don't know anything about #{name}"

  minutesAgoInWords: (minutes) ->
    if minutes == 0
      "just now"
    else if minutes == 1
      "1 minute ago";
    else if minutes < 45
      "#{minutes} minutes ago"
    else if minutes < 90
      "about 1 hour ago"
    else if minutes < 1440
      "about #{Math.round(minutes / 60)} hours ago"
    else if minutes < 2160
      "about 1 day ago"
    else if minutes < 43200
      "#{Math.round(minutes / 1440)} days ago"
    else if minutes < 86400
      "about 1 month ago"
    else if minutes < 525600
      "#{Math.round(minutes / 43200)} months ago"
    else if minutes < 1051200
      "about 1 year ago"
    else
      "over #{Math.round(minutes / 525600)} years ago"

  timeAgoInWords: (date) ->
    milliseconds = new Date() - date
    minutes = Math.round(Math.abs(milliseconds / 60000))
    @minutesAgoInWords(minutes)

module.exports = (robot) ->

  withTracker = (callback) -> (msg) ->
    callback(msg, new Tracker(robot, msg.message.user))

  robot.brain.on "loaded", (data) ->
    data.whereis ?= {}
    for room, sightings of data.whereis
      for name, sighting of sightings
        sighting.when = new Date(sighting.when)

  robot.enter withTracker (msg, tracker) ->
    tracker.senderWasSeen("entering")

  robot.leave withTracker (msg, tracker) ->
    tracker.senderWasSeen("leaving")

  robot.hear /.*/, withTracker (msg, tracker) ->
    tracker.senderWasSeen("posting to")

  robot.respond /where(?:'?s| ?is| am| are) ([^?]+)\??$/i, withTracker (msg, tracker) ->
    msg.reply(tracker.whereIs(msg.match[1].trim()))
