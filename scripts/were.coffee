module.exports = (robot) ->

  robot.hear /(if|wish) .* was/i, (msg) ->
    msg.reply "were"
