# index

- おれのQitaの記事で、ざっくりイメージを掴む
- とりあえずdegital oceanでserverを立てる(cent osに統一)
- domainも適当につける
- pingで疎通確認
- HTTPみてみる
  - nginxをinstallして起動する
  - ブラウザ/curlでアクセスして...
    - client側からパケットキャプチャをみてみる
    - server側からパケットキャプチャ/システムコールをみてみる
- HTTPSみてみる
  - おれおれ証明書を発行してhttps化する => 復号化
  - Let's encryptでhttps化する => 復号化
- SMTP/POP3/IMAPみてみる
  - postfixをinstallして起動する(最初から入ってるかも)
  - 一時メールアドレスにメールを送ってみる(パケットキャプチャ)
  - 自分のgmailのメールアドレスにメールを送ってみる(パケットキャプチャ)
- その他のトピック
  - ネットのスピード
- 忘れずインスタンスを削除しておきましょう!ドメインも不要であれば、消す

# pingで疎通確認

``` sh
ping {IP}
```

# HTTPみてみる

``` sh
# インストール
yum install nginx
# 起動と同時にデーモンで起動
systemctl enable nginx

# client側 > パケットキャプチャ(先GUIでやってから、tcpdump)
ip.dst==206.189.47.88 or ip.src ==206.189.47.88
tcpdump -s 0 -w packets_dump host 206.189.47.88

# server側 > パケットキャプチャ
tcpdump -s 0 -w packets_dump_port_80 port 80
# scpでファイルを転送
scp -i ~/.ssh/id_rsa root@206.189.47.88:/root/packets_dump_port_80 .
# server側 > システムコール
strace -p {nginxのpid}
```

# HTTPSみてみる

## おれおれ証明書

``` sh
sudo mkdir /etc/ssl/private
sudo chmod 700 /etc/ssl/private
sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/nginx-selfsigned.key -out /etc/ssl/certs/nginx-selfsigned.crt
sudo openssl dhparam -out /etc/ssl/certs/dhparam.pem 2048

# nginxのsslに関する設定の書き換えと再起動
sudo vi /etc/nginx/conf.d/ssl.conf
sudo nginx -t
sudo systemctl restart nginx

# => これでhttpsでブラウザでアクセスしてみよー
# => これでwiresharkで暗号化されているのか見てみよう
# => 評価してもらおう https://www.ssllabs.com/ssltest
# ちなみに僕やったときはTだったwww
```

```
server {
    listen 443 http2 ssl;
    listen [::]:443 http2 ssl;

    server_name {common name};

    ssl_certificate /etc/ssl/certs/nginx-selfsigned.crt;
    ssl_certificate_key /etc/ssl/private/nginx-selfsigned.key;
    ssl_dhparam /etc/ssl/certs/dhparam.pem;
}
```

## Let's encrypt

```
# clinetをinstall
yum install epel-release
sudo yum install python2-certbot-nginx
# nginxを止めてから、証明書の発行
systemctl stop nginx.service
sudo certbot certonly --standalone -t

# 再度sslの設定(certbotコマンドの終わりに鍵とか出てくる) => 再起動
sudo vi /etc/nginx/conf.d/ssl.conf
nginx -t
systemctl start nginx.service

# => これでhttpsでブラウザでアクセスしてみよー
# => これでwiresharkで暗号化されているのか見てみよう
# => 評価してもらおう https://www.ssllabs.com/ssltest
# ちなみに僕やったときはBだったwww
# これをAにしてみよう!!
# https://cipherli.st/ とか参考に

```

# SMTPをみてみる

`送信: SMTP, 受信: POP3/IMAP`と捉えていると混乱する、
正しくは`転送: SMTP, 取得: POP3/IMAP`と考えたほうがいい。

```
yum install postfix
yum install mailx

# メール送信時の...mail logやらなにやら
echo "body" |  mail -s "title" feqypi@getnada.com
# server側 パケットキャプチャ
tcpdump -s 0 -w packets_dump_port_25 port 25
# scpでファイルを転送
scp -i ~/.ssh/id_rsa root@206.189.47.88:/root/packets_dump_port_80 .
```


[degital ocean coupon codes](https://gist.github.com/ellerbrock/a6fc476e1a59f306b8a06c3ac64a6a17)
https://ja.wikipedia.org/wiki/Simple_Mail_Transfer_Protocol

# 参考になる資料

- [よい入門サイト](https://beginners-network.com/)
- [ネットワークエンジニアとして](https://www.infraexpert.com/)
- [インフラ/ネットワークエンジニアのためのネットワーク技術&設計入門](https://www.amazon.co.jp/%E3%82%A4%E3%83%B3%E3%83%95%E3%83%A9-%E3%83%8D%E3%83%83%E3%83%88%E3%83%AF%E3%83%BC%E3%82%AF%E3%82%A8%E3%83%B3%E3%82%B8%E3%83%8B%E3%82%A2%E3%81%AE%E3%81%9F%E3%82%81%E3%81%AE%E3%83%8D%E3%83%83%E3%83%88%E3%83%AF%E3%83%BC%E3%82%AF%E6%8A%80%E8%A1%93-%E8%A8%AD%E8%A8%88%E5%85%A5%E9%96%80-%E3%81%BF%E3%82%84%E3%81%9F-%E3%81%B2%E3%82%8D%E3%81%97/dp/4797373512/ref=sr_1_1?ie=UTF8&qid=1548988413&sr=8-1&keywords=%E3%83%8D%E3%83%83%E3%83%88%E3%83%AF%E3%83%BC%E3%82%AF)
- [スタリングTCP/IP 入門編](https://www.amazon.co.jp/%E3%83%9E%E3%82%B9%E3%82%BF%E3%83%AA%E3%83%B3%E3%82%B0TCP-IP-%E5%85%A5%E9%96%80%E7%B7%A8-%E7%AC%AC5%E7%89%88-%E7%AB%B9%E4%B8%8B/dp/4274068765/ref=sr_1_12?ie=UTF8&qid=1548988413&sr=8-12&keywords=%E3%83%8D%E3%83%83%E3%83%88%E3%83%AF%E3%83%BC%E3%82%AF)
- [おれの記事1](https://qiita.com/Kohei909Otsuka/items/39a03b44e370f848a07a)
- [おれの記事2](https://qiita.com/Kohei909Otsuka/items/2743d40184453da6cf3f)

# 参考にした資料

- [DO self signed cert](https://www.digitalocean.com/community/tutorials/how-to-create-a-self-signed-ssl-certificate-for-nginx-on-centos-7)
- [lets encryptについて](http://jxck.hatenablog.com/entry/letsencrypt-acme)
- [lets encrypt centos](https://certbot.eff.org/lets-encrypt/centosrhel7-nginx)
- [Qita nginx & lets encrypt](https://qiita.com/HeRo/items/f9eb8d8a08d4d5b63ee9)
- [Qita https](https://qiita.com/kuni-nakaji/items/5118b23bf2ea44fed96e)
- [SMTP](http://www.atmarkit.co.jp/ait/articles/0105/02/news001.html)

# 次週以降ニーズがあれば

- websocket
- HTTP2

