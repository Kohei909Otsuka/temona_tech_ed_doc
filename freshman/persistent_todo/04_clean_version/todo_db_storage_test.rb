require "pg"
require "minitest/autorun"
require_relative "todo_db_storage"

class TestTodoDbStorage < Minitest::Test
  DUMMYS = [
    {id: 1, name: "task1"},
    {id: 2, name: "task2"},
    {id: 3, name: "task3"},
    {id: 4, name: "task4"},
  ]

  def setup
    @storage = TodoDbStorage.new("test_todo_db")
    @conn = PG.connect(TodoDbStorage::BASE_CONN_INFO.merge(dbname: "test_todo_db"))
  end

  def teardown
    @conn.exec("TRUNCATE #{TodoDbStorage::TABLE_NAME}")
  end

  def test_read
    write_to_db(DUMMYS)
    assert_equal(DUMMYS, @storage.read)
  end

  def test_write
    write_to_db(DUMMYS)
    @storage.write([{id: 1, name: "added task"}])
    expected = [
      {id: 1, name: "added task"}
    ]
    r = @conn.exec("SELECT id, name FROM #{TodoDbStorage::TABLE_NAME}")
    inserted = r.values.map {|row| {id: row[0].to_i, name: row[1] }}
    assert_equal(expected, inserted)
  end

  private

  def write_to_db(datas)
    values = datas.map {|todo| "(#{todo[:id]}, '#{todo[:name]}')"}.join(", ")
    insert = <<-EOS
      INSERT INTO #{TodoDbStorage::TABLE_NAME} (id, name) VALUES
      #{values}
    EOS
    @conn.exec(insert)
  end
end
