# 単体テストを先に書いてみる

# v3仕様
# v2と一緒だが、テストを先に書いてから実装してみる

class Todo
end

class TodoList
end

puts "test Todo class"

puts "todo object can initialized with id, name"
todo = Todo.new(1, "test test")
if todo.id == 1 && todo.name == "test test"
  puts "success"
else
  puts "fail"
end

puts "todo object can format itself"
todo = Todo.new(1, "test test")
if todo.format == "{id: 1, name: test test}"
  puts "success"
else
  puts "fail"
end

puts "test TodoList class"

puts "todo_list can append todo by todo_name and add id info then return list"
todo_list = TodoList.new
if todo_list.length == 0
  puts "success"
else
  puts "fail"
end

todo_list.append("test test")
appended_todo = todo_list[0]
if todo_list.length == 1 &&
   appended_todo.class == Todo &&
   appended_todo.id == 1 &&
   appended_todo.name == "test test"

  puts "success"
else
  puts "fail"
end

puts "todo_list can output into io interface with write method"
class IOBufferMock
  attr_accessor :buffer
  def initialized
    @buffer = []
  end

  def write string
    @buffer << string
  end
end
todo_list = TodoList.new
io_buffer_mock = IOBufferMock.new

puts "when list is empty, it writes nothing"
todo_list.output io_buffer_mock
if io_buffer_mock.buffer.length == 0
  puts "success"
else
  puts "fail"
end


todo_list.append "call Tom"
todo_list.output io_buffer_mock
if io_buffer_mock.buffer.length == 1
  puts "success"
else
  puts "fail"
end
