#todo: refactor to have a game beneath the outer blackjack model
class window.App extends Backbone.Model

  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', player = deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    player.on 'scoreUpdate', @checkScore, @
    player.on 'stand', @dealerPlays, @

  checkScore: (score, participant) ->
    if @returnScore(score) > 21 then @gameOver()
  
  dealerPlays: ->
    @get('dealerHand').models[0].flip()

    until @returnScore(@get('dealerHand').myScore) >= 17
      @get('dealerHand').hit()
    @gameOver()

  gameOver: (score, participant) ->
    playerScore = @returnScore(@get('playerHand').myScore)
    dealerScore = @returnScore(@get('dealerHand').myScore)
    console.log('player', playerScore, 'dealer', dealerScore)

    if playerScore > 21
      #you bust!
      @trigger 'endRound', 'BUSTED', @
    else if playerScore == dealerScore
      #tie 
      @trigger 'endRound', 'DRAW', @
    else if playerScore > dealerScore || dealerScore > 21
      # 'You Win!'
      @trigger 'endRound', 'DEUCES WILD', @
    else
    # you lose!
      console.log 'never seen'
      @trigger 'endRound', 'LOSER', @
    setTimeout @gameReset.bind(@), 2000

  gameReset: ->
    @initialize()
    @trigger 'gameReset', @

  returnScore: (myScore) ->
    if myScore.length is 2
      if myScore[1] <= 21 then myScore[1] else myScore[0]
    else
      myScore[0]