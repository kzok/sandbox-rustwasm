# helloworld

## 参考にしたもの

- [wasm-pack](https://rustwasm.github.io/docs/wasm-pack/introduction.html)
- [webpack](https://webpack.js.org/)
- [Rust から WebAssembly にコンパイルする](https://developer.mozilla.org/ja/docs/WebAssembly/Rust_to_wasm)
  - webpack 4 系を前提で書かれているので 5 系に脳内変換するとうごきました。

## うごかし方

```bash
# wasm-pack のインストール
curl https://rustwasm.github.io/wasm-pack/installer/init.sh -sSf | sh

# wasm-pack でビルドしてから webpack-dev-server とブラウザを立ち上げる
make dev
```

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

`npx webpack serve --open` でブラウザが開き `Hello, helloworld!` という alert が出てきた。

### wasm 側で引数を取るように変更

`fn greet() -> void` を `fn greet(name: &str) -> void` にして挨拶する相手の名前を入力できるようにした。
js 側の引数がなかったり string 型でないと動かないようになっていた。

```
helloworld_bg.js:69 Uncaught (in promise) Error: expected a string argument
    at passStringToWasm0 (helloworld_bg.js:69)
    at Module.greet (helloworld_bg.js:110)
    at eval (index.js:8)
```

### wasm 側で引数を取るように変更

`fn greet(name: &str) -> String` にして js 側で alert() することができた。
ちなみに `#[wasm_bindgen]` マクロがついている関数では lifetime が指定できないようになっているみたいで `&str` を戻り値に指定するとビルドができなかった。