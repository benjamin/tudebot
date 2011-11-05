module.exports = (robot) ->

  robot.hear /I can'?t( really)? tell/i, (msg) ->
    msg.reply "You can tell me. I'm a doctor."

  robot.hear /I('?ve| have) never (.*)( before)?/i, (msg) ->
    msg.reply "You ever seen a grown man naked?"

  robot.hear /hospital\?/i, (msg) ->
    msg.reply "It's a big building with patients, but that's not important right now."
