# ファイルの基礎

- そもそもファイルってなに?誰が提供してる概念?
- UserとGroupという概念
- ファイルの実行権限


``` sh
# 空のファイルの作成
touch test1

# ファイルの確認
ls -al

# userの一覧
dscl . list /Users | grep -v '_'

# -rw-r--r--  1 kohei  staff
#  => staff groupが所有, koheiが所有のファイル
   => 権限はユーザ(r, w), グループ(r), その他(r)

# このファイルの権限を変えてr,r,r,にしたらどうなるか...
# r(read): 2の2乗 = 4
# w(write): 2の1乗 = 2
# x(excute): 2の0乗 = 1

chmod 444 test1
ehco "hello world" >> test1

# あるいはrootの所有に変えて、koheiが読もうとしたらどうなるのか
chmod 644 test1
chown root test1
chmod 600 test1
less test1
```
