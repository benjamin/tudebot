module.exports = (robot) ->

  robot.hear /(if|wish) .* was/i, (msg) ->
    msg.reply "were"

  robot.hear /((hence|reason) why)/i, (msg) ->
    msg.reply "Tautological, much?"

  robot.hear /its' /i, (msg) ->
    msg.reply "There is absolutely, positively, no such word as its'."
