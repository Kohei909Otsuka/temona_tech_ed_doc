# クラスを使わずまずはRubyに慣れてもらうためにスクリプトっぽく書く

# v1仕様
# プログラムを開始すると、taskの入力待ちになる
# taskの入力が完了すると、taskの一覧が表示され、またtaskの入力待ちになる
# 初期状態 => taskの入力待ち状態 => taskの入力 => taskの一覧の表示 => taskの入力状態

# 値が空の配列である変数todosを初期化
todos = []

puts "simlest todo app script version 1"

# 無限ループ
loop do
  puts "enter task\n"
  task_name = gets
  todos << task_name # todosに入力されたtaskを追加
  puts todos
end

# +a
# - "enter task"の文言を変えてみる
# - 現在までに入力されたタスクの数を出力してみる
