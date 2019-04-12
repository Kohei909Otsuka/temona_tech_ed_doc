require_relative "todo"

class TodoList
  def initialize(storage)
    @storage = storage
    @list = @storage.read.map do |hash|
      Todo.new(hash[:id], hash[:name])
    end
    cal_and_set_for_search
  end

  def all
    return @list
  end

  def append(name)
    @list << Todo.new(@list.length + 1, name)
    cal_and_set_for_search
  end

  def update(id, name)
    # index見つける
    target_index = find_index_by_id(id)
    return false if target_index.nil?
    todo = @list[target_index]
    todo.name = name
    cal_and_set_for_search
    return true
  end

  def remove(id)
    target_index = find_index_by_id(id)
    return false if target_index.nil?
    @list.delete_at(target_index)
    cal_and_set_for_search
    return true
  end

  def close
    @storage.write(
      @list.map {|todo| {id: todo.id, name: todo.name}}
    )
  end

  def search(keyword)
    keyword = keyword.chomp
    p @inverted_index
    ids = @inverted_index[keyword] || []
    return ids
  end

  private

  def cal_and_set_for_search
    # NOTE: searchのために空白区切りの転置indexを先に準備しておく
    # 例えば下記のような２つのタスクが合った場合
    #   1. call mom
    #   2. call dad by Sunday
    # 次のようなHashを予め検索用に計算しておく(listの中身が変わるごとに再計算が必要)
    # {
    #   "call": [1,2],
    #   "mom": [1],
    #   "mail": [2],
    #   "dad": [2],
    #   "by": [2],
    #   "sunday": [2]
    # }
    tmp_index = {}
    @list.each do |todo|
      keywords = todo.name.split
      keywords.each do |key|
        if tmp_index[key]
          tmp_index[key].push(todo.id)
        else
          tmp_index[key] = [todo.id]
        end
      end
    end
    @inverted_index = tmp_index
  end

  def find_index_by_id(id)
    return @list.index {|todo| todo.id == id}
  end
end
