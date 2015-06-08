require 'rubygems'
require 'sinatra'
require './config'

class Beer < Sequel::Model
end

get '/' do
  erb :home
end

get '/create_form' do
  erb :beer_form
end

post '/create' do
  name = params[:name]
  brewery = params[:brewery]
  #Beer.create(name: name, brewery: brewery)
  DB.run("insert into beers values ('#{name}', '#{brewery}')")
  redirect '/beers'
end

get '/beers' do
  #@beers = Beer.all
  @beers = DB.fetch("select * from beers")
  erb :all_beers
end

__END__

@@layout
<html>
  <a href="/beers">beers</a>
  <a href="/create_form">create</a>
  <%=yield%>
</html>

@@beer_form

<h1>luo olut</h1>

<form action="/create" method="post">
  name:<br>
  <input type="text" name="name">
  <br>
  brewery:<br>
  <input type="text" name="brewery">
  <br><br>
  <input type="submit" value="Submit">
</form>

@@home
<h1>beerapp!</h1>

@@all_beers

<h1>oluet</h1>

<ul>
  <% for beer in @beers do %>
    <li>
      <%= beer[:name] %> brewed by <%= beer[:brewery] %>
    </li>
  <% end %>
</ul>