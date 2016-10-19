# Description:
#   Detect tweet URL and send tweet content
#
# Dependencies:
#  "twitter": "1.4.0"
#  "underscore": "1.5.1"
#
# Configuration:
#   HUBOT_TWITTER_CONSUMER_KEY
#   HUBOT_TWITTER_CONSUMER_SECRET
#   HUBOT_TWITTER_ACCESS_TOKEN_KEY
#   HUBOT_TWITTER_ACCESS_TOKEN_SECRET
#
# Commands:
#   None
#
# Author:
#   Vrtak-CZ, kdaigle

twitter = require 'twitter'
_ = require 'underscore'

find_media = (tweet_text, media, links) ->
  url = media.video_info?.variants?[0].url
  if not url?
    url = media.media_url
  if url?
    new_text = tweet_text.replace(media.url, url)
    if new_text == tweet_text
      links.push(url)
    new_text
  else
    tweet_text

show_tweet = (msg, prefix, tweet) ->
  links = []
  tweet_text = _.unescape(tweet.full_text)
  if tweet.entities?.urls?
    for url in tweet.entities.urls
      tweet_text = tweet_text.replace(url.url, url.expanded_url)
  if tweet.extended_entities?.media?
    for media in tweet.extended_entities.media
      tweet_text = find_media(tweet_text, media, links)
  msg.send "#{prefix}@#{tweet.user.screen_name}: #{tweet_text}"
  for link in links
    msg.send "- #{link}"
  if tweet.quoted_status?
    show_tweet(msg, "... ", tweet.quoted_status)

module.exports = (robot) ->
  auth =
    consumer_key:           process.env.HUBOT_TWITTER_CONSUMER_KEY,
    consumer_secret:        process.env.HUBOT_TWITTER_CONSUMER_SECRET,
    access_token_key:       process.env.HUBOT_TWITTER_ACCESS_TOKEN_KEY,
    access_token_secret:    process.env.HUBOT_TWITTER_ACCESS_TOKEN_SECRET

  if not auth.consumer_key or not auth.consumer_secret or not auth.access_token_key or not auth.access_token_secret
    console.log "twitter-content.coffee: HUBOT_TWITTER_CONSUMER_KEY, HUBOT_TWITTER_CONSUMER_SECRET,
    HUBOT_TWITTER_ACCESS_TOKEN_KEY, and HUBOT_TWITTER_ACCESS_TOKEN_SECRET are required."
    return

  twit = new twitter auth

  robot.hear /https?:\/\/(mobile\.)?twitter\.com\/.*?\/status\/([0-9]+)/i, (msg) ->
    twit.get "statuses/show/#{msg.match[2]}", {tweet_mode: "extended"}, (err, tweet, response) ->
      if err
        console.log err
        return
      show_tweet(msg, "", tweet)

