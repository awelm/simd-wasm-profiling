# Exploring SIMD performance improvements in WebAssembly

Run following command to profile 128-bit SIMD performance:
```
wat2wasm --enable-simd fillBufferWithSIMD.wat && time wasmer fillBufferWithSIMD.wasm -i fillBufferWithSIMD 1000
```

Run following command to profile 32-bit non-SIMD performance:
```
wat2wasm --enable-simd fillBufferWithoutSIMD.wat && time wasmer fillBufferWithoutSIMD.wasm -i fillBufferWithoutSIMD 1000
```
