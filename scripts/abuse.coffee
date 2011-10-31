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
  robot.respond /(you('re a)?|is a) /i, (msg) ->
    msg.send msg.random responses

  robot.respond /(?:.* )?((?:get|fuck|suck|blow|eat) (?:.*))/i, (msg) ->
    msg.send "No, you #{msg.match[1]}"

  robot.hear /hipster/i, (msg) ->
    msg.send "http://lh5.googleusercontent.com/-4fBmLnw8NZY/AAAAAAAAAAI/AAAAAAAAAAA/j-Aj19PYz9Y/photo.jpg"
