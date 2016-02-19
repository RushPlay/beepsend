# Beepsend

Simple gem that implements sending SMS using Beepsend API [api.beepsend.com/docs.html](http://api.beepsend.com/docs.html#send-sms)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'beepsend'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install beepsend

## Configuaration

You can configurate by adding this code to Rails initializer for example:

```ruby
Beepsend.configure do |config|
  config.token = 'XXX' # you get this token after registering in Beepsend
  config.from = 'Mailman' # when you don't specify 'from' argument in `Beepsend::Client#send_sms` it will use value from here
  config.receive_dlr = 0 # Specify whether delivery reports should be sent to your DLR Callback URL, 0 by default
end
```

## Usage

Here is example usage of this gem:

```ruby
beepsend = Beepsend::Client.new

# Message has been successfully sent
beepsend.send_sms(to: '380xxxxxxxx2', from: 'Sender', message: 'hello')
=> "[{\"id\":[\"0966xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx2\"],\"from\":\"Sender\",\"to\":\"380xxxxxxxx2\"}]"

# Invalid recipient
> beepsend.send_sms(to: 'wrong recipient', from: 'Sender', message: 'hello')
=> "{\"errors\":[{\"code\":1031,\"description\":\"\\\"to\\\" is required and needs to be between 3-17 chars and not null\"}]}"

# Invalid from
> beepsend.send_sms(to: '380xxxxxxxx2', from: 'Bad from field', message: 'hello')
=> "{\"errors\":[{\"code\":1030,\"description\":\"\\\"from\\\" can not be longer than 11 characters\"}]}"

# Empty message
> beepsend.send_sms(to: '380xxxxxxxx2', from: 'Sender', message: '')
=> "{\"errors\":[{\"code\":1036,\"description\":\"body must not be empty\"}]}"

# Invalid API token
> beepsend.send_sms(to: '380xxxxxxxx2', from: 'Sender', message: 'hello')
=> "{\"errors\":[\"A valid API-token is required.\"]}"
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/RushPlay/beepsend.

## License

MIT
