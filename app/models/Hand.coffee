class window.Hand extends Backbone.Collection

  model: Card

  initialize: (array, @deck, @isDealer) ->
    @myScore is 0
    @myHealth is 100 # what is going to prevent this from resetting?

  hit: -> 
    @add(@deck.pop()).last()
    @trigger 'scoreUpdate', @scores() , @


  stand: -> 
    @trigger 'stand', @

  scores: ->
    # The scores are an array of potential scores.
    # Usually, that array contains one element. That is the only score.
    # when there is an ace, it offers you two scores - the original score, and score + 10.
    hasAce = @reduce (memo, card) ->   # reduce not called with _.()?
      memo or card.get('value') is 1
    , false
    score = @reduce (score, card) ->
      score + if card.get 'revealed' then card.get 'value' else 0
    , 0
    @myScore = score = if hasAce then [score, score + 10] else [score]
    score