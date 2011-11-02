module.exports = (robot) ->
  robot.hear /I can'?t( really)? tell/i, (msg) ->
    msg.reply "You can tell me. I'm a doctor."

  robot.hear /I('?ve| have) never (.*)( before)?/i, (msg) ->
    msg.reply "You ever seen a grown man naked?"
