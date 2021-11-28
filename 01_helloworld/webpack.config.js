const path = require('path');

module.exports = {
  entry: "./src/index.ts",
  output: {
    path: path.resolve(__dirname, "dist"),
    filename: "index.js",
  },
  mode: "development",
  module: {
    rules: [
      {test: /\.wasm$/,type: "webassembly/async"},
      { test: /\.tsx?$/, loader: "ts-loader" },
    ]
  },
  resolve: {
    extensions: [".ts", ".tsx", ".js"]
  },
  experiments: {
    asyncWebAssembly: true, 
  },
};
