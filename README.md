# Niwa

Niwa is a new documentation tool for Ruby. It stands for "New, Integrated, Working Annotations".

Currently nothing is implemented, but here are some concepts.

- Data Source: a layer close to source code, such as code itself, comment, test code and so on
- Handler: a module to convert data source into an internal, unified data structure
- Internal Data Structure (IDS): a JSON-convertable object representing documentation
- Representation: a final document such as HTML document

## Installation

Install the gem and add to the application's Gemfile by executing:

    $ bundle add niwa

If bundler is not being used to manage dependencies, install the gem by executing:

    $ gem install niwa

## Usage

The main usage is `niwa` executable.

```sh
niwa foo.rb bar.rb
```

This outputs the result to `result.html` by default. To change the output file, you can give `-o` option.

```sh
niwa foo.rb bar.rb -o my_result.html
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/okuramasafumi/niwa. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/okuramasafumi/niwa/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Niwa project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/okuramasafumi/niwa/blob/master/CODE_OF_CONDUCT.md).
