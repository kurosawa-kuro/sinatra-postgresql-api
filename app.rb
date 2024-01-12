require 'sinatra'
require 'pg'

# データベース接続設定
set :db_config, {
  host: 'localhost',
  dbname: 'development_db',
  user: 'dev_user',
  password: 'dev_password'
}

# todoの一覧を表示するページ
get '/todos' do
  conn = PG.connect(settings.db_config)
  result = conn.exec('SELECT * FROM todo')

  @todos = result.map do |row|
    { id: row['id'], title: row['title'] }
  end

  conn.close

  erb :todos
end
