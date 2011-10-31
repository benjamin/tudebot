# Abuse.
#
# Abuse your robot.

responses = [
  "Takes one to know one.",
  "I know you are, you said you are, so what am I?",
  "Same to you cunty.",
  "That's enough out of you arsewipe.",
  "Could be worse, I could be mrowe.",
  "At least I don't look like a scruttocks.",
  "Don't mention it fuck face."
]

module.exports = (robot) ->
  robot.respond /(suck|dip shit|retard)/i, (msg) ->
    msg.send msg.random responses
