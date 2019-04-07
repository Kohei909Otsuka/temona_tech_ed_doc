require_relative "todo_csv_storage"
require_relative "todo_json_storage"
require_relative "todo_db_storage"

class TodoStorageGenerator
  KINDS = ["csv", "json", "db"]

  def initialize kind
    @kind = kind
  end

  def generate
    case @kind
    when KINDS[0]
      return TodoCsvStorage.new("data/todo.csv")
    when KINDS[1]
      return TodoJsonStorage.new("data/todo.json")
    when KINDS[2]
      return TodoDbStorage.new("dev_todo_db")
    else
      return nil
    end
  end

  def errs
    if KINDS.include? @kind
      return []
    end
    return ["Warning! strage must be one of #{KINDS.join(", ")}"]
  end
end
