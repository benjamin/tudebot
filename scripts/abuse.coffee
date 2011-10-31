# Abuse.
#
# Abuse your robot.

responses = [
  "Takes one to know one",
  "I know you are, you said you are, so what am I?",
  "Same to you cunty",
  "That's enough out of you arse wipe",
  "Could be worse, I could be mrowe",
  "At least I don't look like a scruttocks",
  "Don't mention it fuck face"
]

module.exports = (robot) ->
  robot.respond /(you suck|(you('re a)? )?(dip shit|retard|dickhead|dumb ass))/i, (msg) ->
    msg.send msg.random responses

  robot.respond /(fuck off|get fucked|suck my (.*))$/i, (msg) ->
    msg.send "no, you " + msg.match[1]
