require './lib/output'
# This is the number guessing game that the user will play online
class Game
  attr_reader :server

  def initialize(server, a = 1, b = 100)
    @random_number = rand(a..b)
    @output = Output.new(server)
  end

  def compare_answer_class(player_input)
    if player_input.class != Integer
      @output.message = 'Please enter a number.'
      @output.output
    elsif player_input.class == Integer
      compare_values(player_input)
    end
  end

  def compare_values(player_input)
    if player_input < 1 || player_input > 100
      @output.message = 'Enter a valid whole number between 1 and 100.'
    elsif player_input == @random_number
      @output.message = 'OMG! You guessed the right number!'
    elsif player_input > @random_number
      @output.message = 'Your guess was too high!'
    elsif player_input < @random_number
      @output.message = 'Your guess was too low!'
    end
    @output.output
  end
end
