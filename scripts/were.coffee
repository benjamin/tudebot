module.exports = (robot) ->

  robot.hear /.?(wish|only).? (I|that( I?)) was/i, (msg) ->
    msg.reply "were"
