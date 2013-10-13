class window.HandView extends Backbone.View

  className: 'hand'

  #todo: switch to mustache
  template: _.template '<h2 class="score"><% if(isDealer){ %>Dealer<% }else{ %>Player<% } %><br/><div class="healthBar"></div><br/>( Score: <span></span> )</h2>'

  initialize: ->
    @collection.on 'add remove change', => @render()
    @render()

  render: ->
    @$el.children().detach()
    @$el.html @template @collection
    @$el.append @collection.map (card) ->
      new CardView(model: card).$el
    #why use @.$
    @$('.score span').text @collection.scores()[0] + if @collection.scores().length is 2 then ' or ' + @collection.scores()[1] else '' 
