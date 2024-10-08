NOW := $(shell date -Is)

.PHONY: build
build:
	docker build . -t rhartman99/doctorio:$(VERSION) --build-arg version=$(VERSION) --build-arg build_date=$(NOW)

.PHONY: publish
publish: build
	docker image push rhartman99/doctorio:$(VERSION)
