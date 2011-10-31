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

farewells = [
  "Cya, cocksucker",
  "Adios, turdburgler",
  "I was beginning to think you'd never leave",
  "Good riddance!",
  "Yeah, and don't come back!",
  "That's right, fuck off!"
]

module.exports = (robot) ->
  robot.respond /(you(( are|'?re)( such a)?)?|is( such)? a) /i, (msg) ->
    msg.send "#{msg.message.user.name}: #{msg.random retorts}"

  robot.respond /(?:.* )?((?:get|fuck|suck|blow|eat) (?:.*))/i, (msg) ->
    abuse = msg.match[1]
    abuse = "you #{abuse}" unless abuse.match /you/i
    msg.send "#{msg.message.user.name}: No, #{abuse}"

  robot.hear /hipster/i, (msg) ->
    msg.send "speaking of hipsters: http://bit.ly/vSCmTB"

  robot.hear /^((any(way|hoo|how)|ok|well|right),? )?((good ?)?night|cya|see you|c u|later|I'?m off|bye)/i, (msg) ->
    msg.send "#{msg.random farewells}"
