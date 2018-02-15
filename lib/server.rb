require 'socket'
require 'pry'
require 'Date'

class Server
  def initialize(port)
    @tcp_server = TCPServer.new(port)
    @hello_count = 0
    @total_count = 0
    @close = false
    @request_lines = []
    @message = ''
  end

  def start
    loop do
      break if @close == true
      @client = @tcp_server.accept
      client_loop
      router
      @request_lines = []
      @client.close
    end
  end

  def path
    @request_lines[0].split[1]
  end

  def client_loop
    while line = @client.gets and !line.chomp.empty?
      @request_lines << line.chomp
    end
    puts 'Got this request:'
    puts @request_lines.inspect
    puts 'Sending response.'
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
    "content-length: #{@message.length + 25}\r\n\r\n"].join("\r\n")
  end

  def output
    @total_count += 1
    @client.puts headers
    @client.puts '<html><head></head><body>' + @message + '</body></html>'
    @client.puts response
  end

  def response
    "<pre>
    Verb:     #{@request_lines[0].split[0]}
    Path:     #{@request_lines[0].split[1]}
    Protocol: #{@request_lines[0].split[2]}
    Host:     #{@request_lines[1].split[1].split(':')[0]}
    Port:     #{@request_lines[1].split[1].split(':')[1]}
    Origin:   #{@request_lines[1].split[1].split(':')[0]}
    Accept:   #{@request_lines[6].split[1]}
    </pre>"
  end

  def router
    if path == '/'
      default_output
    elsif path == '/hello'
      hello_world_message
    elsif path == '/datetime'
      datetime_message
    elsif path == '/shutdown'
      shutdown
    elsif path.start_with?('/word_search')
      search_dictionary
    end
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
    output
    @client.close
    @close = true
  end

  def search_dictionary
    word = path.split('=')[1]
    if File.read('/usr/share/dict/words').include?(word)
      @message = "#{word} is a known word."
    else
      @message = "#{word} is not a known word."
    end
    output
  end
end
