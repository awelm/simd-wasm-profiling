(module
  (func $summation (param $lhs i32) (param $rhs i32) (result v128)
    v128.const i32x4 1 0 0 0
    v128.const i32x4 12 0 0 0
    i32x4.add
  )
  (export "summation" (func $summation))
)