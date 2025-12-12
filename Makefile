.PHONY: help
help:
	@echo "Makefile commands:"
	@echo "  make setup-graphhopper   - Import map data into GraphHopper"
	@echo "  make run-graphhopper     - Run the GraphHopper server"


.PHONY: run-graphhopper
run-graphhopper:
	@echo "Running the application..."
	@docker compose up graphhopper


.PHONY: setup-graphhopper
setup-graphhopper:
	@echo "Importing map data..."
	@sudo sh ./graphhopper/setup.sh