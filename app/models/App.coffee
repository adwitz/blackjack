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
    console.log @get('dealerHand').models[0]
    @get('dealerHand').models[0].flip()

  gameOver: (score, participant) ->
    if !participant.isDealer then confirmation = confirm score + ": you busted! play again?"
    if confirmation is true then @gameReset()

  gameReset: ->
    @initialize()
    @trigger 'gameReset', @

