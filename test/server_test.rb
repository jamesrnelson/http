require 'faraday'
require './test/test_helper.rb'
require './lib/server.rb'

class ServerTest < Minitest::Test
  # def setup
  #   @server = Server.new(9292).start
  # end
  #
  # def teardown
  #   @server.close
  # end

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
    request = Faraday.get('http://127.0.0.1:9292/datetime')

    assert request.body.include?('Total')
  end

  def test_path_comes_from_request_lines

  end

  def test_headers_method

  end

  def test_response_method

  end

  def test_router_directs_messages

  end

  def test_output_for_default_path

  end

  def test_output_for_hello_path_has_counter

  end

end
