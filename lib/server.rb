require 'socket'
require 'pry'
require 'Date'
require './lib/router'

# Starts the server and populates the request lines
class Server
  attr_reader :request_lines, :server, :client
  attr_accessor :close
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
end
