lunchify = (text) ->
  text.replace(/a/i, '')

launch_pattern = /(^|\W)launch/gi

module.exports = (robot) ->
  robot.hear launch_pattern, (msg) ->
    msg.reply "I think you mean: #{msg.message.text.replace(launch_pattern, lunchify)}"
