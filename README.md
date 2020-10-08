# Guard::Standardrb

Welcome to the new guard plugin `guard-standardrb`!
This guard is bases on the gem `standardrb`, you can find more information about it https://github.com/testdouble/standard

StandardRB is essentially a wrapper on top of RuboCop, but enforce code convention without much configuration possible.
This plugin will run with your guard while you modify your code and output any code conventions errors in the terminal.

More Information about StandardRb:
The beauty of Ruby Standard Style is that it's simple. No one wants to maintain multiple hundred-line style configuration files for every module/project they work on. Enough of this madness!

This gem saves you (and others!) time in three ways:

No configuration. The easiest way to enforce consistent style in your project. Just drop it in.
Automatically format code. Just run standardrb --fix and say goodbye to messy or inconsistent code.
Catch style issues & programmer errors early. Save precious code review time by eliminating back-and-forth between reviewer & contributor.
Adopting Standard style means ranking the importance of code clarity and community conventions higher than personal style. This might not make sense for 100% of projects and development cultures, however open source can be a hostile place for newbies. Setting up clear, automated contributor expectations makes a project healthier.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'guard-standardrb'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install guard-standardrb

To add this guard plugin to your repo, run:

    $ bundle exec guard init standardrb

## Usage

Once you installed the gem on your repo and initialized it to be added to your GuardFile,
just run `bundle exec guard` and you should see a line `Standardrb initialized`.
This means that the guard will run on all files that will be modified by that point in time and output the erros.

Please read [Guard usage doc](https://github.com/guard/guard#readme).

## Add the argument fix

with the release of the version `0.2.0` the gem gets the possibility to auto fix standardrb errors that could be easily fixed.
you can choose to activate or disable it.

After the initilisation of the guard, jump into the GuardFile and you can modify the argument fix to be `true` or `false`

```
guard :standardrb fix: false do
 ...
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/guard-standardrb. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/[USERNAME]/guard-standardrb/blob/master/CODE_OF_CONDUCT.md).


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Guard::Standardrb project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/guard-standardrb/blob/master/CODE_OF_CONDUCT.md).

### Author

[Jody Vandenschrick](https://github.com/JodyVanden) ([@jodyvanden](https://twitter.com/jodyvanden))

### Contributors

[https://github.com/JodyVanden/guard-standardrb/graphs/contributors](https://github.com/JodyVanden/guard-standardrb/graphs/contributors)
