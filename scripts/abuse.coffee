# Abuse.
#
# <abuse> - Bring it on.

module.exports = (robot) ->
  robot.respond /sudo .+/i, (msg) ->
    insult msg, (response) ->
      msg.send "#{msg.message.user.name}: Nice try, you #{response}"

  robot.respond /abuse (.*)$/i, (msg) ->
    insult msg, (response) ->
      msg.send "#{identified(msg, msg.match[1])}: You are #{articled(response)}"

  robot.respond /(?:you(?:'?re?)?|is) /i, (msg) ->
    insult msg, (response) ->
      msg.send "#{msg.message.user.name}: And you're #{articled(response)}"

  robot.respond /((?:get|fuck|suck|blow|eat|make|do|give|take|ride) (?:.*))/i, (msg) ->
    insult msg, (response) ->
      msg.send "#{msg.message.user.name}: No, #{personalized(msg.match[1])}, you #{response}"

identified = (msg, name) ->
  if name.toLowerCase() == "me"
    msg.message.user.name
  else
    name

articled = (phrase) ->
  if phrase.match /^h?[aeiou]/i
    "an #{phrase}"
  else
    "a #{phrase}"

personalized = (phrase) ->
  if phrase.match /you$/i
    phrase
  else
    "you #{phrase}"

insult = (msg, callback) ->
  msg.http("http://www.insultsandabuse.com/generate_and_send.php")
    .headers
      "Accept": "*/*"
      "Content-Type": "application/x-www-form-urlencoded",
    .post("create_insult=\n") (err, res, body) ->
      matches = body.match /Your specially rolled insult is:.*?<h1>(.*?)<\/h1>/
      if matches
        callback matches[1].toLowerCase()
      else
        callback body
