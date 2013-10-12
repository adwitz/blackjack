class window.AppView extends Backbone.View

  template: _.template '
    <div class="player-hand-container"></div>
    <div class="dealer-hand-container"></div>
    <span class="hit-button">Hit</span> <span class="stand-button">Defend</span>
    <span class="endRound"></span>
  '

  events:
    "click .hit-button": -> @model.get('playerHand').hit()
    "click .stand-button": -> @model.get('playerHand').stand()

  initialize: -> 
    @model.on 'gameReset', @render, @
    @model.on 'endRound', @endGame, @
    @render()

  endGame: (message) ->
    $('.endRound').html(message)
    $('.endRound').delay().fadeOut(1500)

  render: ->
    @$el.children().detach()
    @$el.html @template()
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el

# <button class="hit-button">Hit</button> <button class="stand-button">Defend</button>
