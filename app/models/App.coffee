#todo: refactor to have a game beneath the outer blackjack model
class window.App extends Backbone.Model

  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', player = deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    player.on 'scoreUpdate', @checkScore, @
    player.on 'stand', @dealerPlays, @

  checkScore: (score, participant) ->
    if score > 21 then @gameOver(score, participant)
  
  dealerPlays: ->
    @get('dealerHand').models[0].flip()

    until @returnScore(@get('dealerHand').myScore) >= 17
      @get('dealerHand').hit()
    @gameOver()

  gameOver: (score, participant) ->
    if @get('playerHand').myScore > 21
      #you bust!
      @trigger 'endRound', 'BUSTED', @
    else if @get('playerHand').myScore == @get('dealerHand').myScore
      #tie 
      alert 'else if'
    else if @get('playerHand').myScore > @get('dealerHand').myScore || @get('dealerHand').myScore > 21
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
      if 17 <= myScore[1] <= 21
        myScore[1]
    else
      myScore[0]