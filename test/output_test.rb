require './test/test_helper.rb'
require './lib/output'
require './lib/server'

class OutputTest < Minitest::Test
  def setup
    @server = Server.new(9292).start
  end

  def teardown
    @server.close
  end

  def test_output_exists
    output = Output.new()

    assert_instance_of Output, output
  end

  def test_default_output
    output = Output.new(@server)

    assert output.default_output.include?('This is the default output.')
  end
end
