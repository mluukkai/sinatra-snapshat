## initializing database 

```ruby
heroku run console
require './app.rb'
DB.run(query)
```

tables

``` sql
CREATE TABLE Tsat(id integer primary key, text text, username text)
CREATE TABLE Like(id integer primary key, user_id integer, tsat_id)
CREATE TABLE User(id integer primary key, password text, username text, user text)
```

users

``` sql
INSERT INTO User(username, password, name) VALUES ('mluukkai', 'sekret', 'm luukkainen')
``` 

## console 

```ruby
bundle exec irb -r ./src.rb
```
