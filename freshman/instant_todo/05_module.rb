# 継承で実現したのと同じことをmoduleを使って実現してみる
# テストは04_inherit_test.rbを使うことで、テストがあると実装を自由に変えられることを実感してもらう

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

module Listable
  def append item
    all << item
    return all
  end

  def list
    all
  end

  # write formatを期待しているのはちょっと厳しいかな...
  def output dest
    @list.each do |item|
      dest.write(item.format + "\n")
    end
    return @list
  end
end

class TodoList
  include Listable
  def initialize
    @list = []
  end

  def all
    return @list
  end
end

class FriendList
  include Listable

  def initialize
    @list = []
  end

  def all
    return @list
  end
end
