# The game of hangman.
#
# hangman <letterOrWord> - Make a guess
class Game

  constructor: (word) ->
    @word = word.toUpperCase()
    @wordLetters = @word.split(//)
    @answerLetters = ("_" for letter in @wordLetters)
    @remainingGuesses = 9
    @message = null

  isFinished: ->
    @wasAnswered() or @wasHung()

  wasAnswered: ->
    @answerLetters.indexOf("_") == -1

  wasHung: ->
    @remainingGuesses == 0

  guess: (guess) ->
    if guess
      guess = guess.trim().toUpperCase()
      if guess.length == 1
        @guessLetter(guess)
      else
        @guessWord(guess)
    else
      @noGuess()

  noGuess: ->
    @message = null

  guessLetter: (guess) ->
    indexes = (index for letter, index in @wordLetters when guess == letter)
    if indexes.length > 0
      @answerLetters[index] = @wordLetters[index] for index in indexes
      @correctGuess("Yes, there #{isOrAre(indexes.length, guess)}")
    else
      @incorrectGuess("Sorry, there are no #{guess}'s")

  guessWord: (guess) ->
    if guess == @word
      @answerLetters = @wordLetters
      @correctGuess("Yes, that's correct")
    else
      @incorrectGuess("Sorry, the word is not #{guess}")

  correctGuess: (message) ->
    @message = message

  incorrectGuess: (message) ->
    @remainingGuesses -= 1 if @remainingGuesses > 0
    @message = message

  eachMessage: (callback) ->
    callback @message if @message

    if @isFinished()
      if @wasHung()
        callback "You have no remaining guesses"
      else if @wasAnswered()
        callback "Congratulations!"

      callback "The #{@wordLetters.length} letter word was: #{@wordLetters.join(' ')}"
    else
      callback "The #{@answerLetters.length} letter word is: #{@answerLetters.join(' ')}"
      callback "You have #{pluralisedGuess(@remainingGuesses)} remaining"

module.exports = (robot) ->
  game = new Game("")

  robot.respond /hangman( .*)?$/i, (msg) ->

    if process.env.WORDNIK_API_KEY == undefined
      msg.send "Missing WORDNIK_API_KEY env variable."
      return

    play msg, game, (newGame) ->
      game = newGame
      game.guess(msg.match[1])
      game.eachMessage (message) -> msg.send(message)

play = (msg, game, callback) ->
  if game.isFinished()
    generateWord msg, (word) -> callback new Game(word)
  else
    callback game

generateWord = (msg, callback) ->
  msg.http("http://api.wordnik.com/v4/words.json/randomWord")
    .query
      hasDictionaryDef: true
      minLength: 5
    .headers
      api_key: process.env.WORDNIK_API_KEY
    .get() (err, res, body) ->
      result = JSON.parse(body)
      if result
        callback result.word
      else
        callback "hangman"

isOrAre = (count, letter) ->
  if count == 1
    "is one #{letter}"
  else
    "are #{count} #{letter}'s"

pluralisedGuess = (count) ->
  if count == 1
    "one guess"
  else
    "#{count} guesses"
