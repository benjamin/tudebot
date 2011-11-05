class Tracker

  constructor: (@robot, @sender) ->
    @activities = @robot.brain.data.whereis[@sender.room] ?= {}

  isRobot: (name = @sender.name) ->
    name.toLowerCase() == @robot.name.toLowerCase()

  isSender: (name) ->
    name.toLowerCase() == @sender.name.toLowerCase()

  recordActivity: (action) ->
    @activities[@sender.name.toLowerCase()] = {name: @sender.name, action: action, when: new Date()} unless @isRobot()

  recordRhetoricalQuestion: ->
    @recordActivity("asking rhetorical questions in")

  latestActivityOf: (name) ->
    @activities[name.toLowerCase()]

  nameFor: (nameOrPronoun) ->
    switch nameOrPronoun.toLowerCase()
      when "i", "me" then @sender.name
      when "you", "yourself" then @robot.name
      else nameOrPronoun

  locationOf: (nameOrPronoun) ->
    name = @nameFor(nameOrPronoun)
    if @isRobot(name)
      @recordRhetoricalQuestion()
      "I was last seen answering rhetorical questions in this room less than a minute ago"
    else
      if @isSender(name)
        @recordRhetoricalQuestion()
        subject = "You were"

      activity = @latestActivityOf(name)
      if activity?
        subject ?= "#{activity.name} was"
        "#{subject} last seen #{activity.action} this room #{@elapsedTimeInWords(activity.when)} ago"
      else
        "Sorry, I don't know anything about #{name}"

  elapsedMinutesInWords: (minutes) ->
    if minutes == 0
      "less than a minute"
    else if minutes == 1
      "1 minute";
    else if minutes < 45
      "#{minutes} minutes"
    else if minutes < 90
      "about 1 hour"
    else if minutes < 1440
      "about #{Math.round(minutes / 60)} hours"
    else if minutes < 2160
      "about 1 day"
    else if minutes < 43200
      "#{Math.round(minutes / 1440)} days"
    else if minutes < 86400
      "about 1 month"
    else if minutes < 525600
      "#{Math.round(minutes / 43200)} months"
    else if minutes < 1051200
      "about 1 year"
    else
      "over #{Math.round(minutes / 525600)} years"

  elapsedTimeInWords: (date) ->
    milliseconds = new Date() - date
    minutes = Math.round(Math.abs(milliseconds / 60000))
    @elapsedMinutesInWords(minutes)

module.exports = (robot) ->

  withTracker = (callback) -> (msg) ->
    callback(msg, new Tracker(robot, msg.message.user))

  robot.brain.on "loaded", (data) ->
    data.whereis ?= {}
    for room, activities of data.whereis
      for name, activity of activities
        activity.when = new Date(activity.when)

  robot.enter withTracker (msg, tracker) ->
    tracker.recordActivity("entering")

  robot.leave withTracker (msg, tracker) ->
    tracker.recordActivity("leaving")

  robot.hear /.*/, withTracker (msg, tracker) ->
    tracker.recordActivity("posting to")

  robot.respond /where(?:'?s| ?is| am| are) ([^?]+)\??$/i, withTracker (msg, tracker) ->
    msg.reply(tracker.locationOf(msg.match[1].trim()))
