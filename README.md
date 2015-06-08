## initializing database 

```ruby
heroku run console
require './app.rb'
DB.run("create table beers (name text, brewery text)")
```

## console 

```ruby
bundle exec irb -r ./src.rb
```
