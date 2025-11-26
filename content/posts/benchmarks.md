+++
title = "coral benchmarks"
description = "coral-safe & coral-neon vs OpenBLAS and Apple Accelerate"
tags = ["BLAS"]
date = "2025-11-25"
categories = [""]
menu = "main"
+++

{{< katex />}}

Apple M4 (6P + 4E), 16GB unified memory. All benchmarks are single-precision and
single-threaded. 

Each plot shows:
- `coral-safe` (portable-simd, safe Rust)
- `coral-neon` (AArch64 / NEON)
- a reference implementation:
  - OpenBLAS armv8, or
  - Apple Accelerate, or
  - BLIS for `sgemm`
  - faer for `sgemm`/`matmul`

---

## Table of Contents

- [OpenBLAS](#openblas)
  - [Level 1](#level-1)
  - [Level 2](#level-2)
  - [Level 3](#level-3)
- [With Apple Accelerate](#apple-accelerate)
  - [Level 1](#level-1-accelerate)
  - [Level 2](#level-2-accelerate)
  - [Level 3](#level-3-accelerate)


## OpenBLAS

### Level 1

#### ISAMAX — index of max absolute value

![](https://raw.githubusercontent.com/devdeliw/coral/main/plots/openblas/isamax.png)

#### SASUM — sum of absolute values

![](https://raw.githubusercontent.com/devdeliw/coral/main/plots/openblas/sasum.png)

#### SAXPY — scalar vector addition

![](https://raw.githubusercontent.com/devdeliw/coral/main/plots/openblas/saxpy.png)

#### SCOPY — copy vector into another

![](https://raw.githubusercontent.com/devdeliw/coral/main/plots/openblas/scopy.png)

#### SDOT — dot product

![](https://raw.githubusercontent.com/devdeliw/coral/main/plots/openblas/sdot.png)

#### SNRM2 — Euclidean norm

![](https://raw.githubusercontent.com/devdeliw/coral/main/plots/openblas/snrm2.png)

#### SROT — Givens rotation

![](https://raw.githubusercontent.com/devdeliw/coral/main/plots/openblas/srot.png)

#### SROTM — modified Givens rotation

![](https://raw.githubusercontent.com/devdeliw/coral/main/plots/openblas/srotm.png)

#### SSCAL — scale vector

![](https://raw.githubusercontent.com/devdeliw/coral/main/plots/openblas/sscal.png)

#### SSWAP — swap two vectors

![](https://raw.githubusercontent.com/devdeliw/coral/main/plots/openblas/sswap.png)

---

### Level 2

#### SGEMV — matrix–vector multiply  
\\[
y \leftarrow \alpha \operatorname{op}(A)x + \beta y
\\]


![](https://raw.githubusercontent.com/devdeliw/coral/main/plots/openblas/sgemv_n.png)
![](https://raw.githubusercontent.com/devdeliw/coral/main/plots/openblas/sgemv_t.png)

#### SGER — rank-1 update  
\\[
A \leftarrow \alpha x y^T + A
\\]

![](https://raw.githubusercontent.com/devdeliw/coral/main/plots/openblas/sger.png)

#### SSYMV — symmetric matrix–vector multiply  
\\[
y \leftarrow \alpha A x + \beta y, \quad A = A^T
\\]

- stored **lower** triangle:

![](https://raw.githubusercontent.com/devdeliw/coral/main/plots/openblas/ssymv_lower.png)

- stored **upper** triangle:

![](https://raw.githubusercontent.com/devdeliw/coral/main/plots/openblas/ssymv_upper.png)

#### SSYR — symmetric rank-1 update  
\\[
A \leftarrow \alpha x x^T + A
\\]

- **lower** triangle stored:

![](https://raw.githubusercontent.com/devdeliw/coral/main/plots/openblas/ssyr_lower.png)

- **upper** triangle stored:

![](https://raw.githubusercontent.com/devdeliw/coral/main/plots/openblas/ssyr_upper.png)

#### SSYR2 — symmetric rank-2 update  
\\[
A \leftarrow \alpha (x y^T + y x^T) + A
\\]

- **lower** triangle stored:

![](https://raw.githubusercontent.com/devdeliw/coral/main/plots/openblas/ssyr2_lower.png)

- **upper** triangle stored:

![](https://raw.githubusercontent.com/devdeliw/coral/main/plots/openblas/ssyr2_upper.png)

#### STRMV — triangular matrix–vector multiply  
\\[
x \leftarrow \operatorname{op}(A) x
\\]

**Upper triangular (STRMV):**

![](https://raw.githubusercontent.com/devdeliw/coral/main/plots/openblas/strumv_n.png)
![](https://raw.githubusercontent.com/devdeliw/coral/main/plots/openblas/strumv_t.png)

**Lower triangular (STRMV):**

![](https://raw.githubusercontent.com/devdeliw/coral/main/plots/openblas/strlmv_n.png)
![](https://raw.githubusercontent.com/devdeliw/coral/main/plots/openblas/strlmv_t.png)

#### STRSV — triangular solve  
\\[
x \leftarrow A^{-1} b
\\]

**Upper triangular (STRSV):**

![](https://raw.githubusercontent.com/devdeliw/coral/main/plots/openblas/strusv_n.png)
![](https://raw.githubusercontent.com/devdeliw/coral/main/plots/openblas/strusv_t.png)

**Lower triangular (STRSV):**

![](https://raw.githubusercontent.com/devdeliw/coral/main/plots/openblas/strlsv_n.png)
![](https://raw.githubusercontent.com/devdeliw/coral/main/plots/openblas/strlsv_t.png)

---

### Level 3

#### SGEMM — matrix–matrix multiply  
\\[
C \leftarrow \alpha \operatorname{op}(A)\operatorname{op}(B) + \beta C
\\]

![](https://raw.githubusercontent.com/devdeliw/coral/main/plots/openblas/sgemm_nn.png)
![](https://raw.githubusercontent.com/devdeliw/coral/main/plots/openblas/sgemm_tt.png)

---

## Apple Accelerate

The following benchmarks are the same as above, but with Apple Accelerate. 
For critical routines like `sgemv` and `sgemm`, Apple uses [AMX](https://research.meekolab.com/the-elusive-apple-matrix-coprocessor-amx) 
to be much faster. Consequently it masks any comparison between my coral implementations and other BLAS. 

### Level 1 (Accelerate)

#### ISAMAX — index of max absolute value

![](https://raw.githubusercontent.com/devdeliw/coral/main/plots/accelerate/isamax.png)

#### SASUM — sum of absolute values

![](https://raw.githubusercontent.com/devdeliw/coral/main/plots/accelerate/sasum.png)

#### SAXPY — scaled vector addition

![](https://raw.githubusercontent.com/devdeliw/coral/main/plots/accelerate/saxpy.png)

#### SCOPY — copy a vector into another

![](https://raw.githubusercontent.com/devdeliw/coral/main/plots/accelerate/scopy.png)

#### SDOT — dot product

![](https://raw.githubusercontent.com/devdeliw/coral/main/plots/accelerate/sdot.png)

#### SNRM2 — Euclidean norm

![](https://raw.githubusercontent.com/devdeliw/coral/main/plots/accelerate/snrm2.png)

#### SROT — Givens rotation

![](https://raw.githubusercontent.com/devdeliw/coral/main/plots/accelerate/srot.png)

#### SROTM — modified Givens rotation

![](https://raw.githubusercontent.com/devdeliw/coral/main/plots/accelerate/srotm.png)

#### SSCAL — scale a vector

![](https://raw.githubusercontent.com/devdeliw/coral/main/plots/accelerate/sscal.png)

#### SSWAP — swap two vectors

![](https://raw.githubusercontent.com/devdeliw/coral/main/plots/accelerate/sswap.png)

---

### Level 2 (Accelerate)

#### SGEMV — matrix–vector multiply  

![](https://raw.githubusercontent.com/devdeliw/coral/main/plots/accelerate/sgemv_n.png)
![](https://raw.githubusercontent.com/devdeliw/coral/main/plots/accelerate/sgemv_t.png)

#### SGER — rank-1 update

![](https://raw.githubusercontent.com/devdeliw/coral/main/plots/accelerate/sger.png)

#### SSYMV — symmetric matrix–vector multiply

**Lower triangle stored:**

![](https://raw.githubusercontent.com/devdeliw/coral/main/plots/accelerate/ssymv_lower.png)

**Upper triangle stored:**

![](https://raw.githubusercontent.com/devdeliw/coral/main/plots/accelerate/ssymv_upper.png)

#### SSYR — symmetric rank-1 update

**Lower triangle stored:**

![](https://raw.githubusercontent.com/devdeliw/coral/main/plots/accelerate/ssyr_lower.png)

**Upper triangle stored:**

![](https://raw.githubusercontent.com/devdeliw/coral/main/plots/accelerate/ssyr_upper.png)

#### SSYR2 — symmetric rank-2 update

**Lower triangle stored:**

![](https://raw.githubusercontent.com/devdeliw/coral/main/plots/accelerate/ssyr2_lower.png)

**Upper triangle stored:**

![](https://raw.githubusercontent.com/devdeliw/coral/main/plots/accelerate/ssyr2_upper.png)

#### STRMV — triangular matrix–vector multiply

**Upper triangular (STRMV):**

![](https://raw.githubusercontent.com/devdeliw/coral/main/plots/accelerate/strumv_n.png)
![](https://raw.githubusercontent.com/devdeliw/coral/main/plots/accelerate/strumv_t.png)

**Lower triangular (STRMV):**

![](https://raw.githubusercontent.com/devdeliw/coral/main/plots/accelerate/strlmv_n.png)
![](https://raw.githubusercontent.com/devdeliw/coral/main/plots/accelerate/strlmv_t.png)

#### STRSV — triangular solve

**Upper triangular (STRSV):**

![](https://raw.githubusercontent.com/devdeliw/coral/main/plots/accelerate/strusv_n.png)
![](https://raw.githubusercontent.com/devdeliw/coral/main/plots/accelerate/strusv_t.png)

**Lower triangular (STRSV):**

![](https://raw.githubusercontent.com/devdeliw/coral/main/plots/accelerate/strlsv_n.png)
![](https://raw.githubusercontent.com/devdeliw/coral/main/plots/accelerate/strlsv_t.png)

---

### Level 3 (Accelerate)

#### SGEMM — matrix–matrix multiply

![](https://raw.githubusercontent.com/devdeliw/coral/main/plots/accelerate/sgemm_nn.png)
![](https://raw.githubusercontent.com/devdeliw/coral/main/plots/accelerate/sgemm_tt.png)

