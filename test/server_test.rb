require 'minitest/autorun'
require 'minitest/pride'
require './lib/server'

class ServerTest < Minitest::Test
  def test_the_server_exists
    server = Server.new(9292)

    assert_instance_of Server, server
  end

  def test_start_method

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
