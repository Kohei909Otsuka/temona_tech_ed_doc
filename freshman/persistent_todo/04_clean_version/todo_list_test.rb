require "csv"
require "minitest/autorun"
require_relative "todo_list"
# See http://docs.seattlerb.org/minitest/

class TestTodoList < Minitest::Test
  def setup
    @data = [
      {id: 1, name: "first todo"},
      {id: 2, name: "second todo"},
    ]
    @dummy_storage = MiniTest::Mock.new
    @dummy_storage.expect(:read, @data)
    @list = TodoList.new(@dummy_storage)
  end

  def test_all
    all = @list.all
    first = all[0]
    second = all[1]
    assert_equal(2, all.length)
    assert_equal(Todo, first.class)
    assert_equal(Todo, second.class)
    assert_equal(
      [1, "first todo"],
      [first.id, first.name]
    )
    assert_equal(
      [2, "second todo"],
      [second.id, second.name]
    )
  end

  def test_append
    assert_equal(2, @list.all.length)
    @list.append("third todo")
    assert_equal(3, @list.all.length)

    added = @list.all.last
    assert_equal([3, "third todo"], [added.id, added.name])
  end

  def test_update_success
    assert_equal("first todo", @list.all[0].name)
    assert_equal("second todo", @list.all[1].name)

    assert_equal(
      true,
      @list.update(1, "updated first todo")
    )

    assert_equal("updated first todo", @list.all[0].name)
    assert_equal("second todo", @list.all[1].name)
  end

  def test_update_fail
    assert_equal("first todo", @list.all[0].name)
    assert_equal("second todo", @list.all[1].name)

    assert_equal(
      false,
      @list.update(3, "try update non exist id")
    )

    assert_equal("first todo", @list.all[0].name)
    assert_equal("second todo", @list.all[1].name)
  end

  def test_remove_success
    assert_equal(2, @list.all.length)
    assert_equal(
      true,
      @list.remove(1)
    )
    assert_equal(1, @list.all.length)
  end

  def test_remove_fail
    assert_equal(2, @list.all.length)
    assert_equal(
      false,
      @list.remove(3)
    )
    assert_equal(2, @list.all.length)
  end

  def test_close
    @dummy_storage.expect(:write, nil, [@data])
    @list.close
  end

end
