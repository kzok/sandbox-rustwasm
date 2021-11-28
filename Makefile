.DEFAULT_GOAL := help
CARGO_MANIFEST_PATHS := $(shell git ls-files "**/Cargo.toml")

# tasks

.PHONY: help ## Display this help screen
help:
	@grep -E '^.PHONY: [a-zA-Z_-]+ ## .*$$' $(MAKEFILE_LIST) |\
		sed -r "s/^\.PHONY: //" |\
		awk 'BEGIN {FS = " ## "}; {printf "%-20s %s\n", $$1, $$2}'

.PHONY: fmt ## Run "npm run fmt" and "cargo fmt"
fmt: node_modules
	@npm run fmt
	@for path in "$(CARGO_MANIFEST_PATHS)"; do cargo fmt --manifest-path $$path ; done

# deps

node_modules: package-lock.json
	npm ci
	touch node_modules
