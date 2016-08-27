# Ganbaru

![Work Hard](https://25.media.tumblr.com/tumblr_lrkyzeVtcc1qm6oc3o1_500.gif)

Ganbaru, Japanese word meaning to _slog on tenaciously through tough times_.

This gem can be used as a method for dealing with large and unwieldy test suites. The main strategy is to use a queue and workers to fan out and parallelize your test suite, with a fairly even distribution.

This gem makes some assumptions on your stack at the moment:

- You are using RSpec for testing.
- You have access to Redis.

## How it works

Ganbaru run in two modes, leader mode and worker mode. In leader mode Ganbaru will gather all the spec files in a supplied directory and load all the names into a Redis list. The key for this list is a unique ID assigned by the user.

In Worker mode, Ganbaru will pick spec files off the queue and run them through the test runner. It is intended that you can start multiple worker to to churn through a large number of tests quicker, and with a fairly even distribution.

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

Ganbaru uses a pretty basic CLI interface. To start Ganbaru in leader mode the following command can be used to run on the `spec` directory with and predefined id. The id could be your Jenkins Build unique ID, a generated UUID, or a commit sha for your application. This should be something that identifies are particular spec run.

`ganbaru leader spec/ --id hello-world-1`

To run Ganbaru in worker mode, the command below demonstrates an example command that can be used to run a worker against the `hello-world-1` build that we defined in the previous example.

### ENV Vars

The only environment variable needed is the Redis URL to use.

- `REDIS_URL=`

## Development

If you want to develop on Ganbaru, there are a few useful things you should know.

### Running the tests
`rake`

### Running locally
You can use the Docker container to make running Ganbaru easier. Simply build the container and run any commands you need through the container. The Docker entrypoint is set to ganbaru, so you can run commands directly.

```shell
docker-compose build service
docker-compose run --rm service leader --id some-id
```

## Todo

- Add statsd metrics for tests.
- Fan out tests per worker using Thread Pools.
- Add more test runner implementations.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/deanobarnett/ganbaru. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
