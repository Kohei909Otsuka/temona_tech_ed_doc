# Setup

``` bash
# 下記すべてlocalでの作業

# containerの中でcreate appをしてreact appの初期化
# !!空のフォルダじゃないと怒られます!!
docker run \
  --rm \
  --workdir /app \
  -v ${PWD}:/app \
  -it node:12.2.0-alpine \
  /bin/sh -c \
  "npm install -g create-react-app@3.0.1 && \
  create-react-app ."

# Dockerfileの追加
echo 'FROM node:12.2.0-alpine' >> Dockerfile
echo 'WORKDIR /app' >> Dockerfile
echo 'COPY package.json /app/package.json' >> Dockerfile
echo 'RUN npm install --silent' >> Dockerfile

# docker経由で動いているか確認
echo node_modules/ >> .gitignore
echo node_modules/ >> .dockerignore
docker build -t chat_ui:latest .

docker run \
  --rm \
  -v ${PWD}:/app \
  -v /app/node_modules \
  -p 3030:3000 \
  chat_ui:latest \
  npm start

# => ブラウザからlocalhost:3030にアクセスして確認できればok

# commitしておく
git add . && git commit -m "init react app"
```
