# 目的: 一番シンプルなtcpのサーバーを立てて,それをncから叩いてwiresharkで観察する
# nc 127.0.0.1 5678
# wiresharckのネットワークカードはlo0
# その後httpが複数のパケットで成り立っていることをなんとなく理解してもらう

require 'socket'
server = TCPServer.new 3000

loop do
  socket = server.accept
  socket.puts "Hello world! The time is #{Time.now}"
  socket.close
end
