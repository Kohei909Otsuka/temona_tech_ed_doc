require "csv"
require "fileutils"

class TodoCsvStorage

  def initialize(path)
    @path = path
    FileUtils.touch(path)
  end

  def read
    out = []
    CSV.foreach(@path, {headers: true, return_headers: false}) do |row|
      out << {id: row[0].to_i, name: row[1]}
    end
    return out
  end

  def write todos
    CSV.open(@path, "wb") do |csv|
      # rows
      csv << ["id", "name"]
      todos.each do |hash|
        csv << [hash[:id], hash[:name]]
      end
    end
  end
end
