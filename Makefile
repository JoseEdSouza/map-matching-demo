
.PHONY: run-graphhopper
run-graphhopper:
	@echo "Running the application..."
	@docker compose up graphhopper


.PHONY: setup-graphhopper
setup-graphhopper:
	@echo "Importing map data..."
	@sudo sh ./graphhopper/setup.sh