lunchify = (text) ->
  text.replace('u', '').replace('U', '')

lunch_pattern = /(^|\W)launch(\W|$)/gi

module.exports = (robot) ->
  robot.hear cloud_pattern, (msg) ->
    msg.reply "I think you mean: #{msg.message.text.replace(launch_pattern, lunchify)}"

