.PHONY: build
build:
	docker build . -t rhartman99/doctorio:$(VERSION) --build-arg version=$(VERSION)

.PHONY: publish
publish: build
	docker image push rhartman99/doctorio:$(VERSION)
