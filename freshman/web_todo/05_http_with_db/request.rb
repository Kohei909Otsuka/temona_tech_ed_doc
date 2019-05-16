class Request
  GET = "GET"
  POST = "POST"
  PUT = "PUT"
  DELETE = "DELETE"

  attr_accessor :method, :path, :params

  def initialize(method, path, params)
    @method = method
    @path = path
    @params = params
  end
end
