# Ganbaru 

![Work Hard](https://25.media.tumblr.com/tumblr_lrkyzeVtcc1qm6oc3o1_500.gif)

[![Build Status](https://travis-ci.org/deanobarnett/ganbaru.svg?branch=master)](https://travis-ci.org/deanobarnett/ganbaru)

_Ganbaru (頑張る)_: Japanese word meaning to "_slog on tenaciously through tough times_".

This gem helps dealing with large, unwieldy test suites. Ganbaru uses a queue and workers to parallelize your test suite, with a fairly even time distribution.

Currently Ganbaru makes some assumptions on your stack:

- You are using RSpec for testing.
- You have access to Redis.

## How it works

Ganbaru runs in two modes: *leader* and *worker*. 

*Leader mode*: Ganbaru will gather all the spec files and load the test names into a Redis list. The key for this list is a unique ID assigned by the user.

*Worker mode:* Ganbaru will pick spec files off the Redis queue and run them through the test runner. It is intended that you can start multiple workers to churn through a tests quicker. Unlike other parallel strategies, working through the queue should result in all workers finishing at approximately the same time.

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

Ganbaru has a CLI interface. 

### Starting a Ganbaru Leader 

First, assign an ID. The ID could be your Jenkins Build unique ID, a generated UUID, or a commit SHA for your application. This ID will identify the test run.

`ganbaru leader ./spec --id hello-world-1`

### Starting a Ganbaru worker 

To run Ganbaru in worker mode, pass in the ID of the test queue.

`ganbaru worker --id hello-world-1`

### Environment Variables

The only environment variable needed is the Redis URL.

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
