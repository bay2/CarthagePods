# CarthagePods

The Cocoa dependency manager. The Use of [CocoaPods](https://github.com/CocoaPods/CocoaPods) and [Carthage](https://github.com/Carthage/Carthage) dependency manager on together.

## Installation

First installing `Carthage`, detailed [see](https://github.com/Carthage/Carthage#installing-carthage).

Add this line to your application's Gemfile:

```ruby
gem 'CarthagePods'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install CarthagePods

## Usage


* Run `carthagePods init` in your project directory. Your project directory in generate `Podfile`,`Cartfile`,`CPodfile` .
* If you want to use `CocoaPods` manager dependencies between libraries . You can edit `Podfile` add your dependencies. [Detailed see](https://guides.cocoapods.org/using/using-cocoapods.html).
* If you want to use `Carthage` manager dependencies and compile framework. You can edit `Cartfile` add your dependencies. [Detailed see](https://github.com/Carthage/Carthage/blob/master/Documentation/Artifacts.md#cartfile).
* `CarthagePods` `Carthage` compile framework will be packaged into a `pod lib`. `CPodfile` provides a method of filtering framework.

```
filterFramework ['RxTest.framework', 'RxBlocking.framework']
```

* Run `carthagePods install` in your project directory.
* Open `App.xcworkspace` and build.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/bay2/CarthagePods. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

