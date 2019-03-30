# Rubyからcsvファイルの読み込み、書き込みをする
# https://docs.ruby-lang.org/ja/latest/class/CSV.html#S_OPEN
require "csv"

# たとえば映画を管理してみよう

# 書き込み
CSV.open("file.csv", "wb") do |csv|
  # header
  csv << ["title", "release_year", "review"]

  # rows
  csv << ["Titaic", "1997", "5"]
  csv << ["Harry Potter", "2001", "4"]
  csv << ["Good Will Hunting", "1997", "5"]
  csv << ["Ironman", "2008", "3"]
end

# 読み込み
CSV.foreach("file.csv") do |row|
  p row
end
