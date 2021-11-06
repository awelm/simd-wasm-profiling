(module
  ;; Allocate a memory buffer of 1000 64Kb pages
  (memory (export "memory") 1000 1000)
  (func $fillBufferWithSIMD (param $numIterations i32)
    ;; declare local variables
    (local $currentIteration i32)
    (local $bufferPtr i32)
    (local $bufferSizeBytes i32)

    ;; Set currentIteration=0 and bufferSizeBytes=64Mb 
    (set_local $currentIteration (i32.const 0))
    (set_local $bufferSizeBytes (i32.const 64000000))

    ;; For each iteration we will fill the entire memory buffer with 1 bits 
    (block $breakAllIterations
      (loop $allIterationsTop
        ;; Loop while currentIteration < numIterations 
        (br_if $breakAllIterations (i32.eq (get_local $numIterations) (get_local $currentIteration)))

        ;; Prepare for the current iteration. The buffer pointer should start at 0
        (set_local $bufferPtr (i32.const 0))

        (block $breakCurrentIteration
          (loop $currentIterationTop
            ;; Loop while buffer pointer is less than total buffer size
            (br_if $breakCurrentIteration (i32.eq (get_local $bufferSizeBytes) (get_local $bufferPtr)))
            ;; Set the current 128-bit block (pointed to by bufferPtr) to contain all 1's
            (v128.store (get_local $bufferPtr) (v128.const i32x4 0xFFFFFFFF 0xFFFFFFFF 0xFFFFFFFF 0xFFFFFFFF)) 
            ;; Increment buffer pointer by 128-bits (aka 16 bytes)
            (set_local $bufferPtr (i32.add (get_local $bufferPtr) (i32.const 16)))
            (br $currentIterationTop)
          )
        )

        (set_local $currentIteration (i32.add (get_local $currentIteration) (i32.const 1))) 
        (br $allIterationsTop) 
      ) 
    )
  )
  (export "fillBufferWithSIMD" (func $fillBufferWithSIMD))
)