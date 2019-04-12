require_relative "todo_storage_generator"
require_relative "todo_list"

MODES = [
  "list",
  "append",
  "update",
  "remove",
  "search"
]

sg = TodoStorageGenerator.new(ENV["STORAGE"])
errs = sg.errs
if !errs.empty?
  puts errs.join
  return
end
strage = sg.generate
list = TodoList.new(strage)

loop do
  puts "enter mode(#{MODES.join(", ")})"
  mode = gets.chomp

  case mode
  when MODES[0]
    puts list.all.map {|todo| todo.format}
  when MODES[1]
    puts "enter name"
    list.append(gets.chomp)
  when MODES[2]
    puts "enter id to update"
    id = gets.chomp.to_i
    puts "enter new name"
    name = gets.chomp
    success = list.update(id, name)
    if !success
      puts "todo not found for given id"
      next
    end
  when MODES[3]
    puts "enter id to remove"
    id = gets.chomp.to_i
    success = list.remove(id)
    if !success
      puts "todo not found for given id"
      next
    end
  when MODES[4]
    puts "enter keyword to search"
    keyword = gets.chomp
    puts "search result ids"
    puts list.search(keyword)
  else
    puts "Warning! mode must be one of #{MODES.join(", ")}"
    next
  end

  # ctrl + cで終了したら、listを閉じて永続化
  rescue Interrupt => e
    list.close
    return
end
