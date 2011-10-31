# Abuse.
#
# <abuse> - Bring it on.

responses = [
  "Takes one to know one",
  "I know you are, you said you are, so what am I?",
  "Same to you cunty",
  "That's enough out of you arse wipe",
  "Could be worse, I could be mrowe",
  "At least I don't look like a scruttocks",
  "Don't mention it fuck face",
  "Blow me"
]

module.exports = (robot) ->
  robot.respond /^you(?:'re a)? (?:.+)$/i, (msg) ->
    msg.send msg.random responses

  robot.respond /^(?:no,? you )?(fuck off|get fucked|suck my (.*)|blow me)$/i, (msg) ->
    msg.send "no, you " + msg.match[1]
