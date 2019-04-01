# 仕様
# 今までの仕様 + Todoを永続化できる
# Todoを永続化する方法として3種類から指定することができる
# STRAGEが下記の3つ以外の場合、警告を表示したのち、初期状態に戻る
# この三種類はプログラムを起動するときに環境変数として渡す
# 1. CSV形式でファイルに保存(STORAGE=csv)
# 2. JSON形式でファイルに保存(STORAGE=json)
# 3. dbに保存(STORAGE=db)

# 更に、プログラム起動時modeを入力させて駆動させる
# modeが下記の4つ以外の場合、警告を表示したのち、初期状態に戻る
# - list状態: 保存されているTodoがあれば表示する
# - append状態: 指定されたTodoを新規保存する
# - update状態: idで指定されたTodoを更新する
# - remove状態: idで指定されたTodoを削除する

# listだけやって、あ、このままいったらヤバイな、って感じが理解できたらリファクタしていく。
require "csv"
require "json"
require 'pg'

STORAGE = ["csv", "json", "db"]
MODE = ["list", "append", "update", "remove"]
DB_NAME = "todo_app"
TABLE_NAME = "todos"

loop do
  # dbの初期化
  conn = PG.connect({host: "localhost", port: 5432, user: "postgres", password: "kohei"})
  r = conn.exec("SELECT datname FROM pg_database WHERE datistemplate = false;")
  existed_dbs = r.values.flatten

  # dbなかったら新規作成してdummy dataをinsert
  if !existed_dbs.include? DB_NAME
    conn.exec("CREATE DATABASE #{DB_NAME}")
    conn = PG.connect({host: "localhost", port: 5432, dbname: DB_NAME,
      user: "postgres", password: "kohei"})
    create_table = <<-EOS
      CREATE TABLE #{TABLE_NAME} (
        id integer,
        name varchar(40),
        PRIMARY KEY(id)
      )
    EOS
    r = conn.exec(create_table)
    insert = <<-EOS
      INSERT INTO #{TABLE_NAME} (id, name) VALUES
        (1, 'call Mom'),
        (2, 'mail to Mom'),
        (3, 'review PR'),
        (4, 'write resume')
    EOS
    r = conn.exec(insert)
  end

  conn = PG.connect({host: "localhost", port: 5432, dbname: DB_NAME,
    user: "postgres", password: "kohei"})

  puts "enter mode(#{MODE.join(", ")})"
  mode = gets.chomp
  strage = ENV["STORAGE"]
  if !STORAGE.include? strage
    puts "Warning! strage must be one of #{STORAGE.join(", ")}"
  end

  case mode
  when "list"
      list = []
      case strage
      when "csv"
        CSV.foreach("data/todo.csv") do |row|
          list << {id: row[0], name: row[1]}
        end
      when "json"
        File.open("data/todo.json", "r") do |f|
          json = JSON.load(f, nil, {symbolize_names: true, create_additions: false})
          list.concat json[:todos]
        end
      when "db"
        r = conn.exec("SELECT id, name FROM todos")
        rows = r.values.map {|row| {id: row[0], name: row[1] }}
        list.concat rows
      end
      puts list
  when "append"
    # TODO: 実装
  when "update"
    # TODO: 実装
  when "remove"
    # TODO: 実装
  else
    puts "Warning! mode must be one of #{MODE.join(", ")}"
    next
  end
end
