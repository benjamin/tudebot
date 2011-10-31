# It's alive!
#

module.exports = (robot) ->
  robot.hear /alice[:,.;]? (.*)/i, (msg) ->
    text = "#{msg.match?[1]}"
    alice msg, text, (response) ->
      msg.send response

  robot.hear /^(.+alice.*)/i, (msg) ->
    text = "#{msg.match?[1]}"
    alice msg, text, (response) ->
      msg.send response

alice = (msg, text, callback) ->
  msg.http("http://www.pandorabots.com/pandora/talk")
    .query(input: text, botid: "f5d922d97e345aa1", botcust2: "a47d79b2be70536d", skin: 'custom_input')
    .post() (err, res, body) ->
      parts = body.split("ALICE:")
      callback parts[parts.length-1].split("\n")[0].replace(/<\/?[^>]*>/, "").trim()

