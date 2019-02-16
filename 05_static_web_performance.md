# やること

静的なコンテンツを表示するようなWeb Pageにおけるパフォーマンスを
実際に計測しながら改善してみる

静的な場合ブラウザからみれば...
パフォーマンス = loading * rendering
                 loading = やりとりするビットの量/リクエストの数

CPU クロックを1秒とすると...の話を思い出せば、loadingのほうがはるかに重要であることは明らか。

- 手元のfrontendよりのツールで限界までパフォーマンスをあげる
  - まずは最初の状態を計測
  - textをminifyする
  - textを圧縮する
  - 画像の情報量を減らせるだけ減らす
  - ファイルをまとめる
- serverよりのツールで負荷テストをしてみる
  - 負荷を与える方と負荷を受ける方、両方にsarを仕込む
  - 負荷をかけてその結果を見てみる
    - sarのメトリクス
    - 結果レポート
    - nginxのログ
  - マシンを交代してみる
  - 時間があれば、mackerel試してみる

# 参考

- [developers.google](https://developers.google.com/web/fundamentals/performance/why-performance-matters/?hl=ja)
- [google demo site github](https://github.com/GoogleChromeLabs/FastPageLoadDemo)
- [k6](https://github.com/loadimpact/k6)

