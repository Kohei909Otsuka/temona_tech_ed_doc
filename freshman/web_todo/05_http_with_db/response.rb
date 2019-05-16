class Response
  OK = 200
  CLIENT_ERR = 400
  SERVER_ERR = 500
  REDIRECT = 301
  NOT_FOUND = 404

  def initialize(status, type, body = nil, location = nil)
    @status = status
    @type = type
    @location = location
    @body = body
  end

  def write(socket)
    socket.write "HTTP/1.1 #{@status}\r\n"
    socket.write "Content-Type: #{@type}\r\n"
    socket.write "Location: #{@location}\r\n" unless @location.nil?
    socket.write "\r\n"
    socket.write @body unless @body.nil?
  end
end
