.DEFAULT_GOAL := help

# tasks

.PHONY: help ## Display this help screen
help:
	@grep -E '^.PHONY: [a-zA-Z_-]+ ## .*$$' $(MAKEFILE_LIST) |\
		sed -r "s/^\.PHONY: //" |\
		awk 'BEGIN {FS = " ## "}; {printf "%-20s %s\n", $$1, $$2}'

.PHONY: dev ## Build and launch webpack-dev-server
dev:
	wasm-pack build --dev cargo
	npm run dev

.PHONY: test ## Run tests with cargo and wasm-pack
test:
	wasm-pack test --node cargo
	cargo test --manifest-path ./cargo/Cargo.toml

# deps
