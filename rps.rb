
module Console
  def self.clear_screen
    system('cls')
    system('clear')
  end

  def self.get_input(msg = nil)
    puts "\n~> #{msg} :" unless msg == nil
    gets.chomp.to_s
  end

  def self.display_banner(msg)
    puts "~*~*~*~*~*~*~*~*~*~ #{msg} ~*~*~*~*~*~*~*~*~*~\n\n"
  end
end

class Player
  attr_reader :choice, :choices, :score

  def initialize
    @choice = nil
    @choices = {'r' => 'Rock', 'p' => 'Paper', 's' => 'Scissors'}
    @score = 0
  end

  def get_choice
    @choice = nil
    @choice = choices[Console.get_input('Please make a choice [r, p, s]').downcase] until @choice != nil
  end

  def increment_score(value = 1)
    @score += value
  end

  def random_choice
    @choice = choices[choices.keys.sample]
  end
end

class Game
  attr_reader :player, :computer, :choices, :done

  def initialize
    @player = Player.new
    @computer = Player.new
    @done = false
  end

  def run
    Console.clear_screen
    Console.display_banner("Let's Play Rock, Paper, Scissors!")

    @player.get_choice
    @computer.random_choice

    puts "\n"
    check_results
    display_scores

    play_again = {'y' => true, 'n' => false}
    @done = !play_again[Console.get_input('Play Again? [y/N]').downcase]
    run if !done
  end

  def display_scores
    puts "\tScore\n\t~*~*~*~*~*~*~*~*~*~*~\n\tYou:\t\t#{@player.score}\n\tComputer:\t#{@computer.score}\n"
  end

  def check_results
    case player.choice
      when 'Rock'
        win if computer_choice?('Scissors')
        lose if computer_choice?('Paper')
      when 'Paper'
        win if computer_choice?('Rock')
        lose if computer_choice?('Scissors')
      when 'Scissors'
        win if computer_choice?('Paper')
        lose if computer_choice?('Rock')
    end

    draw if @player.choice == @computer.choice
  end

  def win
    Console.display_banner "#{@player.choice} beats #{@computer.choice}. You Win!"
    @player.increment_score
  end

  def lose
    Console.display_banner "#{@computer.choice} beats #{@player.choice}. You Lose :("
    @computer.increment_score
  end

  def draw
    Console.display_banner "You and the computer both chose #{@player.choice}. It's a draw."
  end

  def computer_choice?(choice)
    if @computer.choice == choice
      return true
    else
      return false
    end
  end
end

rps_game = Game.new
rps_game.run