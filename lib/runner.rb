require './lib/server'

server = Server.new
server.start
router = Router.new(tcp_server)
