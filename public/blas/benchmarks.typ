#set page(width: 8.5in, height: 266in)
#show link: set text(fill: rgb("#1e6bd6"))

= CORAL Benchmarks 
Deval Deliwala 

Apple M4, 16GB unified memory. All benchmarks are single-precision 
and single-threaded. 

Each plot shows: 
- `coral-safe` (portable-simd, safe Rust)
- `coral-neon` (AArch64 / NEON unsafe)
- a reference implementation: 
  - OpenBLAS armv8, or 
  - Apple Accelerate, or 
  - BLIS, or 
  - faer

The OpenBLAS backend used is optimized for Level 2-3. Level 1 (memory-bound) benchmarks are 
roughly meaningless. 

== Table of contents
- #link(<openblas>)[OpenBLAS]
  - #link(<openblas-l1>)[Level 1]
  - #link(<openblas-l2>)[Level 2]
  - #link(<openblas-l3>)[Level 3]
- #link(<apple-accelerate>)[Apple Accelerate]
  - #link(<accel-l1>)[Level 1]
  - #link(<accel-l2>)[Level 2]
  - #link(<accel-l3>)[Level 3]


== OpenBLAS <openblas>

=== Level 1 <openblas-l1>

===== `isamax`
$"argmax"_i |x_i|$

#align(center)[
  #image("images/openblas/isamax.png", width: 80%)
]

===== `sasum`
$sum_i |x_i|$

#align(center)[
  #image("images/openblas/sasum.png", width: 80%)
]

===== `saxpy`
$y arrow.l alpha x + y$

#align(center)[
  #image("images/openblas/saxpy.png", width: 80%)
]

===== `scopy`
$y arrow.l x$

#align(center)[
  #image("images/openblas/scopy.png", width: 80%)
]

===== `sdot`
$sum_i x_i y_i$

#align(center)[
  #image("images/openblas/sdot.png", width: 80%)
]

===== `snrm2`
$sqrt(sum_i x_i^2)$

#align(center)[
  #image("images/openblas/snrm2.png", width: 80%)
]

===== `srot`
$x_i' = c x_i + s y_i, \ y_i' = c y_i - s x_i
$

#align(center)[
  #image("images/openblas/srot.png", width: 80%)
]

===== `srotm`
$mat(x_i'; y_i') = H mat(x_i; y_i)$

#align(center)[
  #image("images/openblas/srotm.png", width: 80%)
]

===== `sscal`
$x arrow.l alpha x$

#align(center)[
  #image("images/openblas/sscal.png", width: 80%)
]

===== `sswap`
$x <-> y$

#align(center)[
  #image("images/openblas/sswap.png", width: 80%)
]


=== Level 2 <openblas-l2>

===== `sgemv`
$y arrow.l alpha op(A) x + beta y$

#align(center)[
  #image("images/openblas/sgemv_n.png", width: 80%)
]

#align(center)[
  #image("images/openblas/sgemv_t.png", width: 80%)
]

===== `sger`
$A arrow.l alpha x y^T + A$

#align(center)[
  #image("images/openblas/sger.png", width: 80%)
]

===== `ssymv`
$y arrow.l alpha A x + beta y,  A = A^T$

#align(center)[
  #image("images/openblas/ssymv_lower.png", width: 80%)
]

#align(center)[
  #image("images/openblas/ssymv_upper.png", width: 80%)
]

===== `ssyr`
$A arrow.l alpha x x^T + A$

#align(center)[
  #image("images/openblas/ssyr_lower.png", width: 80%)
]

#align(center)[
  #image("images/openblas/ssyr_upper.png", width: 80%)
]

===== `ssyr2`
$A arrow.l alpha (x y^T + y x^T) + A$

#align(center)[
  #image("images/openblas/ssyr2_lower.png", width: 80%)
]

#align(center)[
  #image("images/openblas/ssyr2_upper.png", width: 80%)
]

===== `strmv`
$x arrow.l op(A) x$

#align(center)[
  #image("images/openblas/strumv_n.png", width: 80%)
]

#align(center)[
  #image("images/openblas/strumv_t.png", width: 80%)
]

#align(center)[
  #image("images/openblas/strlmv_n.png", width: 80%)
]

#align(center)[
  #image("images/openblas/strlmv_t.png", width: 80%)
]

===== `strsv`
$x arrow.l A^-1 b$

#align(center)[
  #image("images/openblas/strusv_n.png", width: 80%)
]

#align(center)[
  #image("images/openblas/strusv_t.png", width: 80%)
]

#align(center)[
  #image("images/openblas/strlsv_n.png", width: 80%)
]

