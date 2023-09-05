FROM ruby:3.2.2

# Node.jsとYarnのセットアップ
RUN curl -fsSL https://deb.nodesource.com/setup_lts.x | bash - && apt-get install -y nodejs
RUN npm install --global yarn

# MySQL clientのインストール
RUN apt-get install -y default-mysql-client

# アプリケーションディレクトリのセットアップ
WORKDIR /myapp
COPY . /myapp

# Bundlerの正しいバージョンをインストール
RUN gem install bundler:2.4.10

# 依存関係のインストール
RUN bundle install
RUN yarn install

# アセットのプリコンパイル
RUN rails assets:precompile

# エントリーポイントのセットアップ
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

# ポート3000を公開
EXPOSE 3000
