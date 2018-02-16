require './test/test_helper.rb'
require './lib/game.rb'

class GameTest < Minitest::Test
  def test_game_exists
    game = Game.new

    assert_instance_of Game, game
  end

  def test_game_tells_when_input_is_wrong_class
    game = Game.new

    actual = game.compare_answer_class('Eighty-seven')
    expected = 'Please enter a number.'

    assert_equal expected, actual
  end

  def test_game_tells_when_number_is_not_in_range
    game = Game.new

    actual = game.compare_answer_class(0)
    expected = 'Enter a valid whole number between 1 and 100.'

    assert_equal expected, actual

    actual = game.compare_answer_class(101)
    expected = 'Enter a valid whole number between 1 and 100.'

    assert_equal expected, actual
  end

  def test_game_tells_when_answer_is_correct
    game = Game.new(1, 1)

    expected = 'OMG! You guessed the right number!'
    actual = game.compare_answer_class(1)

    assert_equal expected, actual
  end

  def test_game_tells_when_answer_is_too_high
    game = Game.new(98, 98)

    expected = 'Your guess was too high!'
    actual = game.compare_answer_class(99)

    assert_equal expected, actual
  end

  def test_game_tells_when_anser_is_too_low
    game = Game.new(2, 2)

    expected = 'Your guess was too low!'
    actual = game.compare_answer_class(1)

    assert_equal expected, actual
  end
end
