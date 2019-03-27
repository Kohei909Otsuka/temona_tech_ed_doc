# クラスを使って書いてみる
# 始める前にまずscript_version.rbでtodosの中身は何のclassのobjectなのかを覗いてみる

# v2仕様
# v1と一緒だが、表示方法をもう少し見やすくしてあげる(idをつける)

class Todo
  # Todoクラスの初期化時に呼ばれるconstructor
  def initialize id, name
    @id = id
    @name = name
  end

  def format
    return "{id: #{@id}, name: #{@name}}"
  end
end

class TodoList
  def initialize
    @list = []
  end

  def append task_name
    @list << Todo.new(@list.length + 1, task_name)
    return @list
  end

  def output dest
    @list.each do |todo|
      dest.write(todo.format + "\n")
    end
    return @list
  end
end

puts "simlest todo app script version 1"

list = TodoList.new
loop do
  puts "enter task\n"
  task_name = gets.chomp
  list.append(task_name)
  list.output $stdout
end


# +a
# - idだけでなく、保存したときの時刻も記録しよう例 {id: 1, name: aaaa, time: 2019-04-01 10:30:21}
# - listの中身は何のclassのobjectが入ってる?
