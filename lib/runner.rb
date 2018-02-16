require './lib/server'
require './lib/router'

server = Server.new(9292)
server.start
