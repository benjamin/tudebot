nameOf = (subject, robot, msg) ->
  switch subject.toLowerCase()
    when "me", "i" then msg.message.user.name
    when "yourself" then robot.name
    when msg.message.user.name.toLowerCase() then msg.message.user.name
    else subject.trim()

phrasePrefixedWithIndefiniteArticle = (phrase) ->
  if phrase.match /^h?[aeiou]/i
    "an #{phrase}"
  else
    "a #{phrase}"

personalizedPhrase = (phrase) ->
  if phrase.match /(^i('?ve| have|'?m| am|'?ll| will)|you$)/i
    phrase
  else
    "you #{phrase}"

insult = (msg, callback) ->
  msg.http("http://www.insultsandabuse.com/generate_and_send.php")
    .headers
      "Accept": "*/*"
      "Content-Type": "application/x-www-form-urlencoded"
    .post("create_insult=\n") (err, res, body) ->
      matches = body.match /Your specially rolled insult is:.*?<h1>(.*?)<\/h1>/i
      if matches
        callback matches[1].toLowerCase()
      else
        callback body

module.exports = (robot) ->

  robot.respond /what do you think (?:of|about) ([^?]+)\??$/i, (msg) ->
    insult msg, (phrase) ->
      name = nameOf(msg.match[1], robot, msg)
      switch name
        when robot.name then msg.reply "I am "
        when msg.message.user.name then msg.reply "You are #{phrasePrefixedWithIndefiniteArticle(phrase)}"
        else msg.send "#{name} is #{phrasePrefixedWithIndefiniteArticle(phrase)}"

  robot.respond /sudo .*/i, (msg) ->
    insult msg, (phrase) ->
      msg.reply "Nice try, you #{phrase}"

  robot.respond /(?:abuse|insult) (.+)$/i, (msg) ->
    insult msg, (phrase) ->
      name = nameOf(msg.match[1], robot, msg)
      switch name
        when robot.name then msg.reply "Nice try, you #{phrase}"
        when msg.message.user.name then msg.reply "What kind of #{phrase} tries to abuse themselves?"
        else msg.send "#{name}: You are #{phrasePrefixedWithIndefiniteArticle(phrase)}"

  robot.respond /(?:you(?:'?re?)?|is) /i, (msg) ->
    insult msg, (phrase) ->
      msg.reply "And you're #{phrasePrefixedWithIndefiniteArticle(phrase)}"

  robot.respond /((?:get|fuck|suck|blow|lick|poke|eat|make|do|give|take|ride|go|.* your|keep|why) (?:.*))/i, (msg) ->
    insult msg, (phrase) ->
      msg.reply "No, #{personalizedPhrase(msg.match[1])}, you #{phrase}"
