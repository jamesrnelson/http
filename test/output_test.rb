require './test/test_helper.rb'
require './lib/output'
require './lib/server'

class OutputTest < Minitest::Test
  # def setup
  #   @server = TCPServer.new(9292)
  # end
  #
  # def teardown
  #   @server.close
  # end

  def test_output_exists
    output = Output.new(@server)

    assert_instance_of Output, output
  end

  def test_default_output
    output = Output.new(@server)
    output.default_output

    assert_equal 'This is the default output.', output.message
  end

  def test_current_time
    output = Output.new(@server)
    date = Time.now

    assert_equal date.strftime('%l:%M%p on %A, %B %-d, %Y.'), output.current_time
  end
end
