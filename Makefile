.PHONY: test run

run:
	@docker-compose build service
	@docker-compose run --rm service ${ARGS}

test:
	@docker-compose build test
	@docker-compose run --rm test
