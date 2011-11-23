module.exports = (robot) ->

  robot.hear /happy place/i, (msg) ->
    msg.reply "http://i.imgur.com/tOzxz.jpg"
