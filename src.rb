# bundle exec irb -r ./src.rb

require 'rubygems'
require 'sequel'
require 'sqlite3'
require 'byebug'
#require 'sinatra'

#DB = Sequel.sqlite # memory database
DB = Sequel.connect('sqlite:///Users/mluukkai/kurssirepot/tikape/ruby/sequel/database.sqlite3')

#DB.create_table :items do
#  primary_key :id
#  String :name
#  Float :price
#end

items = DB[:items] # Create a dataset

class Item < Sequel::Model
end

class Beer < Sequel::Model
end

#byebug

# Populate the table
#items.insert(:name => 'abc', :price => rand * 100)
#items.insert(:name => 'def', :price => rand * 100)
#items.insert(:name => 'ghi', :price => rand * 100)

puts "start"

# Print out the number of records
puts "Item count: #{items.count}"

# Print out the average price
puts "The average price is: #{items.avg(:price)}"

puts "end"
