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
      #you b@returnScore(ust!
      @trigger 'endRound', 'BUSTED', @
    else if playerScore == dealerHand
      #tie 
      alert 'else if'
    else if playerScore > dealerHand || dealerHand > 21
      # 'You Win!'
      alert 'else if'
    else
    # you lose!
      alert 'nothing'
    setTimeout @gameReset.bind(@), 1500

  gameReset: ->
    @initialize()
    @trigger 'gameReset', @

  returnScore: (myScore) ->
    if myScore.length is 2
      if myScore[1] <= 21 then myScore[1] else myScore[0]
    else
      myScore[0]