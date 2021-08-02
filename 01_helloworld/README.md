# helloworld

## 参考にしたもの

- [wasm-pack](https://rustwasm.github.io/docs/wasm-pack/introduction.html)
- [webpack](https://webpack.js.org/)
- [Rust から WebAssembly にコンパイルする](https://developer.mozilla.org/ja/docs/WebAssembly/Rust_to_wasm)
  - webpack 4 系を前提で書かれているので 5 系に脳内変換するとうごきました。

## やったこと

### wasm-pack のインストール

- [ここ](https://rustwasm.github.io/wasm-pack/installer/)からインストールできた。

### wasm-pack プロジェクトの新規作成

- `wasm-pack new helloworld` で `helloworld/` 配下にファイルが生成されるので必要なものだけ取り入れる。

### ビルドしてみる

- `wasm-pack build` を実行すると `pkg/` 配下に `.wasm` や `.js` が生成される。

### webpack のインストールとセットアップ

- なくても動かせるが手元の環境が wsl2 で http サーバ経由で動かせた方が都合が良かったので webpack-dev-server をつかった。

```bash
echo '{"private": true}' > package.json
npm i -D webpack webpack-cli webpack-dev-server
```

- `webpack.config.js` を用意する。
  - webpack で wasm を動かすには experimantal な設定が必要らしい
    - https://github.com/rustwasm/wasm-pack/issues/835#issuecomment-772591665

- webpack のエントリーポイントになる `index.js` を用意する。

### webpack-dev-server から動かす

`npx webpack serve --open` でブラウザが開き `Hello, helloworld!` という alert が出てくる。
