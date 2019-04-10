var fs = require("fs");
fs.readFile("fib.wasm", function (err, data) {
  if (err) throw err;
  
  WebAssembly.instantiate(data, {}).then(({instance}) => {
    console.log(Object.keys(instance.exports));
    console.log(instance.exports.fib(30));
  });
});
