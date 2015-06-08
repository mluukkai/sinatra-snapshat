require 'sequel'
require 'sinatra/reloader'

configure :development do
  require 'sqlite3'
  require 'byebug'
  path = "sqlite://#{File.expand_path(File.dirname(__FILE__))}/database.sqlite3"
  DB = Sequel.connect(path)
end

configure :production do
  DB = Sequel.connect(ENV['DATABASE_URL'])
end