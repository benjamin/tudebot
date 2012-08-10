clownify = (text) ->
  text.replace('u', 'w').replace('U', 'W').replace('d', 'n').replace('D', 'N')

cloud_pattern = /(^|\W)cloud(\W|$)/gi

module.exports = (robot) ->
  robot.hear cloud_pattern, (msg) ->
    msg.reply "#{msg.message.user.name}: I think you mean: #{msg.message.text.replace(cloud_pattern, clownify)}"

