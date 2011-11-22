module.exports = (robot) ->

  robot.hear /(if|wish) .* was/i, (msg) ->
    msg.reply "were"

  robot.hear /((hence|reason) why)/i, (msg) ->
    msg.reply "Tautological, much?"

  robot.hear /its' /i, (msg) ->
    msg.reply "There is absolutely, positively, no such word as its'."

  robot.hear /(?:for|not|that(?:'?s| is)) (it's|they'?re)/i, (msg) ->
    msg.reply itsOrTheir(msg.match[1])

  robot.hear /(it's|they'?re) .* (?:was|is|has)/i, (msg) ->
    msg.reply itsOrTheir(msg.match[1])

  robot.hear /(its|their) (?:not|been|too)/i, (msg) ->
    msg.reply itIsOrTheyAre(msg.match[1])

itsOrTheir = (word) ->
  switch word.toLowerCase()
    when "it's" then "its"
    else "their"

itIsOrTheyAre = (word) ->
  switch word.toLowerCase()
    when "its" then "it's"
    else "they're"
