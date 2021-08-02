const js = import("./pkg/helloworld.js");
js.then(js => {
  js.greet("WebAssembly");
});
