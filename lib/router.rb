require './lib/server'

# Takes in verb and path and directs to appropriate output
class Router
  def initialize
    @server = Server.new(9292)
  end

  def path
    @server.request_lines[0].split[1]
  end

  def verb
    @server.request_lines[0].split[0]
  end

  def verb_router
    router_post if verb == 'POST'
    router_get if verb == 'GET'
  end

  def router_get
    default_output if path == '/'
    hello_world_message if path == '/hello'
    datetime_message if path == '/datetime'
    shutdown if path == '/shutdown'
    search_dictionary if path.start_with?('/word_search')
    game_info if path == '/game'
  end

  def router_post
    if path == '/start_game'
      @message = 'Good luck!'
      output
    elsif path.start_with?('/game')
      guess_body = @client.read(content_length)
    end
  end
end
