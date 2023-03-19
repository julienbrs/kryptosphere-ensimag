BASE_IMAGE = node:18
SCAFFOLD_REPO = https://github.com/scaffold-eth/scaffold-eth.git
SCAFFOLD_DIR = $(PWD)/.scaffold-repo
SCAFFOLD_WORKING_DIR = /opt/scaffold-eth
CONTAINER_NAME = SCAFFOLD_ETH

FRONT_LOGS = /.front_logs
HARDHAT_LOGS = /.hardhat_logs

EXPOSE_FRONT_PORT = 3000
RUN_OPTS = \
-dt \
--name $(CONTAINER_NAME) \
-w $(SCAFFOLD_WORKING_DIR) \
-v $(SCAFFOLD_DIR):$(SCAFFOLD_WORKING_DIR) \
-p $(EXPOSE_FRONT_PORT):3000 \
-p 8545:8545

#################
# Main macros   #
#################

all: container install chain deploy start

reboot: rm all

# Tip: use interactive target if needed

#################
# Docker        #
#################

container: $(SCAFFOLD_DIR)
	@if [ -z "$$(docker ps -q --filter name=$(CONTAINER_NAME))" ]; then \
		docker run $(RUN_OPTS) $(BASE_IMAGE); \
		docker exec -t $(CONTAINER_NAME) bash -c "touch $(FRONT_LOGS) && touch $(HARDHAT_LOGS)"; \
	fi

rm: stop
	docker rm $(CONTAINER_NAME)

rm-hard:
	docker rm -f $(CONTAINER_NAME)

# Wait a maximum of 5 seconds
stop:
	docker stop -t 5 $(CONTAINER_NAME)

interactive: container
	docker exec -ti $(CONTAINER_NAME) bash

#################
# Scaffold-eth  #
#################

$(SCAFFOLD_DIR):
	git clone $(SCAFFOLD_REPO) $(SCAFFOLD_DIR)

update: $(SCAFFOLD_DIR)
	cd scaffold-eth
	git pull

install: container
	docker exec -ti $(CONTAINER_NAME) bash -c "yarn install"

# Start harhat chain
chain: container
	docker exec -dt $(CONTAINER_NAME) bash -c "yarn chain > $(HARDHAT_LOGS) 2>&1"
	sleep 5

# Start react front serving
start: container
	docker exec -dt $(CONTAINER_NAME) bash -c "yarn start > $(HARDHAT_LOGS) 2>&1"

deploy: container
	docker exec -ti $(CONTAINER_NAME) bash -c "yarn deploy"

#################
# Logs          #
#################

logs-all: logs-front logs-hardhat

logs-front:
	@if [ -z "$$(docker ps -q --filter name=$(CONTAINER_NAME))" ]; then \
		echo "No front end logs since the container is not launched yet"; \
	else \
		echo ========== FRONTEND LOGS =========================; \
		docker exec -ti $(CONTAINER_NAME) bash -c "cat $(FRONT_LOGS)"; \
	fi

logs-hardhat:
	@if [ -z "$$(docker ps -q --filter name=$(CONTAINER_NAME))" ]; then \
		echo "No hardhat logs since the container is not launched yet"; \
	else \
		echo ========== HARDHAT LOGS =========================; \
		docker exec -ti $(CONTAINER_NAME) bash -c "cat $(HARDHAT_LOGS)"; \
	fi