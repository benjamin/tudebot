lunchify = (text) ->
  text.replace(/u/i, '')

launch_pattern = /(^|\W)launch/gi

module.exports = (robot) ->
  robot.hear launch_pattern, (msg) ->
    msg.reply "I think you mean: #{msg.message.text.replace(launch_pattern, lunchify)}"
