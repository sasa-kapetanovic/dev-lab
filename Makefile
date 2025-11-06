DOCKER_COMPOSE_DIR	:=	./docker
IMAGES_DIR		:=	images
TF_DIR		:=	infra/terraform

.PHONY: az-providers
az-providers:
	./bin/az-provider-setup.sh

.PHONY: tf-backend-storage
tf-backend-storage:
	./bin/tf-backend-storage.sh

.PHONY: topology
topology:
	docker run --rm -it   -v "${DOCKER_COMPOSE_DIR}:/input"   pmsipilot/docker-compose-viz render   -m image --force docker-compose.yml --output-file=topology.png
	rm -rf ${DOCKER_COMPOSE_DIR}/.cache
	mv ${DOCKER_COMPOSE_DIR}/topology.png ${IMAGES_DIR}/docker-poc-topology.png

.PHONY: dc-up
dc-up:
	docker-compose -f ${DOCKER_COMPOSE_DIR}/docker-compose.yml up -d
	docker ps

.PHONY: dc-down
dc-down:
	docker-compose -f ${DOCKER_COMPOSE_DIR}/docker-compose.yml down
	docker ps

.PHONY: tf-graph
tf-graph:
	terraform -chdir=$(TF_DIR) graph \
	| unflatten -l 3 -f -c 8 \
	| dot -Tpng \
      -Gdpi=192 \
      -Grankdir=LR \
      -Gsplines=true \
      -Goverlap=false \
      -Nshape=box \
      -Nstyle="rounded,filled" \
      -Nfillcolor="#f8f9fb" \
      -Ncolor="#ccd3e0" \
      -Nfontname="DejaVu Sans" \
      -Nfontsize=10 \
      -Ecolor="#8aa0b6" \
      -Earrowsize=0.7 \
      -Efontname="DejaVu Sans" \
      -Efontsize=9 \
		> $(IMAGES_DIR)/graph.png
