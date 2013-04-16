module.exports = (robot) ->
  robot.hear /([0-9]+%)/, (msg) ->
    msg.reply "#{msg.match?[1]}? Why would anyone even bother?"
