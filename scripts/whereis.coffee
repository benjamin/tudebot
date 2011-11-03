module.exports = (robot) ->

  activity = {}

  isRobot = (name) ->
    name == robot.name

  sender = (msg) ->
    msg.message.user

  roomActivity = (room) ->
    activity[room] ||= {}

  registerActivity = (room, name, action) ->
    roomActivity(room)[name.toLowerCase()] = {who: name, doing: action, when: new Date()} unless isRobot(name)

  registerMessageActivity = (msg, action) ->
    user = sender(msg)
    registerActivity(user.room, user.name, action)

  latestActivity = (room, name) ->
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
      "about #{(minutes / 60).round()} hours"
    else if minutes < 2160
      "about 1 day"
    else if minutes < 43200
      "#{(minutes / 1440).round()} days"
    else if minutes < 86400
      "about 1 month"
    else if minutes < 525600
      "#{(minutes / 43200).round()} months"
    else if minutes < 1051200
      "about 1 year"
    else
      "over #{(minutes / 525600).round()} years"

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
    name = msg.match[1]
    msg.send("Looking for activity on '#{name}'")
    if activity = latestActivity(sender(msg).room, name)
      msg.reply "#{activity.who} was last seen #{activity.doing} this room #{elapsedTimeInWords(activity.when)} ago"
    else
      msg.reply "Sorry, I don't know anything about #{name}"
