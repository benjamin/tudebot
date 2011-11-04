module.exports = (robot) ->

  activities = robot.brain.data.whereis ||= {}

  sender = (msg) ->
    msg.message.user

  isSameName = (a, b) ->
    a.toLowerCase() == b.toLowerCase()

  isRobot = (name) ->
    isSameName(name, robot.name)

  isSenderOf = (name, msg) ->
    isSameName(name, sender(msg).name) or isSameName(name, "i") or isSameName(name, "me")

  roomActivity = (room) ->
    console.log("Looking for activity for room %s", room)
    activities[room] ||= {}

  registerActivity = (room, name, action) ->
    roomActivity(room)[name.toLowerCase()] = {name: name, action: action, when: new Date()} unless isRobot(name)

  registerMessageActivity = (msg, action) ->
    user = sender(msg)
    registerActivity(user.room, user.name, action)

  registerRhetoricalQuestionActivity = (msg) ->
    registerMessageActivity(msg, "asking rhetorical questions in")

  latestActivity = (room, name) ->
    console.log("Looking for activity for %s in room %s", name, room)
    roomActivity(room)[name.toLowerCase()]

  elapsedMinutesInWords = (minutes) ->
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

  elapsedTimeInWords = (date) ->
    milliseconds = new Date() - date
    minutes = Math.round(Math.abs(milliseconds / 60000))
    elapsedMinutesInWords(minutes)

  robot.enter (msg) ->
    registerMessageActivity(msg, "joining")

  robot.leave (msg) ->
    registerMessageActivity(msg, "leaving")

  robot.hear /.*/, (msg) ->
    registerMessageActivity(msg, "posting to")

  robot.respond /where(?:'?s| ?is| ?am) ([^?]+)\??$/i, (msg) ->
    name = msg.match[1].trim()

    if isRobot(name)
      registerRhetoricalQuestionActivity(msg)
      msg.reply "I was last seen answering rhetorical questions in this room less than a minute ago"
    else
      if isSenderOf(name, msg)
        registerRhetoricalQuestionActivity(msg)
        subject = "You were"

      activity = latestActivity(sender(msg).room, name)
      if activity?
        subject ||= "#{activity.name} was"
        msg.reply "#{subject} last seen #{activity.action} this room #{elapsedTimeInWords(activity.when)} ago"
      else
        msg.reply "Sorry, I don't know anything about #{name}"
