require 'socket'
require 'pry'

class Server
  def initialize(port)
    @tcp_server = TCPServer.new(port)
    @count = 0
  end

  def start
    while true
      puts "Ready for a request"
      client = @tcp_server.accept
      request_lines = []
      while line = client.gets and !line.chomp.empty?
        request_lines << line.chomp
      end

      puts "Got this request:"
      puts request_lines.inspect
      puts "Sending response."
      response = "<pre>
                    Verb:     #{request_lines[0].split[0]}
                    Path:     #{request_lines[0].split[1]}
                    Protocol: #{request_lines[0].split[2]}
                    Host:     #{request_lines[1].split[1].split(':')[0]}
                    Port:     #{request_lines[1].split[1].split(':')[1]}
                    Origin:   #{request_lines[1].split[1].split(':')[0]}
                    Accept:   #{request_lines[6].split[1]}
                    </pre>"
      if path == '/'
        output = "<html><head></head><body>Hello, World!  (#{@count})#{response}</body></html>"
      headers = ["http/1.1 200 ok",
                "date: #{Time.now.strftime('%a, %e %b %Y %H:%M:%S %z')}",
                "server: ruby",
                "content-type: text/html; charset=iso-8859-1",
                "content-length: #{output.length}\r\n\r\n"].join("\r\n")
      client.puts headers
      client.puts output

      @count += 1

      puts ["Wrote this response: ", headers, output].join("\n")
      client.close
      puts "\nResponse complete, exiting."
    end
  end
end
