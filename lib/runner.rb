require './lib/server'
require './lib/router'

server = Server.new(9292)
server.start
router = Router.new(tcp_server)
