# https://www.mm2d.net/main/prog/c/console-02.html
# ANSI_escape_code という仕組みを使うとカラーで出力できる

puts "this is plain"

print "\e[31m"
puts "this is red"
print "\e[0m"

puts "\e[34mthis is blue\e[0m"

module Color
  def self.red str
    return "\e[31m#{str}\e[0m"
  end

  def self.green str
    return "\e[32m#{str}\e[0m"
  end
end

puts Color.red("fail")
puts Color.green("success")

# https://guides.rubygems.org/make-your-own-gem/
# を参考にcolor_{yourname}というgemを作って公開してみる
