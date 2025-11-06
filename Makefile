DOCKER_COMPOSE_DIR	:=	./docker
IMAGES_DIR		:=	images
TF_DIR		:=	infra/terraform

default: help
.PHONY: help
help: # 0. Show help for each of the Makefile recipes. 
	@grep -E '^[a-zA-Z0-9 -]+:.*#' Makefile | sort -t '#' -k 2 | while read -r l; do printf "\033[1;32m$$(echo $$l | cut -f 1 -d':')\033[00m:$$(echo $$l | cut -f 2- -d'#')\n"; done

## Docker Compose Commands For Fast Development

.PHONY: dc-up
dc-up: # 1. Start Docker Compose services
	docker-compose -f ${DOCKER_COMPOSE_DIR}/docker-compose.yml up -d
	docker ps

.PHONY: dc-down
dc-down: # 2. Stop Docker Compose services
	docker-compose -f ${DOCKER_COMPOSE_DIR}/docker-compose.yml down
	docker ps

.PHONY: dc-recreate
dc-recreate: # 3. Recreate Docker Compose services
	docker-compose -f ${DOCKER_COMPOSE_DIR}/docker-compose.yml up -d --force-recreate

## Terraform Docs and Graph

.PHONY: tf-vars-b64
tf-vars-b64: # Encode Terraform variable file to Base64. Used for GitHub Secrets. Example: make tf-vars-b64 ENV=prod
	@if [ -z "$(ENV)" ]; then echo "Please set ENV (e.g. make tf-vars-b64 ENV=dev)"; exit 1; fi
	base64 -w0 $(TF_DIR)/$(ENV).tfvars > backup/$(ENV).vars.b64

.PHONY: tf-docs
tf-docs: # 4. Generate Terraform documentation
	terraform -chdir=$(TF_DIR) init -backend=false
	terraform-docs markdown $(TF_DIR)/. > $(TF_DIR)/TF_DOCS.md

.PHONY: tf-graph
tf-graph: # 5. Generate Terraform graph visualization
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
