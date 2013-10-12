#todo: refactor to have a game beneath the outer blackjack model
class window.App extends Backbone.Model

  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', player = deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    player.on 'scoreUpdate', @checkScore, @

  checkScore: (score, participant) ->
    if score > 21 then @gameOver(score, participant)

  gameOver: (score, participant) ->
    if !participant.isDealer then @gameReset() # confirmation = confirm score + ": you busted! play again?"
    # if confirmation then @gameReset()

  gameReset: ->
    console.log 'here'
    @initialize()
    @trigger 'gameReset', @

