(module
  ;; Allocate a memory buffer of 1000 64Kb pages
  (memory (export "memory") 1000 1000)
  (func $fillBufferWithoutSIMD (param $randomIndex i32) (result i32)
    ;; The buffer pointer starts at 0 and total buffer size is 64Mb
    (local $bufferPtr i32)
    (local $bufferSizeBytes i32)
    (set_local $bufferPtr (i32.const 0))
    (set_local $bufferSizeBytes (i32.const 64000000))

    (block $break
      (loop $top
        ;; Loop while buffer pointer is less than total buffer size
        (br_if $break (i32.eq (get_local $bufferSizeBytes) (get_local $bufferPtr)))
        ;; Set the current 32-bit block (pointed to by bufferPtr) to contain all 1's
        (i32.store (get_local $bufferPtr) (i32.const 0xFFFFFFFF))
        ;; Increment buffer pointer by 32-bits (aka 4 bytes)
        (set_local $bufferPtr (i32.add (get_local $bufferPtr) (i32.const 4)))
        (br $top)
      )
    )
    ;; Return the 32-bit value pointed to by randomIndex
    (i32.load (i32.mul (get_local $randomIndex) (i32.const 4)))
  )
  (export "fillBufferWithoutSIMD" (func $fillBufferWithoutSIMD))
)