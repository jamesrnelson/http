require 'socket'
require 'pry'
require 'Date'
require './lib/router'

# Starts the server and populates the request lines
class Server
  attr_reader :request_lines, :server
  def initialize(port)
    @server = TCPServer.new(port)
    @router = Router.new(self)
    @client = nil
    @close = false
    @request_lines = []
  end

  def start
    loop do
      break if @close == true
      @client = @server.accept
      @request_lines = []
      client_loop
      @router.verb_router
      @client.close
    end
  end

  def client_loop
    while line = @client.gets and !line.chomp.empty?
      @request_lines << line.chomp
    end
    puts 'Got this request:'
    puts @request_lines.inspect
    puts 'Sending response.'
  end

### Moved to router
  # def path
  #   @request_lines[0].split[1]
  # end
  #
  # def verb
  #   @request_lines[0].split[0]
  # end

### Moved to Output
  # def current_time
  #   date = Time.now
  #   date.strftime('%l:%M%p on %A, %B %-d, %Y.')
  # end
  #
  # def headers
  #   ["http/1.1 200 ok",
  #   "date: #{Time.now.strftime('%a, %e %b %Y %H:%M:%S %z')}",
  #   "server: ruby",
  #   "content-type: text/html; charset=iso-8859-1",
  #   "content-length: #{entire_message.length}\r\n\r\n"].join("\r\n")
  # end

### Moved following methods to router class
  # def verb_router
  #   post_router if verb == 'POST'
  #   get_router if verb == 'GET'
  # end
  #
  # def get_router
  #   default_output if path == '/'
  #   hello_world_message if path == '/hello'
  #   datetime_message if path == '/datetime'
  #   shutdown if path == '/shutdown'
  #   search_dictionary if path.start_with?('/word_search')
  #   game_info if path == '/game'
  # end
  #
  # def post_router
  #   if path == '/start_game'
  #     @message = 'Good luck!'
  #     output
  #   elsif path.start_with?('/game')
  #     guess_body = @client.read(content_length)
  #   end
  # end

### These methods were moved to the output class
  # def default_output
  #   @message = 'This is the default output.'
  #   output
  # end
  #
  # def hello_world_message
  #   @message = "Hello, World! (#{@hello_count})"
  #   output
  #   @hello_count += 1
  # end
  #
  # def datetime_message
  #   @message = current_time
  #   output
  # end
  #
  # def shutdown
  #   @message = "Total Requests: #{@total_count}"
  #   @client.close
  #   @close = true
  #   output
  # end
  #
  # def search_dictionary
  #   word = path.split('=')[1]
  #   if File.read('/usr/share/dict/words').include?(word)
  #     @message = "#{word} is a known word."
  #   else
  #     @message = "#{word} is not a known word."
  #   end
  #   output
  # end
  #
  # def game_info
  #   @message = "You have made #{guess_count} guesses."
  # end
  #
  # def entire_message
  #   '<html><head></head><body>' + @message + '</body></html>' \
  #     "<pre>
  #     Verb:     #{@request_lines[0].split[0]}
  #     Path:     #{@request_lines[0].split[1]}
  #     Protocol: #{@request_lines[0].split[2]}
  #     Host:     #{@request_lines[1].split[1].split(':')[0]}
  #     Port:     #{@request_lines[1].split[1].split(':')[1]}
  #     Origin:   #{@request_lines[1].split[1].split(':')[0]}
  #     </pre>"
  # end
  #
  # def output
  #   @total_count += 1
  #   @client.puts headers
  #   @client.puts entire_message
  # end
  #
  # def content_length
  #   @request_lines.find do |request|
  #     request.include?('Content')
  #   end.split(' ')[1].to_i
  # end
end
