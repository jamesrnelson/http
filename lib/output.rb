require './lib/router'
require './lib/server'
require './lib/game'
require 'pry'

# Takes instruction from router class about what to output
class Output
  attr_reader :server, :path, :router
  attr_accessor :message

  def initialize(server)
    @server = server
    @hello_count = 0
    @total_count = 0
    @game_count = 0
    @game = nil
    @message = nil
  end

  def default_output
    @message = 'This is the default output.'
    output
  end

  def hello_world_message
    @message = "Hello, World! (#{@hello_count})"
    output
    @hello_count += 1
  end

  def datetime_message
    @message = current_time
    output
  end

  def shutdown
    @message = "Total Requests: #{@total_count}"
    server.close = true
    output
  end

  def path
    server.request_lines[0].split[1]
  end

  def search_dictionary
    word = path.split('=')[1]
    if File.read('/usr/share/dict/words').include?(word)
      @message = "#{word.upcase} is a known word."
    else
      @message = "#{word.upcase} is not a known word."
    end
    output
  end

  def start_game
    @game = Game.new(server)
    @message = 'Good luck!'
    output
  end

  def record_guess
    @game_count += 1
    guess_body = server.client.read(content_length)
    player_input = guess_body.split[-2]
    @game.compare_answer_class(player_input)
  end

  def game_info
    if @game_count.zero?
      @message = "You have not started a game, or you have not made any guesses.
      Please start a game by posting to the path '/start_game'."
    else
      @message = "You have made #{@game_count} guesses."
    end
    output
  end

  def entire_message
    '<html><head></head><body>' + @message + '</body></html>' \
      "<pre>
      Verb:     #{server.request_lines[0].split[0]}
      Path:     #{server.request_lines[0].split[1]}
      Protocol: #{server.request_lines[0].split[2]}
      Host:     #{server.request_lines[1].split[1].split(':')[0]}
      Port:     #{server.request_lines[1].split[1].split(':')[1]}
      Origin:   #{server.request_lines[1].split[1].split(':')[0]}
      </pre>"
  end

  def content_length
    server.request_lines.find do |request|
      request.include?('Content')
    end.split(' ')[1].to_i
  end

  def current_time
    date = Time.now
    date.strftime('%l:%M%p on %A, %B %-d, %Y.')
  end

  def headers
    ["http/1.1 200 ok",
    "date: #{Time.now.strftime('%a, %e %b %Y %H:%M:%S %z')}",
    "server: ruby",
    "content-type: text/html; charset=iso-8859-1",
    "content-length: #{entire_message.length}\r\n\r\n"].join("\r\n")
  end

  def output
    @total_count += 1
    server.client.puts headers
    server.client.puts entire_message
  end
end
