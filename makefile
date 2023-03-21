TEMPLATE_DIR := csv
OWL_DIR := owl
TEMPLATE := $(TEMPLATE_DIR)/template-taxon.csv
OUTPUT := $(OWL_DIR)/taxa.owl

.PHONY: all clean

all: $(OUTPUT)

$(OUTPUT): $(TEMPLATE)
	@mkdir -p $(OWL_DIR)
	robot template --template $< \
  --prefix "ex: http://example.com/" \
  --ontology-iri "https://github.com/ontodev/robot/examples/template.owl" \
  --output $@

clean:
	rm -rf $(OWL_DIR)
