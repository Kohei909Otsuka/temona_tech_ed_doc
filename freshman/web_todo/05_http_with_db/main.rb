require 'socket'
require 'erb'
require_relative 'request_parser'
require_relative 'todo_handler'

server = TCPServer.new 3000

def log(method, path, params)
  puts "#{Time.now}: #{method} #{path} #{params}"
end

# 全体的に同時接続扱えないとか%エンコーディングとか、他にも仕様がおかしいところがたくさんあるけど、雰囲気が分かればいいのでok
loop do
  socket = server.accept
  req = RequestParser.parse(socket)
  next if req.nil?
  log(req.method, req.path, req.params)
  handler = TodoHandler.new(socket, req)

  if (req.method == Request::GET && req.path == "/") ||
     (req.method == Request::GET && req.path == "/todos")

    handler.index
  elsif req.method == Request::GET && req.path == "/todos/new"
    handler.new
  elsif req.method == Request::POST && req.path == "/todos"
    handler.create
  else
    handler.not_found
  end

  socket.close
end

