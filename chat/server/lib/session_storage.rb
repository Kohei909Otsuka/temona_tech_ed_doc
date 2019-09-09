module SessionStorage

  def set(key, value)
    con = ActiveRecord::Base.connection
    pg_result = con.execute("
      INSERT INTO sessions(session_id, value) VALUES ('#{key}', '#{value}')
    ")
    if pg_result.error_message == ""
      return Result.new()
    end
    return Result.new([pg_result.error_message])
  end

  def get(key)
    con = ActiveRecord::Base.connection
    result = con.select_one("
      SELECT session_id, value FROM sessions WHERE session_id = '#{key}'
    ")
    if result.nil?
      return Result.new([], nil)
    end
    return Result.new([], result["value"])
  end

  def rm(key)
    con = ActiveRecord::Base.connection
    pg_result = con.execute("
      DELETE FROM sessions WHERE session_id = '#{key}'
    ")
    if pg_result.error_message == ""
      return Result.new()
    end
    return Result.new([pg_result.error_message])
  end

  module_function :set, :get, :rm
end
