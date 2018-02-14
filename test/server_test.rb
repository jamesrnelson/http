require 'faraday'
require './test/test_helper.rb'

class ServerTest < Minitest::Test
  def test_default_path
    response = Faraday.get('http://127.0.0.1:9292/')

    assert response.include?('This is the default output.')
  end

  def test_client_loop_gives_request_lines

  end

  def test_current_time_method

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

  def test_output_for_date_time_has_current_time

  end

  def test_output_for_shutdown_closes_server_and_has_total_count

  end

end
