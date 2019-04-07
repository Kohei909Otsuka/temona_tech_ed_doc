require "csv"
require "minitest/autorun"
require_relative "todo_csv_storage"

class TestTodoCsvStorage < Minitest::Test
  PATH = "test_data/todo.csv"
  DUMMYS = [
    {id: 1, name: "task1"},
    {id: 2, name: "task2"},
    {id: 3, name: "task3"},
    {id: 4, name: "task4"},
  ]

  def setup
    @storage = TodoCsvStorage.new(PATH)
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
      ["id", "name"],
      ["1", "added task"]
    ]
    assert_equal(expected, CSV.read(PATH))
  end

  private

  def write_to_file(datas)
    CSV.open(PATH, "wb") do |csv|
      # header
      csv << ["id", "name"]

      # rows
      datas.each do |data|
        csv << [data[:id], data[:name]]
      end
    end
  end
end
