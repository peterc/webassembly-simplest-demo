const fs = require("fs");
const data = fs.readFileSync("fib.wasm");

WebAssembly.instantiate(data, {}).then(({ instance }) => {
  console.log(Object.keys(instance.exports));
  console.log(instance.exports.fib(30));
});
