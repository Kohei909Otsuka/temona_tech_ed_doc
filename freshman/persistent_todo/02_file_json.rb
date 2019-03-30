# Rubyからjsonファイルの読み込み、書き込みをする
# JSONとcsvの違いについて議論する(nest)
# https://docs.ruby-lang.org/ja/latest/class/JSON.html

require "json"

# 映画を管理するけど、キャスト情報も入れてみる

# 書き込み
movies = {
  movies: [
    {
      title: "Titaic",
      release_year: 1997,
      review: 5,
      casts: [
        "Leonardo Wilhelm DiCaprio",
        "Kate Winslet",
      ]
    },
    {
      title: "Harry Potter",
      release_year: 2001,
      review: 4,
      casts: [
        "Daniel Jacob Radcliffe",
        "Rupert Alexander Lloyd Grint",
        "Emma Watson",
      ]
    },
    {
      title: "Good Will Hunting",
      release_year: 1997,
      review: 5,
      casts: [
        "Matt Damon",
        "Robin Williams",
      ]
    },
    {
      title: "Ironman",
      release_year: 2008,
      review: 3,
      casts: [
        "Tony Stark",
      ]
    },
  ]
}

File.open("file.json","w") do |f|
  f.write(JSON.pretty_generate(movies))
end

# 読み込み
File.open("file.json","r") do |f|
  p JSON.load(f)
end
