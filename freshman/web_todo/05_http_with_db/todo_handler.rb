require 'ostruct'
require 'date'
require_relative 'response'

class TodoHandler
  @@todos = [
    { id: 1, name: "first todo", deadline: Date.new(2019, 04, 05)},
    { id: 2, name: "second todo", deadline: Date.new(2019, 05, 15)},
    { id: 3, name: "third todo", deadline: Date.new(2019, 05, 30)},
  ].map { |todo| OpenStruct.new(todo) }

  def initialize(socket, req)
    @socket = socket
    @req = req
  end

  def index
    template = File.read(File.expand_path("templates/index.html.erb"))
    todos = @@todos
    html = ERB.new(template).result(binding)

    res = Response.new(Response::OK, "text/html", html)
    res.write(@socket)
  end

  def new
    html = File.read(File.expand_path("templates/new.html"))
    res = Response.new(Response::OK, "text/html", html)
    res.write(@socket)
  end

  def create
    @@todos.push(OpenStruct.new({
      id: @@todos.map(&:id).max + 1,
      name: @req.params["name"],
      deadline: Date.parse(@req.params["deadline"]),
    }))
    res = Response.new(Response::REDIRECT, "text/html", nil, "/")
    res.write(@socket)
  end

  def not_found
    res = Response.new(Response::NOT_FOUND, "text/plain", "not_found")
    res.write(@socket)
  end

end
