acknowledgements = [
  "Roger that!",
  "What's our vector, Victor?",
  "Unger."
]

oveur_ever = [
  "You ever been in a cockpit before?",
  "You ever seen a grown man naked?",
  "Have you ever been in a Turkish prison?"
]

module.exports = (robot) ->

  robot.hear /surely you/i, (msg) ->
    msg.reply "I am, and don't call me Shirley."

  robot.hear /I can'?t (.* )?tell/i, (msg) ->
    msg.reply "You can tell me. I'm a doctor."

  robot.hear /I('?ve| have) never/i, (msg) ->
    msg.reply msg.random oveur_ever

  robot.hear /hospital\?/i, (msg) ->
    msg.reply "It's a big building with patients, but that's not important right now."

  robot.hear /\WOVER\W/, (msg) ->
    msg.reply msg.random acknowledgements
