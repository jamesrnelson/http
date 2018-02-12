require 'socket'
tcp_server = TCPServer.new(9292)
client = tcp_server.accept

print "Ready for a request"
request_lines = []
while line = client.gets and !line.chomp.empty?
  request_lines << line.chomp
end

puts "Got this request:"
puts request_lines.inspect

puts "Sending response."
count = 0
response = "<pre>" + "Hello, World! (#{count})" + "</pre>"
output = "<html><head></head><body>#{response}</body></html>"
headers = ["http/1.1 200 ok",
          "date: #{Time.now.strftime('%a, %e %b %Y %H:%M:%S %z')}",
          "server: ruby",
          "content-type: text/html; charset=iso-8859-1",
          "content-length: #{output.length}\r\n\r\n"].join("\r\n")
count += 1
client.puts headers
client.puts output

puts ["Wrote this response: Hello, World", headers, output].join("\n")
puts "\nResponse complete, exiting."
