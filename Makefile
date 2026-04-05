# Set project name 
PROJECT_NAME := invman

# Server
server/build:
	cd $(PROJECT_NAME)_server && dart pub get && dart run build_runner build --delete-conflicting-outputs && serverpod generate

server/migration:
	cd $(PROJECT_NAME)_server && serverpod create-migration

server/migration-force:
	cd $(PROJECT_NAME)_server && serverpod create-migration --force

server/migrate:
	cd $(PROJECT_NAME)_server && dart bin/main.dart --role maintenance --apply-migrations

server/run:
	cd $(PROJECT_NAME)_server && dart bin/main.dart

server/up:
	cd $(PROJECT_NAME)_server && docker compose up -d

server/down:
	cd $(PROJECT_NAME)_server && docker compose down

server/clean:
	cd $(PROJECT_NAME)_server && docker compose down -v --remove-orphans

server/test:
	cd $(PROJECT_NAME)_server && dart fix --apply
	cd $(PROJECT_NAME)_server && dart format .
	cd $(PROJECT_NAME)_server && dart analyze
	cd $(PROJECT_NAME)_server && dart test

server/populate:
	@if [ -z "$(env)" ]; then \
		echo "Usage: make server/populate env=<environment>"; \
		echo "Valid environments: development, staging, production"; \
		exit 1; \
	fi
	cd $(PROJECT_NAME)_server && dart scripts/populate/populate.dart $(env)

# Flutter app
app/clean:
	cd $(PROJECT_NAME)_flutter && flutter clean

app/build:
	cd $(PROJECT_NAME)_flutter && flutter pub get
	cd $(PROJECT_NAME)_flutter && dart run build_runner build --delete-conflicting-outputs
	cd $(PROJECT_NAME)_flutter && dart run intl_utils:generate

app/run:
	cd $(PROJECT_NAME)_flutter && flutter run --flavor develop --dart-define-from-file=.env

app/test:
	cd $(PROJECT_NAME)_flutter && dart fix --apply
	cd $(PROJECT_NAME)_flutter && dart format .
	cd $(PROJECT_NAME)_flutter && dart analyze
	cd $(PROJECT_NAME)_flutter && flutter test


# Kubernetes commands
NAMESPACE := production
infra/server/logs:
	kubectl logs -n $(NAMESPACE) deployment/rimawari-server -f   

infra/db/logs:
	kubectl logs -n $(NAMESPACE) statefulset/rimawari-postgresql -f

infra/db/forward:
	kubectl port-forward -n $(NAMESPACE) statefulset/rimawari-postgresql 5432:5432  

infra/redis/logs:
	kubectl logs -n $(NAMESPACE) statefulset/rimawari-redis -f

infra/apply:
	kubectl apply -f infrastructure/kubernetes

infra/server/delete:
	kubectl delete -n $(NAMESPACE) deployment/rimawari-server service/rimawari-server

infra/db/delete:
	@echo "WARNING: This will permanently delete the database pod, service, and all its data (PVC)."
	@read -p "Type 'yes' to confirm: " confirm && [ "$$confirm" = "yes" ] || (echo "Aborted." && exit 1)
	kubectl delete -n $(NAMESPACE) statefulset/rimawari-postgresql service/rimawari-postgresql --ignore-not-found
	kubectl delete -n $(NAMESPACE) pvc/data-rimawari-postgresql-0 --ignore-not-found
	@echo "Database deleted."

infra/db/restore:
	@if [ ! -f infrastructure/backup.sql ]; then \
		echo "Error: infrastructure/backup.sql not found."; \
		exit 1; \
	fi
	@echo "Restoring database from infrastructure/backup.sql..."
	kubectl cp infrastructure/backup.sql $(NAMESPACE)/rimawari-postgresql-0:/tmp/backup.sql
	kubectl exec -n $(NAMESPACE) rimawari-postgresql-0 -- bash -c 'PGPASSWORD=$$POSTGRES_PASSWORD psql -U postgres -d serverpod < /tmp/backup.sql'
	@echo "Restore complete."
