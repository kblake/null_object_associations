# NullObjectAssociations

Return empty arrays or nil for associations. A nice little addition to null objects. Especially nice for those used in Rails.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'null_object_associations'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install null_object_associations

## Usage

```
class NullUser
  include NullObjectAssociations

  has_many                :friends
  has_many                :cousins,  respond_to: [:pluck, :completed]
  has_many                :cars,     respond_to: :any
  has_and_belongs_to_many :accounts, respond_to: [:pluck, :completed]
  has_one                 :house
  belongs_to              :spouse
end
```


## Contributing

1. Fork it ( https://github.com/[my-github-username]/null_object_associations/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
