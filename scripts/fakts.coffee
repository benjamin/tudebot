# Returns a random fakt
#
# fakt me - Returns a random fact. Great conversation starters!

module.exports = (robot) ->
  robot.respond /(fakt)( me)?/i, (msg) ->
    fakt msg, msg.random(fakt_sources()), (result) ->
      msg.send result

rand = (from, to) ->
  Math.floor(Math.random() * (to - from + 1) + from)

fakt_sources = ->
  [
    {url: "http://www.mentalfloss.com/amazingfactgenerator/", regex: /<div class="amazing_fact_body">\s*<p>(.+)<\/p>/m, params: {p: rand(10, 1200)}},
    {url: "http://www.randomfunfacts.com/", regex: /<strong><i>([\s\S]+)<\/i><\/strong>/m, params: {}}
  ]

fakt = (msg, source, callback) ->
  msg.http(source.url)
    .query(source.params)
    .get() (err, res, body) ->
      callback body.match(source.regex)?[1] || "No fakt for you!"