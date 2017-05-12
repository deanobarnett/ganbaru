.PHONY: test

test:
	@docker-compose build test
	@docker-compose run test
