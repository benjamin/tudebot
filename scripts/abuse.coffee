# Abuse.
#
# <abuse> - Bring it on.
# where is <nick> - Prints the date on which <nick> last posted.

module.exports = (robot) ->

  lastPostingsByRoom = {}

  robot.respond /sudo .*/i, (msg) ->
    insult msg, (phrase) ->
      msg.reply "Nice try, you #{phrase}"

  robot.respond /(?:abuse|insult) (.*)$/i, (msg) ->
    insult msg, (phrase) ->
      name = nameOf(msg.match[1], robot, msg)
      switch name
        when robot.name then msg.reply "Nice try, you #{phrase}"
        when msg.message.user.name then msg.reply "What kind of #{phrase} tries to abuse themselves?"
        else msg.send "#{name}: You are #{phrasePrefixedWithIndefiniteArticle(phrase)}"

  robot.respond /(?:you(?:'?re?)?|is) /i, (msg) ->
    insult msg, (phrase) ->
      msg.reply "And you're #{phrasePrefixedWithIndefiniteArticle(phrase)}"

  robot.respond /((?:get|fuck|suck|blow|eat|make|do|give|take|ride|go|.* your|keep) (?:.*))/i, (msg) ->
    insult msg, (phrase) ->
      msg.reply "No, #{personalizedPhrase(msg.match[1])}, you #{phrase}"

  robot.hear /.*/, (msg) ->
    return if msg.message.user.name == robot.name
    lastPostingsByName = lastPostingsByRoom[msg.message.user.room] ||= {}
    lastPostingsByName[msg.message.user.name.toLowerCase()] = new Date()

  robot.respond /where(?:'?s| ?is| ?am) ([^?]+)\??$/i, (msg) ->
    insult msg, (phrase) ->
      name = nameOf(msg.match[1], robot, msg)
      switch name
        when robot.name then msg.reply "I'm here, you #{phrase}"
        when msg.message.user.name then msg.reply "What kind of #{phrase} asks where they are?"
        else
          lastPostingsByName = lastPostingsByRoom[msg.message.user.room] || {}
          dateLastPosted = lastPostingsByName[name.toLowerCase()]
          if dateLastPosted
            msg.reply "#{name} last posted at #{dateLastPosted}"
          else
            msg.send "#{name}: Where are you, you #{phrase}?"

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
  if phrase.match /you$/i
    phrase
  else
    "you #{phrase}"

insult = (msg, callback) ->
  msg.http("http://www.insultsandabuse.com/generate_and_send.php")
    .headers
      "Accept": "*/*"
      "Content-Type": "application/x-www-form-urlencoded"
    .post("create_insult=\n") (err, res, body) ->
      matches = body.match /Your specially rolled insult is:.*?<h1>(.*?)<\/h1>/
      if matches
        callback matches[1].toLowerCase()
      else
        callback body
