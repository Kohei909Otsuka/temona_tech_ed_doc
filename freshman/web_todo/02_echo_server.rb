# 目的: 入力をただ反射するようなエコーサーバ
# echo 'Ironman' | nc 127.0.0.1 5678

require 'socket'
server = TCPServer.new 3000

loop do
  socket = server.accept
  first_line = socket.gets
  socket.puts "You said #{first_line}"
  socket.close
end
