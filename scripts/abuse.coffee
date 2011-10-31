# Abuse.
#
# <abuse> - Bring it on.

retorts = [
  "Takes one to know one",
  "I know you are, you said you are, so what am I?",
  "Same to you cunty",
  "That's enough out of you arse wipe",
  "Could be worse, I could be mrowe",
  "At least I don't look like a scruttocks",
  "Don't mention it fuck face",
  "Blow me"
]

greetings = [
  "Where the fuck have you been?",
  "About time you showed up, you lazy fuck",
  "Had a little sleep in, did we?",
  "About fucking time you showed up, it's as boring as batshit in here.",
  "Oh fuck, not you!"
]

farewells = [
  "Cya cocksucker",
  "Adios, turdburgler",
  "Finally!",
  "I was beginning to think you'd never leave",
  "Good riddance!",
  "And don't come back!",
  "That's right, fuck off!"
]

module.exports = (robot) ->
  robot.respond /(you('?re(such )? a)?|is a) /i, (msg) ->
    msg.send "#{msg.message.user.name}: #{msg.random retorts}"

  robot.respond /(?:.* )?((?:get|fuck|suck|blow|eat) (?:.*))/i, (msg) ->
    msg.send "#{msg.message.user.name}: No, you #{msg.match[1]}"

  robot.hear /hipster/i, (msg) ->
    msg.send "http://lh5.googleusercontent.com/-4fBmLnw8NZY/AAAAAAAAAAI/AAAAAAAAAAA/j-Aj19PYz9Y/photo.jpg"

  robot.hear /^((any(way|hoo|how)|ok|well|right),? )?((good ?)?night|cya|see you|c u|later|I'?m off)/i, (msg) ->
    msg.send msg.random farewells

  robot.hear /^((good ?)?morning|hiya|howdy|g'?day|ladies)/i, (msg) ->
    msg.send msg.random greetings
