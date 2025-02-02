# Set project name 
PROJECT_NAME := invman

# Server
server/build:
	cd $(PROJECT_NAME)_server && serverpod generate

server/migration:
	cd $(PROJECT_NAME)_server && serverpod create-migration

server/migration-force:
	cd $(PROJECT_NAME)_server && serverpod create-migration --force

server/migrate:
	cd $(PROJECT_NAME)_server && dart bin/main.dart --role maintenance --apply-migrations

server/run:
	cd $(PROJECT_NAME)_server && dart bin/main.dart

# Flutter app
app/build:
	cd $(PROJECT_NAME)_flutter && dart run build_runner build --delete-conflicting-outputs
	cd $(PROJECT_NAME)_flutter && flutter pub get
	
app/run:
	cd $(PROJECT_NAME)_flutter && flutter run -d macos --target lib/main_development.dart

app/gen:
	cd $(PROJECT_NAME)_flutter && flutter pub run build_runner build --delete-conflicting-outputs

app/gen_watch:
	cd $(PROJECT_NAME)_flutter && flutter pub run build_runner watch --delete-conflicting-outputs

app/gen_l10n:
	cd $(PROJECT_NAME)_flutter && dart run intl_utils:generate