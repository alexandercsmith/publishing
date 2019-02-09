# Publishing

[Twitter](https://twitter.com/sudoawesome) | [Medium](https://medium.com/@sudoawesome)

Publishing Module for Ruby on Rails Model's.

## Install

Location of Module
```
~/app/models/concerns/publishing.rb
```

Migration to Model
```
$ rails g migration AddPublishingTo{MODEL} published:boolean published_at:datetime
```

Edit Migration File
```ruby
...
t.boolean "published", default: false
...
```

Run Migration to Database
```
$ rails db:migrate
```

Include Module in Model
```ruby
include Publishing
```

Publish Method
```ruby
@model.publish_toggle
```
