require "json"
require "minitest/autorun"
require_relative "todo_json_storage"

class TestTodoJsonStorage < Minitest::Test
  PATH = "test_data/todo.json"
  DUMMYS = [
    {id: 1, name: "task1"},
    {id: 2, name: "task2"},
    {id: 3, name: "task3"},
    {id: 4, name: "task4"},
  ]

  def setup
    @storage = TodoJsonStorage.new(PATH)
  end

  def teardown
    return unless File.exist?(PATH)
    File.delete(PATH)
  end

  def test_read
    write_to_file(DUMMYS)
    assert_equal(DUMMYS, @storage.read)
  end

  def test_write
    write_to_file(DUMMYS)

    @storage.write([{id: 1, name: "added task"}])
    expected = [
      {id: 1, name: "added task"}
    ]
    actual = nil
    File.open(PATH, "r") do |f|
      actual = JSON.load(
        f,
        nil,
        {create_additions: false, symbolize_names: true}
      )
    end

    assert_equal(expected, actual)
  end

  private

  def write_to_file(datas)
    File.open(PATH,"w") do |f|
      f.write(JSON.pretty_generate(datas))
    end
  end
end
