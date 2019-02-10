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

## Usage

Model
```ruby
include Publishing
```

Queries
```ruby
# All Models where published: true
Model.is_published

# All Models where published: false
Model.is_unpublished
```

Ordering
```ruby
# published_at: :asc
Model.is_published.published_asc

# published_at: :desc
Model.is_published.published_desc
```

Controller
```ruby
def publish
  @model = Model.find(params[:id])
  @model.publish_toggle
  # Response
end
```

View
```ruby
= link_to @model.publish_link, model_publish_path(@model), method: :put
```

Routes
```ruby
put '/model/:id/publish' => 'model#publish'
```
```ruby
put '/model/:id/publish', to: 'model#publish'
```
```ruby
put '/model/:id/publish', to: :publish, controller: 'models'
```
