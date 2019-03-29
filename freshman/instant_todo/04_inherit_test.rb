require_relative "04_inherit"
# 標準添付ライブラリをほ読み込む
# https://docs.ruby-lang.org/ja/2.0.0/library/minitest=2funit.html
# https://docs.ruby-lang.org/ja/2.0.0/class/MiniTest=3a=3aAssertions.html
require 'minitest/autorun'

class TestTodo <  Minitest::Test
  def setup
    @todo = Todo.new 1, "send mail to Jim"
  end

  def test_format
    assert_equal "{id: 1, name: send mail to Jim}", @todo.format
  end
end

class TestTodoList <  Minitest::Test
  def setup
    @todo_list = TodoList.new
  end

  def test_append
    assert_equal 0, @todo_list.list.length
    @todo_list.append "call mom"
    assert_equal 1, @todo_list.list.length
    assert_equal "call mom", @todo_list.list.first.name
  end

  def test_output
    assert_respond_to @todo_list, "output"
  end
end

# 自分で書いてみよ + assert_equalがなぜ呼べるのか考えてみよう
class TestFriend <  Minitest::Test
end

class TestFriendList <  Minitest::Test
end

# class TestList < Minitest::Test
# end
