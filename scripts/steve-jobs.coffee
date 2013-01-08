module.exports = (robot) ->
  robot.hear /(steve jobs|one more thing)/i, (msg) ->
    msg.reply "Boom!"
