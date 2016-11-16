require 'colorize'
require_relative 'player.rb'
require_relative 'dealer.rb'

class Game
  attr_accessor :player, :dealer, :chips

  def initialize
    @player = Player.new
    @dealer = Dealer.new
    @chips = 100
    @deal = "yes"
  end


  def play
    until @deal == "no"

      system('clear')
      game_setup
      display
      bet = place_bet

      until over
        display
        if player.status != "stand"
          puts "\n Hit or Stand?"
          move_input = gets.chomp.downcase
          player.move(move_input)
        end
        dealer.move
      end

      display_winner(bet)

      puts "\n Chips: #{chips}".green
      puts "Play again?"
      @deal = gets.chomp.downcase
    end
  end

  def game_setup
    game_reset
    player.setup_hand
    dealer.setup_hand
  end

  def game_reset
    player.hand = []
    dealer.hand = []
    player.points = 0
    dealer.points = 0
    player.status = nil
    dealer.status = nil
  end


  def place_bet
    puts "Chips: #{chips}".green
    puts "How much would you like to bet?"
    bet = gets.chomp.to_i
  end

  def over
    return true if player.bust || dealer.bust
    return true if player.status == "stand" && dealer.status == "stand"
    false
  end

  def winner
    return "tie" if player.bust && dealer.bust
    return player if dealer.bust
    return dealer if player.bust
    return "tie" if player.points == dealer.points
    player.points > dealer.points ? player : dealer
  end

  def display
    system('clear')
    puts "Your hand: #{player.hand}".green
    puts "Dealer: #{dealer.hand} \n".red
  end

  def display_winner(bet)
    display
    if dealer.bust && player.bust
      puts "You both busted. It's a tie."
    elsif dealer.bust
      puts "\n Dealer busted! You win!".green
      @chips += bet
    elsif player.bust
      puts "\n You busted. Dealer wins."
      @chips -= bet
    elsif winner == "tie"
      puts "\n It's a tie."
    else
      if winner == player
        puts "\n You win!".green
        @chips += bet
      else
        puts "\n Dealer wins."
        @chips -= bet
      end
    end
  end

end

if __FILE__ == $PROGRAM_NAME
  game = Game.new
  game.play
end
