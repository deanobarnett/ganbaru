# Ganbaru

Ganbaru, Japanese word meaning to _slog on tenaciously through tough times_.

This gem is used as a method for dealing with large and unwieldy test suites. The main stategy is to use a queue and workers to fan out and parallelize your test suite, with a fairly even distribution.

This gem makes some assumptions on your stack at the moment:

- You are using RSpec for testing.
- You have access to AWS SQS.

## How it works
### Leader

- Create 3 queues, `tests`, `results`, `kill`.
- Gather all spec files and batch load them into `tests`.
- Poll and report on `results` until all specs have returned a result.
- Send `kill` signal to all workers.
- Delete all queues.

### Worker

- Start Rails/Test environment.
- Check for `kill` message.
- Take items from the `tests` queue and run them.
- Send result message to the `results` queue.

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

To start the leader server run `Ganbaru.start_leader`. (Pass in RSpec config? Directory to run?)
To run `n` number of workers use `Ganbaru.start_workers(n)`.

### ENV Vars

`AWS_KEY_ID=`
`AWS_ACCESS_KEY=`
`AWS_REGION=`
`MAX_THREADS=`

## Development


## Todo

- Make CLI?
- Add statsd metrics for tests?

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/ganbaru. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

