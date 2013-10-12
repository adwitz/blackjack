describe 'deck', ->
  deck = null
  hand = null

  beforeEach ->
    deck = new Deck()
    hand = deck.dealPlayer()
    spyOn window, 'confirm'


  describe 'hit', ->
    it "should give the last card from the deck", ->
      expect(deck.length).toBe 50
      expect(deck.last()).toEqual hand.hit()
      expect(deck.length).toBe 49
      expect(deck.last()).toEqual hand.hit()
      expect(deck.length).toBe 48

  #how do i set property values
    it "should let player know they've busted", ->
      hand.hit() until hand.scores() > 21
      expect(confirm).toHaveBeenCalled

    # it "should should not let the player hit after reaching 21", ->
    #   hand.score = 21

    # it "should not allow player to hit after pressing stand", ->
    #   expect(deck.length).toBe 50
    #   expect(deck.last()).toEqual hand.hit()
    #   expect(deck.length).toBe 49
    #   hand.stand()
    #   hand.hit()
    #   expect(deck.last()).toEqual 49

    # it "should defer to the dealer after the player presses stand", ->
    #   expect x

# describe("A spy", function() {
#   var foo, bar = null;

#   beforeEach(function() {
#     foo = {
#       setBar: function(value) {
#         bar = value;
#       }
#     };

#     spyOn(foo, 'setBar');

#     foo.setBar(123);
#     foo.setBar(456, 'another param');
#   });