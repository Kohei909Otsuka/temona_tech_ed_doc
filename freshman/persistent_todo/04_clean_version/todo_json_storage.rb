require "json"
require "fileutils"

class TodoJsonStorage
  def initialize(path)
    @path = path
    FileUtils.touch(path)
  end

  def read
    File.open(@path,"r") do |f|
      output = JSON.load(
        f,
        nil,
        {create_additions: false, symbolize_names: true}
      )
      if output
        output
      else
        return []
      end
    end
  end

  def write(todos)
    File.open(@path,"w") do |f|
      f.write(JSON.pretty_generate(todos))
    end
  end
end
