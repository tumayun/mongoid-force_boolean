# mongoid-force_boolean

Mongoid document boolean type field must be boolean.

## Installation

- git clone git@github.com:tumayun/mongoid-force_boolean.git
- cd mongoid-force_boolean
- gem build  mongoid-force_boolean.gemspec
- gem install mongoid-force_boolean-x.x.x.gem
- Add this line to your application's Gemfile:

        gem 'mongoid-force_boolean', require: 'force_boolean'


## Usage

```ruby
class Post
  include Mongoid::Document
  include Mongoid::ForceBoolean

  field :published, type: Boolean
  field :title,     type: String
  field :body,      type: String
end

post = Post.new(title: 'title', body: 'body', publushed: 0)
post.save      #=> true
post.published #=> false

post.published = 1
post.save      #=> true
post.published #=> true

post.published = false
post.save      #=> true
post.published #=> false

post.published = true
post.save      #=> true
post.published #=> true

post.published = 100
post.save      #=> false
post.errors[:published] #=> ['must be boolean']
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Reques
