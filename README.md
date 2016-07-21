# Ganbaru

![Rocky](https://media.giphy.com/media/yoJC2JaiEMoxIhQhY4/giphy.gif)

Ganbaru, Japanese word meaning to _slog on tenaciously through tough times_.

This gem is used as a method for dealing with large and unwieldy test suites. The main stategy is to use a queue and workers to fan out and parallelize your test suite, with a fairly even distribution.

This gem makes some assumptions on your stack at the moment:

- You are using RSpec for testing.
- You have access to Redis.

## How it works

### Leader

- Create list in Redis
- Gather all spec files and load them into Redis.

### Worker

- Start Rails/Test environment.
- Take items from the Redis queue and run them.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'ganbaru'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install ganbaru

## Usage

id generated if not supplied (print this out for reference)
workers default to 1

To start the leader server run `GANBARU_ROLE=leader ganbaru`. (Pass in RSpec config? Directory to run?)

To start the worker server run `GANBARU_ROLE=worker ganbaru`.

### ENV Vars

`REDIS_URL=`
`BUILD_ID=` ?

## Development

Run tests using `rake`

## Todo

- Make CLI?
- Add statsd metrics for tests?
- Use run tests on a Thread.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/ganbaru. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

