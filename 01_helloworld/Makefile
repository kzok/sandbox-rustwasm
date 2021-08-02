.PHONY: dev
dev: node_modules
	wasm-pack build --dev cargo
	npm run dev

.PHONY: test
test:
	wasm-pack test --node cargo

node_modules: package-lock.json
	npm ci
