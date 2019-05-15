# 目的: テンプレートエンジンを使ってhtmlを返す。css, jsも返してあげる
# https://magazine.rubyist.net/articles/0017/0017-BundledLibraries.html
# https://docs.ruby-lang.org/ja/latest/class/ERB.html#I_RESULT

require 'socket'
require 'erb'

def handle_html(socket)
  #Response Headerの書き込み
  socket.write "HTTP/1.1 200\r\n"
  socket.write "Content-Type: text/html\r\n"
  socket.write "\r\n"

  #Response Bodyの書き込み
  template = File.read("index.html.erb")
  time = Time.now.strftime("%F %T")
  html = ERB.new(template).result(binding)
  socket.write html
end

def handle_css(socket)
  #Response Headerの書き込み
  socket.write "HTTP/1.1 200\r\n"
  socket.write "Content-Type: text/css\r\n"
  socket.write "\r\n"

  #Response Bodyの書き込み
  css = File.read("index.css")
  socket.write css
end

def handle_js(socket)
  #Response Headerの書き込み
  socket.write "HTTP/1.1 200\r\n"
  socket.write "Content-Type: text/javascript\r\n"
  socket.write "\r\n"

  #Response Bodyの書き込み
  js = File.read("index.js")
  socket.write js
end

def log(method, path, version)
  puts "#{Time.now}: #{version} #{method} #{path}"
end


server = TCPServer.new 3000

loop do
  socket = server.accept
  raw_request_first_line = socket.gets
  meta = raw_request_first_line.split("\s")
  method = meta[0]
  path = meta[1]
  version = meta[2]
  log(method, path, version)

  if path == "/index.css"
    handle_css(socket)
  elsif path == "/index.js"
    handle_js(socket)
  else
    handle_html(socket)
  end

  socket.close
end

