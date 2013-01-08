module.exports = (robot) ->
  robot.hear /but for/gi, (msg) ->
    msg.reply "What's a butt for?"

  robot.hear /what('?s| is) a butt? for/gi, (msg) ->
    msg.reply "Why pooping, silly!"
