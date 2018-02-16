require './lib/server'
require './lib/output'
require 'pry'

# Takes in verb and path and directs to appropriate output
class Router
  attr_reader :server, :request_lines, :path, :router
  def initialize(server)
    @server = server
    @output = Output.new(server)
  end

  def path
    server.request_lines[0].split[1]
  end

  def verb
    server.request_lines[0].split[0]
  end

  def verb_router
    router_post if verb == 'POST'
    router_get if verb == 'GET'
  end

  def router_get
    @output.default_output if path == '/'
    @output.hello_world_message if path == '/hello'
    @output.datetime_message if path == '/datetime'
    @output.shutdown if path == '/shutdown'
    @output.search_dictionary if path.start_with?('/word_search')
    @output.game_info if path == '/game'
  end

  def router_post
    if path == '/start_game'
      @output.start_game
    elsif path == '/game'
      @output.record_guess
    end
  end
end
