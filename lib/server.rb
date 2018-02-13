require 'socket'
require 'pry'
require 'Date'

class Server
  def initialize(port)
    @tcp_server = TCPServer.new(port)
    @hello_count = 0
    @total_count = 0
    @request_lines = []
  end

  def start
    loop do
      @client = @tcp_server.accept
      client_loop
      parser
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
    date = Date.today
    date.strftime('%I:%M%p on %A, %B %-d, %Y.')
  end

  def headers
    ["http/1.1 200 ok",
    "date: #{Time.now.strftime('%a, %e %b %Y %H:%M:%S %z')}",
    "server: ruby",
    "content-type: text/html; charset=iso-8859-1",
    "content-length: \r\n\r\n"].join("\r\n")
  end

  def output(message)
    @total_count += 1
    @client.puts headers
    @client.puts "<html><head></head><body>" + message + "</body></html>"
    @client.puts response
  end

  def response
    "<pre>
    Verb:     #{@request_lines[-9].split[0]}
    Path:     #{@request_lines[-9].split[1]}
    Protocol: #{@request_lines[-9].split[2]}
    Host:     #{@request_lines[-8].split[1].split(':')[0]}
    Port:     #{@request_lines[-8].split[1].split(':')[1]}
    Origin:   #{@request_lines[-8].split[1].split(':')[0]}
    Accept:   #{@request_lines[-3].split[1]}
    </pre>"
  end

  def parser
    if path == '/'
      output('')
    elsif path == '/hello'
      output("Hello, World! (#{@hello_count})")
      @hello_count += 1
    elsif path == '/datetime'
      output("#{current_time}")
    elsif path == '/shutdown'
      output("Total Requests: #{@total_count}")
      @client.close
      puts "\nResponse complete, exiting."
    end
  end
end
