USER  ?= user@gmail.com
PASS  ?= patata
MONGODB_ATLAS ?= mongodb+srv://<username>:<password>@<cluster>.mongodb.net
DOCKER_COMPOSE_TEST=docker-compose -f docker-compose.test.yml
DOCKER_COMPOSE_PROD=docker-compose -f docker-compose.prod.yml
VERSION=0.0.1
DOCKER_NAMESPACE?=lucferbux
DOCKER_TAG_SNAPSHOT=$(shell echo VERSION)-$(shell git rev-parse --short HEAD)-SNAPSHOT

# Init Scripts

.PHONY: dev-api
dev-api:
	cd api && npm run dev

.PHONY: dev-ui
dev-ui:
	cd ui && npm run start

.PHONY: dev-ui-secure
dev-ui-secure:
	cd ui && npm run start-secure

.PHONY: dev-start
dev-start: 
	make -j 3 mongo-start dev-api dev-ui

# DB Scripts

.PHONY: dev-populate-data
dev-populate-data:
	cd scripts && ./mongoimport.sh

.PHONY: dev-delete-data
dev-delete-data:
	cd scripts && ./mongodelete.sh

.PHONY: mongo-start
mongo-start:
	cd scripts && ./mongostart.sh

.PHONY: mongo-export
mongo-export:
	cd scripts && ./mongoexport.sh


.PHONY: dev-bbdd-start-populate
dev-bbdd-start-populate: mongo-start dev-populate-data

.PHONY: generate-password
generate-password:
	cd scripts && ./generatepass.sh $(USER) $(PASS)

.PHONY: import-atlass
import-atlass:
	cd scripts && ./mongoimportatlass.sh $(MONGODB_ATLAS)

# Installation scripts

.PHONY: install-ui
install-ui:
	cd ui && npm install

.PHONY: install-api
install-api:
	cd api && npm install

.PHONY: install-dependencies
install-dependencies: npm install


# Audit scripts

.PHONY: audit-frontend
audit-frontend:
	cd ui && npm audit

.PHONY: audit-api
audit-api:
	cd api && npm audit

# Testing

.PHONY: story-book
story-book:
	cd ui && npm run storybook

.PHONY: test
test:
	CI=true npm run test

# Docker

.PHONY: docker-build-images
docker-build-images:
	docker build -t $(DOCKER_NAMESPACE)/api:$(DOCKER_TAG_SNAPSHOT) ./api
	docker build -t $(DOCKER_NAMESPACE)/nginx:$(DOCKER_TAG_SNAPSHOT) -f nginx/Dockerfile .

.PHONY: docker-deploy
docker-deploy: docker-build-images
	for component in api nginx; do \
		docker push $(DOCKER_NAMESPACE)/$$component:$(DOCKER_TAG_SNAPSHOT) ; \
	done

.PHONY: docker-dev-up
docker-dev-up:
	docker-compose up --build -d

.PHONY: docker-prod-up
docker-prod-up:
	$(DOCKER_COMPOSE_PROD) up --build

.PHONY: docker-ci-up
docker-ci-up:
	$(DOCKER_COMPOSE_TEST) up --build -d

.PHONY: docker-ci-api
docker-ci-api: docker-ci-up
	$(DOCKER_COMPOSE_TEST) run node npm run lint
	$(DOCKER_COMPOSE_TEST) run node npm run test

# Kubernetes

.PHONY: k8s-create-ns
k8s-create-ns:
	kubectl create namespace portfolio-app

.PHONY: k8s-deploy
k8s-deploy:
	kubectl apply -f delivery/kubernetes/ -n portfolio-app

.PHONY: k8s-status
k8s-status:
	kubectl get all -n portfolio-app

.PHONE: k8s-status-pods
k8s-status-pods:
	kubectl get pods -n portfolio-app

.PHONE: k8s-delete-all
k8s-delete-all:
	kubectl delete -f delivery/kubernetes/ -n portfolio-app

.PHONY: k8s-get-service
k8s-get-service:
	minikube service frontend-nginx-service --url -n portfolio-app 

.PHONY: k8s-dashboard
k8s-dashboard:
	minikube dashboard

# Certificates

.PHONY: generate-certificates
generate-certificates:
	cd nginx && ./generate-certificates.sh