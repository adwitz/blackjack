class window.Deck extends Backbone.Collection

  model: Card
  #confirm 'Do you want to play again?'
  initialize: ->
    @add _(_.range(1, 53)).shuffle().map (card) ->
      new Card
        rank: card % 13
        suit: Math.floor(card / 13) # how to handle card 52? 52/13 === 4

  dealPlayer: -> hand = new Hand [ @pop(), @pop() ], @

  dealDealer: -> new Hand [ @pop().flip(), @pop() ], @, true
