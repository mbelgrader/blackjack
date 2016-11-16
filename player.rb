class Player
  DECK = ['A','K','Q','J',10,9,8,7,6,5,4,3,2,1]

  attr_accessor :hand, :points, :status

  def initialize
    @hand = []
    @points = 0
    @status = nil
  end

  def setup_hand
    hand << get_card
    hand << get_card
    hand.each {|card| add_points(card)}
  end

  def get_card
    DECK.sample
  end

  def move(move_input)
    if move_input == "hit"
      @status = "hit"
      self.hit
    else
      @status = "stand"
    end
  end

  def hit
    card = get_card
    hand << card
    add_points(card)
  end

  def add_points(card)
    if card == 'A'
      puts "Your hand: #{hand}"
      puts "Do you want your ace to be 1 or 11?"
      card_points = gets.chomp.to_i
      @points += card_points
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
