# 継承を使ってみる

# v4仕様
# Todoだけでなく、たとえばFriendも管理したくなったとする
# このときFriendListをどう作るか...継承を使ってみる

class Todo
  def initialize id, name
    @id = id
    @name = name
  end

  def name
    return @name
  end

  def format
    return "{id: #{@id}, name: #{@name}}"
  end
end

class Friend
  def initialize id, first_name, last_name
    @id = id
    @first_name = last_name
    @last_name = last_name
  end

  def format
    return "{id: #{@id}, name: #{@name}}"
  end

  def make_friend friend
    return "I(#{format}) and him/her(#{friend.format}) are friend"
  end
end

class List
  def initialize
    @list = []
  end

  def list
    return @list
  end

  def output dest
    @list.each do |item|
      dest.write(item.format + "\n")
    end
    return @list
  end
end

class TodoList < List
  def append task_name
    @list << Todo.new(@list.length + 1, task_name)
    return @list
  end
end

class FriendList < List
  def append first_name, last_name
    @list << Friend.new(@list.length + 1, first_name, last_name)
    return @list
  end
end

# 最初はてきとーに動いているのか確認してみる
# p Friend.new(1, "koehi", "otsuka")
# 継承treeをみてみる
# todo_list = TodoList.new
# p todo_list.class
# p todo_list.class.superclass
# p todo_list.class.superclass.superclass
# https://ruby-hacking-guide.github.io/minimum.html

