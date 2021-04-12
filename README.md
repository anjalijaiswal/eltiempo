# Eltiempo

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/eltiempo`. To experiment with that code, run `bin/console` for an interactive prompt.

TODO: Delete this and the text above, and describe your gem

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'eltiempo'
```

And then execute:
    ```ruby
    $ bundle install
    ```
Or install it yourself as:
    ```ruby
    $ gem install eltiempo
    ```

For running in local, clone the project
  ```ruby
  $ git clone git@github.com:anjalijaiswal/eltiempo.git
  $ cd eltiempo
  $ bundle exec rake install
  ```

For this gem I used Tiempo API. If you want to use your own app id, you need to register here[https://www.tiempo.com/] to get an app ID(affiliate_id).

I’ve obtained an app ID and set it as default. If you want to use your's set it as environment variable ELTIEMPO_APP_ID.

You can set it in your ENV by running:
    ```ruby
    $ ENV['ELTIEMPO_APP_ID'] = 'your affiliate_id'
    ```

## Usage

NOTE: If city passed is not valid, or city_url is not valid, it will calculate the Barcelona municipality by default.

If you are running gem as a CLI, its exposing three functions, today, av_max, av_min, also it expect one of the cities of Barcelona as argument:
  ```ruby
  $ eltiempo -today "Gavà"
  $ eltiempo -av_max "Gavà"
  $ eltiempo -av_min "Gavà"
  ```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/eltiempo. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/[USERNAME]/eltiempo/blob/master/CODE_OF_CONDUCT.md).


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Eltiempo project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/eltiempo/blob/master/CODE_OF_CONDUCT.md).
