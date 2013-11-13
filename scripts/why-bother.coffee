module.exports = (robot) ->
  robot.hear /only\s+([0-9]+%)/i, (msg) ->
    msg.reply "#{msg.match?[1]}? Why would anyone even bother?"
