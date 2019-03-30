# 事前準備

[postico client](https://eggerapps.at/postico/)をinstallする
[docker](https://docs.docker.com/docker-for-mac/install/)をinstallする

# dbに触って慣れる

最初GUI(postico)で全部やる => 同じことをCUI(psql)でやる

## dockerの動作確認

``` sh
# installできているか確認
docker --version

# postgres containerをデーモンで起動
docker run --name p_container -e POSTGRES_PASSWORD=kohei -p 5432:5432 -d postgres

# 起動したcontainerの確認
dokcer ps
docker exec -it p_container psql -U postgres
```

- `shop`という名前のdatabaseを作る
  - `users`というtableを作る
  - `orders`というtableを作る
  - `order_items`というtableを作る
  - 簡単なCRUDしてみる
  - Rに集中してみる(psqlから)
    - https://www.mockaroo.com/ でdummy dataをいっぱいつくる
    - WHERE users.name = ''
    - WHERE users.name = '' OR users.name = ''
    - JOIN
    - etc...
