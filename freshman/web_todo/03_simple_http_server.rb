# 目的GETだけで、HTTPサーバーの原型となるようなスクリプト作成することを通じて
# httpとはなんなのかをざっくりつかむ(wireshark, chrome dev toolでみてみる)
# https://triple-underscore.github.io/RFC2616-ja.html#section-5

require 'socket'
server = TCPServer.new 3000

loop do
  socket = server.accept
  raw_request = socket.gets
  socket.write "HTTP/1.1 200\r\n" # 1
  socket.write "Content-Type: text/html\r\n" # 2
  socket.write "\r\n" # 3
  socket.write "Hello world! The time is #{Time.now}" #4
  socket.close
end
