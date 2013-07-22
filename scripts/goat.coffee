module.exports = (robot) ->
  robot.hear /float/i, (msg) ->
    msg.reply "http://mrclark.aretesys.com/float-goat.png"
