require 'faraday'
require './test/test_helper.rb'
require './lib/server.rb'

class ServerTest < Minitest::Test
  def test_default_path

    request = Faraday.get('http://127.0.0.1:9292/')

    assert request.body.include?('This is the default output.')
  end

  def test_hello_world_path

    request = Faraday.get('http://127.0.0.1:9292/hello')

    assert request.body.include?('Hello, World!')
  end

  def test_current_time_path

    request = Faraday.get('http://127.0.0.1:9292/datetime')

    assert request.body.include?('2018')
  end

  def test_shutdown_output
    request = Faraday.get('http://127.0.0.1:9292/shutdown')

    assert request.body.include?('Total')
  end

  def test_unknown_path
    request = Faraday.get('http://127.0.0.1:9292/monsters')

    assert request.body.include?('Unknown Path')
  end

  def test_search_dictionary
    request = Faraday.get('http://127.0.0.1:9292/word_search?param=monster')

    assert request.body.include?('MONSTER is a known word.')
  end

  # def test_post_to_start_game
  #   request = Faraday.post('http://127.0.01:9292/start_game')
  #
  #   assert request.body.include?('Good luck!')
  # end
end
