(module
  ;; Allocate a memory buffer of 1000 64Kb pages
  (memory (export "memory") 1000 1000)
  (func $fillBufferWithSIMD (param $randomIndex i32) (result v128)
    ;; The buffer pointer starts at 0 and total buffer size is 64Mb
    (local $bufferPtr i32)
    (local $bufferSizeBytes i32)
    (set_local $bufferPtr (i32.const 0))
    (set_local $bufferSizeBytes (i32.const 64000000))

    (block $break
      (loop $top
        ;; Loop while buffer pointer is less than total buffer size
        (br_if $break (i32.eq (get_local $bufferSizeBytes) (get_local $bufferPtr)))
        ;; Set the current 16 byte block (pointed to by bufferPtr) to contain all 1's
        (v128.store (get_local $bufferPtr) (v128.const i32x4 0xFFFFFFFF 0xFFFFFFFF 0xFFFFFFFF 0xFFFFFFFF)) 
        ;; Increment buffer pointer by 16 bytes
        (set_local $bufferPtr (i32.add (get_local $bufferPtr) (i32.const 16)))
        (br $top)
      )
    )
    ;; Return the 16 byte value pointed to by randomIndex
    (v128.load (i32.mul (get_local $randomIndex) (i32.const 16)))
  )
  (export "fillBufferWithSIMD" (func $fillBufferWithSIMD))
)