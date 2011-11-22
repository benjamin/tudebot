module.exports = (robot) ->

  robot.hear /(if|wish) .* was/i, (msg) ->
    msg.reply "were"

  robot.hear /((hence|reason) why)/i, (msg) ->
    msg.reply "Tautological, much?"

  robot.hear /its' /i, (msg) ->
    msg.reply "There is absolutely, positively, no such word as its'."

  robot.hear /(for|not|that('?s| is)) it's/i, (msg) ->
    msg.reply "its"

  robot.hear /it's .* (was|is|has)/i, (msg) ->
    msg.reply "its"

  robot.hear /its (been|too)/i, (msg) ->
    msg.reply "it's"
