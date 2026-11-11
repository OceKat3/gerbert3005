DATABASE = "gerb_db"

require 'rubygems'
require 'bundler'
require 'pg'

Bundler.require :default



ActiveRecord::Base.establish_connection(
  "postgres://postgres@localhost"
)

ActiveRecord::Base.connection.execute("SELECT 1;")
