module.exports = (robot) ->

  robot.hear /(if|wish) .* was/i, (msg) ->
    msg.reply "were"

  robot.hear /((hence|reason) why)/i, (msg) ->
    msg.reply "#{msg.match[1]}, seriously?"
