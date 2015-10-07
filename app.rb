require 'rubygems'
require 'sinatra'
require './config'

enable :sessions

get '/' do
  query = <<eos
  SELECT * FROM (
    SELECT Tsat.id, text, username, count(user_id) likes
    FROM Tsat LEFT JOIN Like ON Like.tsat_id=Tsat.id
    GROUP BY Tsat.id
  ) ORDER BY id DESC LIMIT 10
eos

  @tsats = DB.fetch(query)
  erb :home
end

post '/login' do
  username = params[:username]
  password = params[:password]

  user = DB.fetch("SELECT * FROM User WHERE "+
                  "username = '#{username}' AND password = '#{password}'").first

  if user
    session[:user] = user
    redirect '/'
  else
    redirect '/login'
  end
end

get '/logout' do
  session[:user] = nil
  redirect '/'
end

get '/login' do
  erb :login
end

post '/tsats/:id/like' do
  tsat_id = params[:id].to_i
  DB.run("INSERT INTO Like(tsat_id, user_id) " +
         "VALUES ('#{tsat_id}', '#{session[:user][:id]}')")

  redirect '/'
end

post '/tsats' do
  message = params[:message]
  DB.run("INSERT INTO Tsat(text, username)"+
         "VALUES ('#{message}', '#{session[:user][:username]}')")

  redirect '/'
end

__END__

@@layout
<html>
  <% if session[:user] %>
    <a href="/logout">logout</a>
    <em>you are logged in as <%= session[:user][:user] %></em>
  <% else %>
    <a href="/login">login</a>
  <% end %>

  <%=yield%>
</html>

@@login

<h1>login</h1>

<form action="/login" method="post">
  username:<br>
  <input type="text" name="username">
  <br>
  password:<br>
  <input type="text" name="password">
  <br>
  <input type="submit" value="Submit">
</form>

@@home
<h1>Snapshat</h1>

<% if session[:user] %>

  <h2>new tsat</h2>

  <div>
    <form action="/tsats" method="post">
      <input type="text" name="message">
      <input type="submit" value="Submit">
    </form>
  </div>

<% end %>

<h2>recent activity</h2>

<ul>
  <% for tsat in @tsats do %>
    <li>
      <em> <%= tsat[:text] %> </em> by <%= tsat[:username] %> has
      <%= tsat[:likes] %> likes
      <form action="tsats/<%=tsat[:id]%>/like" method="post">
        <input type="submit" value="like">
      </form>
    </li>
  <% end %>
</ul>