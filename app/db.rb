DATABASE = "gerb_db"

require 'rubygems'
require 'bundler'

Bundler.require :default



ActiveRecord::Base.establish_connection(
  "postgres://postgres@localhost/#{DATABASE}"
)

puts ActiveRecord::Base.connected?
puts ActiveRecord::Base.connection.execute("SELECT 1;")