# index

今日はセキュリティーというか暗号の話
ゴールはSSLでなにが起きているのか、なんとなく理解すること

- なんで暗号が面白いか
- なぜネットワークの前に暗号の話をするのか
- 古典暗号(鍵の長さと、確率分布の話ができればよし)
  - シーザー暗号(実際に解いてみる: `ynrjkqnjxqnpjfsfwwtb`)
  - 換字式と頻度分析 => (26! = 4 * 10^26)
- 現代暗号
  - 共通鍵暗号方式(メリット・デメリット分かればよし)
    - 鍵の配送とその数
  - 公開鍵暗号方式(送信側と受信側、どっちが鍵を作成するのかどっちが公開鍵を持つのか)
- ハッシュ関数(目で見る)
- 電子署名
- 証明書(SSLのハンドシェイクを実際に見てみる)
- その他のトピック
  - ナバホ族のCode Talker(古典暗号のとき)
  - PasmoとかのFelica(共通鍵暗号方式のとき)
  - [Nict](https://www.nict.go.jp/publication/NICT-News/1303/01.html)が公開している推奨の鍵長(最後)
  - 擬似乱数生成器(最後)


# RSA

``` sh
openssl genrsa -out private.key 1024
openssl rsa -text -in private.key
openssl rsa -pubout -in private.key -out public.key
openssl rsa -text -in public.key
openssl rsa -text -pubin -in public.key

openssl rsautl -encrypt -pubin -inkey public.key -in plain.txt -out encrypted.txt
openssl rsautl -decrypt -inkey private.key -in encrypted.txt -out decrypted.txt
```

# ハッシュ関数

```
echo "short text" | openssl dgst -md5
openssl dgst -md5 long.txt
// 一文字だけ変えてみる
```

# 電子署名

ふつう、公開鍵で暗号化してもらって、秘密鍵で復号する。ただ、あえて秘密鍵で暗号化すると...

データ > ハッシュ値 > 秘密鍵で暗号化
この値をAとして、

Aを公開鍵で復号化したハッシュ値が、データから再計算した値と等しいなら...
改ざんされておらずかつ、持ち主を特定できる。

# 証明書

署名してあるからって、その信用性はどれくらいあるだろう?
印鑑証明、をしてくれる機関が必要。
このとき証明okとなった場合に発行されるのが証明書。

- 発行者
- 有効期限
- 公開鍵
- 認証局のデジタル署名 => なのでブラウザにはデフォルトで認証局の公開鍵が入ってる

最後に実際にSSLで通信をみてみる

```
openssl s_client -state -connect www.openssl.org:443 | grep SSL
```

# おすすめの資料

- [暗号解読](https://www.amazon.co.jp/%E6%9A%97%E5%8F%B7%E8%A7%A3%E8%AA%AD%E3%80%88%E4%B8%8A%E3%80%89-%E6%96%B0%E6%BD%AE%E6%96%87%E5%BA%AB-%E3%82%B5%E3%82%A4%E3%83%A2%E3%83%B3-%E3%82%B7%E3%83%B3/dp/410215972X)
- [SL/TLSを理解する　~共通鍵暗号・公開鍵暗号・ハッシュ関数・電子署名・証明書](https://www.amazon.co.jp/SSL-TLS%E3%82%92%E7%90%86%E8%A7%A3%E3%81%99%E3%82%8B-%E5%85%B1%E9%80%9A%E9%8D%B5%E6%9A%97%E5%8F%B7%E3%83%BB%E5%85%AC%E9%96%8B%E9%8D%B5%E6%9A%97%E5%8F%B7%E3%83%BB%E3%83%8F%E3%83%83%E3%82%B7%E3%83%A5%E9%96%A2%E6%95%B0%E3%83%BB%E9%9B%BB%E5%AD%90%E7%BD%B2%E5%90%8D%E3%83%BB%E8%A8%BC%E6%98%8E%E6%9B%B8-%E6%AD%A6%E5%86%85-%E5%A5%88%E3%80%85%E7%BE%8E-ebook/dp/B06XJ88H1G/ref=sr_1_2?s=digital-text&ie=UTF8&qid=1548509226&sr=1-2&keywords=SSL+TLS)
- [現代暗号入門](https://www.amazon.co.jp/%E7%8F%BE%E4%BB%A3%E6%9A%97%E5%8F%B7%E5%85%A5%E9%96%80-%E3%81%84%E3%81%8B%E3%81%AB%E3%81%97%E3%81%A6%E7%A7%98%E5%AF%86%E3%81%AF%E5%AE%88%E3%82%89%E3%82%8C%E3%82%8B%E3%81%AE%E3%81%8B-%E3%83%96%E3%83%AB%E3%83%BC%E3%83%90%E3%83%83%E3%82%AF%E3%82%B9-%E7%A5%9E%E6%B0%B8%E6%AD%A3%E5%8D%9A-ebook/dp/B076GW4ZGY/ref=sr_1_1?s=digital-text&ie=UTF8&qid=1548509409&sr=1-1&keywords=%E7%8F%BE%E4%BB%A3%E6%9A%97%E5%8F%B7%E5%85%A5%E9%96%80)
- [RSAについて](http://www.maitou.gr.jp/rsa/)
- [opensslでRSAと遊ぶ](https://ozuma.hatenablog.jp/entry/20130510/1368114329)
