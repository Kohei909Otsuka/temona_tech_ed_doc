require "pg"

class TodoDbStorage
  BASE_CONN_INFO = {
    host: "localhost",
    port: 5432,
    user: "postgres",
    password: "kohei",
  }
  TABLE_NAME = "todos"
  @@conn = nil

  def initialize(db_name)
    create_db_if_not_exist(db_name)

    @@conn = PG.connect(BASE_CONN_INFO.merge(dbname: db_name))
  end

  def read
    r = @@conn.exec("SELECT id, name FROM #{TABLE_NAME}")
    return r.values.map {|row| {id: row[0].to_i, name: row[1] }}
  end

  def write(todos)
    @@conn.exec("TRUNCATE #{TABLE_NAME}")
    values = todos.map {|todo| "(#{todo[:id]}, '#{todo[:name]}')"}.join(", ")
    insert = <<-EOS
      INSERT INTO #{TABLE_NAME} (id, name) VALUES
      #{values}
    EOS
    @@conn.exec(insert)
  end

  private

  def create_db_if_not_exist(db_name)
    conn = PG.connect(BASE_CONN_INFO)
    r = conn.exec("SELECT datname FROM pg_database WHERE datistemplate = false;")
    existed_dbs = r.values.flatten
    if !existed_dbs.include?(db_name)
      conn.exec("CREATE DATABASE #{db_name}")
      conn = PG.connect(BASE_CONN_INFO.merge(dbname: db_name))
      create_table = <<-EOS
        CREATE TABLE #{TABLE_NAME} (
          id integer,
          name varchar(40),
          PRIMARY KEY(id)
        )
      EOS
      conn.exec(create_table)
    end
  end
end
