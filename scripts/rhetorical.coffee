module.exports = (robot) ->
  robot.hear /rehtorical/i, (msg) ->
    msg.reply "Do I know what rhetorical means?"
