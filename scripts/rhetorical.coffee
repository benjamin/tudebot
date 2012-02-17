module.exports = (robot) ->
  robot.hear /rhetorical/i, (msg) ->
    msg.reply "Do I know what rhetorical means?"
