class Dealer
  DECK = ['A','K','Q','J',10,9,8,7,6,5,4,3,2,1]

  attr_accessor :hand, :points, :status

  def initialize
    @hand = []
    @points = 0
    @status = nil
  end

  def setup_hand
    2.times { hit }
  end

  def move
    if points < 17
      hit
      @status = "hit"
    else
      @status = "stand"
    end
  end

  def hit
    card = get_card
    hand << card
    add_points(card)
  end

  def get_card
    new_card = DECK.sample
  end

  def add_points(card)
    if card == 'A'
      @points += 1
    elsif card.is_a?(String)
      @points += 10
    else
      @points += card
    end
  end

  def bust
    points > 21
  end

end
