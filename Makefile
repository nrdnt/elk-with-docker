.PHONY: all
all: help

## Help
help: ## Display help
	@echo ''
	@echo 'Usage:'
	@echo '  make <target>'
	@echo ''
	@echo 'Targets:'
	@awk 'BEGIN {FS = ":.*?## "} { \
		if (/^[a-zA-Z_-]+:.*?##.*$$/) {printf "    %-20s%s\n", $$1, $$2} \
		else if (/^## .*$$/) {printf "  %s\n", substr($$1,4)} \
		}' $(MAKEFILE_LIST)

build-all: ##
	cd elasticsearch; docker build -t elasticsearch-img:7.14.1 .
	cd logstash; docker build -t logstash-img:7.14.1 .
	cd kibana; docker build -t kibana-img:7.14.1 .

deploy-all: ##
	docker compose up -d logstash
	docker compose up -d elasticsearch
	docker compose up -d kibana

	