#align(center)[
  #image("images/openblas/strlsv_t.png", width: 80%)
]


=== Level 3 <openblas-l3>

==== `sgemm`
$C arrow.l alpha "op"(A) "op"(B) + beta C$

#align(center)[
  #image("images/openblas/sgemm_nn.png", width: 80%)
]
#align(center)[
  #image("images/openblas/sgemm_tt.png", width: 80%)
] 


== Apple Accelerate <apple-accelerate>

These benchmarks are the same as above, but against _Apple Accelerate_.
For critical routines like `sgemv` and `sgemm`, Accelerate uses 
#link("https://research.meekolab.com/the-elusive-apple-matrix-coprocessor-amx")[AMX] 
and is _much_ faster. Consequently it masks comparison between my implementation 
and other BLAS shown above. 

=== Level 1 <accel-l1>

===== `isamax`
$"argmax"_i |x_i|$

#align(center)[
  #image("images/accelerate/isamax.png", width: 80%)
]

===== `sasum`
$sum_i |x_i|$

#align(center)[
  #image("images/accelerate/sasum.png", width: 80%)
]

===== `saxpy`
$y arrow.l alpha x + y$

#align(center)[
  #image("images/accelerate/saxpy.png", width: 80%)
]

===== `scopy`
$y arrow.l x$

#align(center)[
  #image("images/accelerate/scopy.png", width: 80%)
]

===== `sdot`
$sum_i x_i y_i$

#align(center)[
  #image("images/accelerate/sdot.png", width: 80%)
]

===== `snrm2`
$sqrt(sum_i x_i^2)$

#align(center)[
  #image("images/accelerate/snrm2.png", width: 80%)
]

===== `srot`
$x_i' = c x_i + s y_i, \ y_i' = c y_i - s x_i
$

#align(center)[
  #image("images/accelerate/srot.png", width: 80%)
]

===== `srotm`
$mat(x_i'; y_i') = H mat(x_i; y_i)$

#align(center)[
  #image("images/accelerate/srotm.png", width: 80%)
]

===== `sscal`
$x arrow.l alpha x$

#align(center)[
  #image("images/accelerate/sscal.png", width: 80%)
]

===== `sswap`
$x <-> y$

#align(center)[
  #image("images/accelerate/sswap.png", width: 80%)
]


=== Level 2 <accel-l2>

===== `sgemv`
$y arrow.l alpha op(A) x + beta y$

#align(center)[
  #image("images/accelerate/sgemv_n.png", width: 80%)
]

#align(center)[
  #image("images/accelerate/sgemv_t.png", width: 80%)
]

===== `sger`
$A arrow.l alpha x y^T + A$

#align(center)[
  #image("images/accelerate/sger.png", width: 80%)
]

===== `ssymv`
$y arrow.l alpha A x + beta y,  A = A^T$

#align(center)[
  #image("images/accelerate/ssymv_lower.png", width: 80%)
]

#align(center)[
  #image("images/accelerate/ssymv_upper.png", width: 80%)
]

===== `ssyr`
$A arrow.l alpha x x^T + A$

#align(center)[
  #image("images/accelerate/ssyr_lower.png", width: 80%)
]

#align(center)[
  #image("images/accelerate/ssyr_upper.png", width: 80%)
]

===== `ssyr2`
$A arrow.l alpha (x y^T + y x^T) + A$

#align(center)[
  #image("images/accelerate/ssyr2_lower.png", width: 80%)
]

#align(center)[
  #image("images/accelerate/ssyr2_upper.png", width: 80%)
]

===== `strmv`
$x arrow.l op(A) x$

#align(center)[
  #image("images/accelerate/strumv_n.png", width: 80%)
]

#align(center)[
  #image("images/accelerate/strumv_t.png", width: 80%)
]

#align(center)[
  #image("images/accelerate/strlmv_n.png", width: 80%)
]

#align(center)[
  #image("images/accelerate/strlmv_t.png", width: 80%)
]

===== `strsv`
$x arrow.l A^-1 b$

#align(center)[
  #image("images/accelerate/strusv_n.png", width: 80%)
]

#align(center)[
  #image("images/accelerate/strusv_t.png", width: 80%)
]

#align(center)[
  #image("images/accelerate/strlsv_n.png", width: 80%)
]

#align(center)[
  #image("images/accelerate/strlsv_t.png", width: 80%)
]


=== Level 3 <accel-l3>

==== `sgemm`
$C arrow.l alpha "op"(A) "op"(B) + beta C$

#align(center)[
  #image("images/accelerate/sgemm_nn.png", width: 80%)
]

#align(center)[
  #image("images/accelerate/sgemm_tt.png", width: 80%)
]

