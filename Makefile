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

current_directory := $(shell pwd)
build-all: ##
		echo ${current_directory}

	cd ${current_directory}/elasticsearch; docker build -t elasticsearch-img:7.14.1 .
	cd ${current_directory}/logstash; docker build -t logstash-img:7.14.1 .
	cd ${current_directory}/kibana; docker build -t kibana-img:7.14.1 .
	
deploy-all: ##
	docker compose up -d logstash
	docker compose up -d elasticsearch
	docker compose up -d kibana
	sleep 15 ;
	cd bin ; bash create_pattern.sh 
	