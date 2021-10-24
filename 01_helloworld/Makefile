.DEFAULT_GOAL := help

# tasks

.PHONY: help
help: ## Display this help screen
	@grep -E '^[a-zA-Z_-]+:( [^#]+)* ## .*$$' $(MAKEFILE_LIST) | \
		awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

.PHONY: dev
dev: node_modules ## Build and launch webpack-dev-server
	wasm-pack build --dev cargo
	npm run dev

.PHONY: test
test: node_modules ## Run tests with cargo and wasm-pack
	wasm-pack test --node cargo
	cargo test --manifest-path ./cargo/Cargo.toml

# deps

node_modules: package-lock.json
	npm ci
	touch node_modules
