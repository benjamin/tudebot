clownify = (text) ->
  text.replace('u', 'w').replace('U', 'W').replace('d', 'n').replace('D', 'N')

lunchify = (text) ->
  text.replace(/a/i, '')

wangify = (text) ->
  text.replace('d', 'g').replace('D', 'G')

cloud_pattern = /(?:^|\W)cloud/gi
launch_pattern = /(?:^|\W)launch/gi
wand_pattern = /(?:^|\W)wand/gi

hear_pattern = /(?:^|\W)(launch|cloud|wand)/gi

module.exports = (robot) ->
  robot.hear hear_pattern, (msg) ->
    msg.reply "I think you mean: #{msg.message.text.replace(cloud_pattern, clownify).replace(launch_pattern, lunchify).replace(wand_pattern, wangify)}"
