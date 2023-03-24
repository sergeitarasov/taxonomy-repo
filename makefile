# Variables
CSV_DIR := csv
OWL_DIR := owl
TEMPLATE := $(CSV_DIR)/template-taxon.csv
OUTPUT := $(OWL_DIR)/taxonomy-repo.owl
GOOGLE_DRIVE_LINK := "https://docs.google.com/spreadsheets/d/1PB_vgPJzh6Q0oHUCKEHox0AtC6xIqNkrXBf1o0ciNNM/export?format=csv"

# Phony targets
.PHONY: all clean download_csv

# Default target: download CSV and generate OWL file
all: download_csv $(OUTPUT)

# Download CSV file from Google Drive
download_csv:
	@mkdir -p $(CSV_DIR)
	gdown $(GOOGLE_DRIVE_LINK) -O $(TEMPLATE)

# Rule for converting CSV to OWL
$(OUTPUT): $(TEMPLATE)
	@mkdir -p $(OWL_DIR)
	robot template --template $< \
  --prefix "ex: http://example.com/" \
  --ontology-iri "https://github.com/sergeitarasov/taxonomy-repo/" \
  --output $@

# Clean target: remove the CSV and OWL directories and their contents
clean:
	rm -rf $(CSV_DIR) $(OWL_DIR)
