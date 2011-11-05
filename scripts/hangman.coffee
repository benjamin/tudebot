# The game of hangman.
#
# hangman - Display the state of the current game.
# hangman <letterOrWord> - Make a guess.

class Game

  constructor: (word) ->
    @word = word.toUpperCase()
    @wordLetters = @word.split(//)
    @answerLetters = ("_" for letter in @wordLetters)
    @remainingGuesses = 9
    @previousGuesses = []
    @message = null

  isFinished: ->
    @wasAnswered() or @wasHung()

  wasAnswered: ->
    "_" not in @answerLetters

  wasHung: ->
    @remainingGuesses == 0

  guess: (guess) ->
    if !guess
      @noGuess()
      return

    guess = guess.trim().toUpperCase()

    if guess in @previousGuesses
      @duplicateGuess(guess)
    else
      @previousGuesses.push(guess)
      switch guess.length
        when 1 then @guessLetter(guess)
        when @word.length @guessWord(guess)
        else @errantWordGuess(guess)

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

  noGuess: ->
    @message = null

  errantWordGuess: (guess) ->
    @message = "The word #{guess} isn't the correct length so let's pretend that never happened, shall we?"

  duplicateGuess: (guess) ->
    @message = "You already tried #{guess} so let's pretend that never happened, shall we?"

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
  gamesByRoom = {}

  robot.respond /hangman( .*)?$/i, (msg) ->

    if process.env.WORDNIK_API_KEY == undefined
      msg.send "Missing WORDNIK_API_KEY env variable."
      return

    room = msg.message.user.room

    play msg, gamesByRoom[room], (game) ->
      gamesByRoom[room] = game
      game.guess(msg.match[1])
      game.eachMessage (message) -> msg.send(message)

play = (msg, game, callback) ->
  if !game or game.isFinished()
    generateWord msg, (word) -> callback new Game(word)
  else
    callback game

generateWord = (msg, callback) ->
  msg.http("http://api.wordnik.com/v4/words.json/randomWord")
    .query
      hasDictionaryDef: true
      minDictionaryCount: 3
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
