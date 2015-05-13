# FuzzyString

A ranking system for strings.  The rank by itself is arbitrary and only has context when compared to other ranks.
The base score is the levenschtein distance which is modified by other basic matching criteria.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'fuzzy_string'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install fuzzy_string

## Usage

To use as a ranking system (the 'rank' a string has based on another):

```ruby
    $ 'test case 1'    ^ 'test case' #=>  2.5
    $ 'test case 1'    ^ 'test'      #=>  8.75
    $ 'tesla roadster' ^ 'test'      #=> 18.5
```

To access the levenshtein distance:

```ruby
    $ 'Test case' - 'case' #=> 5
```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/fuzzy_string/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

Author
-------

* Chris Moody

License
-------

This is free software released into the public domain.
