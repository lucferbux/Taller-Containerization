USER  ?= user@gmail.com
PASS  ?= patata
MONGODB_ATLAS ?= mongodb+srv://<username>:<password>@<cluster>.mongodb.net


# Init Scripts

.PHONY: dev-api
dev-api:
	cd api && npm run dev

.PHONY: dev-ui
dev-ui:
	cd ui && npm run dev

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