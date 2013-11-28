module.exports = (robot) ->

  robot.hear /happy\s+place/i, (msg) ->
    msg.reply "http://i.imgur.com/tOzxz.jpg"
