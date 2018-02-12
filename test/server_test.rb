require 'minitest/autorun'
require 'minitest/pride'
require './lib/server'

class ServerTest < Minitest::Test
  def test_the_server_exists
    server = Server.new(9292)

    assert_instance_of Server, server
  end
end
