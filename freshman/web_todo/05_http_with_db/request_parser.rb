require_relative "request"
module RequestParser
  def self.parse(socket)
    raw_request_first_line = socket.gets
    # NOTE: HTTPじゃない通信がsocketにくることがある?
    # chromeだと起こるがcurlだとおきない
    # いったんfirst lineがなければnilをreturnするようにする
    return nil if raw_request_first_line.nil?
    meta = raw_request_first_line.split("\s")
    method = meta[0]
    path = meta[1]

    headers = {}
    while (buff = socket.gets) != "\r\n"
      header = buff.split(":")
      header_name = header[0]
      header_value = header[1].chomp.lstrip
      headers[header_name] = header_value
    end

    params = {}
    query_string = path.split("?")[1].to_s
    params.merge!(pairs(query_string))

    # postの場合bodyからもparamsをparse
    if method == Request::POST &&
       (content_bytes = headers["Content-Length"].to_i) > 0

      body = socket.readpartial(content_bytes)
      params.merge!(pairs(body))
    end

    return Request.new(method, path, params)
  end

  private

  # key1=value1&key2=value2...という文字列をhashに変換
  def self.pairs(key_value_string)
    output = {}
    pair_strings = key_value_string.split("&")
    pair_strings.each do |pair_string|
      pair = pair_string.split("=")
      key = pair[0]
      value = pair[1]
      output[key] = value
    end
    return output
  end
end
