+++
title = "CORAL Benchmarks (single precision)"
description = "coral-safe & coral-neon vs OpenBLAS and Apple Accelerate (s-precision)"
tags = ["BLAS"]
date = "2025-10-31"
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
  - **OpenBLAS**, or
  - **Apple Accelerate**
  - **faer** for `sgemm`/`matmul`

---

## Table of Contents

- [OpenBLAS](#openblas)
  - [Level 1](#level-1)
  - [Level 2](#level-2)
  - [Level 3](#level-3)
- [With Apple Accelerate Too](#apple-accelerate)
  - [Level 1](#level-1-accelerate)
  - [Level 2](#level-2-accelerate)
  - [Level 3](#level-3-accelerate)


## OpenBLAS

### Level 1

#### ISAMAX — index of max absolute value

![](https://raw.githubusercontent.com/devdeliw/coral/main/coral/plots/openblas/isamax.png)

#### SASUM — sum of absolute values

![](https://raw.githubusercontent.com/devdeliw/coral/main/coral/plots/openblas/sasum.png)

#### SAXPY — y ← α x + y

![](https://raw.githubusercontent.com/devdeliw/coral/main/coral/plots/openblas/saxpy.png)

#### SCOPY — y ← x

![](https://raw.githubusercontent.com/devdeliw/coral/main/coral/plots/openblas/scopy.png)

#### SDOT — dot product

![](https://raw.githubusercontent.com/devdeliw/coral/main/coral/plots/openblas/sdot.png)

#### SNRM2 — Euclidean norm

![](https://raw.githubusercontent.com/devdeliw/coral/main/coral/plots/openblas/snrm2.png)

#### SROT — Givens rotation (in-place)

![](https://raw.githubusercontent.com/devdeliw/coral/main/coral/plots/openblas/srot.png)

#### SROTM — modified Givens rotation

![](https://raw.githubusercontent.com/devdeliw/coral/main/coral/plots/openblas/srotm.png)

#### SSCAL — x ← α x

![](https://raw.githubusercontent.com/devdeliw/coral/main/coral/plots/openblas/sscal.png)

#### SSWAP — swap two vectors

![](https://raw.githubusercontent.com/devdeliw/coral/main/coral/plots/openblas/sswap.png)

---

### Level 2

#### SGEMV — matrix–vector multiply  
\\[
y \leftarrow \alpha \operatorname{op}(A)x + \beta y
\\]

- `n`: no-transpose `op(A) = A`  
- `t`: transpose `op(A) = A^T`

![](https://raw.githubusercontent.com/devdeliw/coral/main/coral/plots/openblas/sgemv_n.png)
![](https://raw.githubusercontent.com/devdeliw/coral/main/coral/plots/openblas/sgemv_t.png)

#### SGER — rank-1 update  
\\[
A \leftarrow \alpha x y^T + A
\\]

![](https://raw.githubusercontent.com/devdeliw/coral/main/coral/plots/openblas/sger.png)

#### SSYMV — symmetric matrix–vector multiply  
\\[
y \leftarrow \alpha A x + \beta y, \quad A = A^T
\\]

- stored **lower** triangle:

![](https://raw.githubusercontent.com/devdeliw/coral/main/coral/plots/openblas/ssymv_lower.png)

- stored **upper** triangle:

![](https://raw.githubusercontent.com/devdeliw/coral/main/coral/plots/openblas/ssymv_upper.png)

#### SSYR — symmetric rank-1 update  
\\[
A \leftarrow \alpha x x^T + A
\\]

- **lower** triangle stored:

![](https://raw.githubusercontent.com/devdeliw/coral/main/coral/plots/openblas/ssyr_lower.png)

- **upper** triangle stored:

![](https://raw.githubusercontent.com/devdeliw/coral/main/coral/plots/openblas/ssyr_upper.png)

#### SSYR2 — symmetric rank-2 update  
\\[
A \leftarrow \alpha (x y^T + y x^T) + A
\\]

- **lower** triangle stored:

![](https://raw.githubusercontent.com/devdeliw/coral/main/coral/plots/openblas/ssyr2_lower.png)

- **upper** triangle stored:

![](https://raw.githubusercontent.com/devdeliw/coral/main/coral/plots/openblas/ssyr2_upper.png)

#### STRMV — triangular matrix–vector multiply  
\\[
x \leftarrow \operatorname{op}(A) x
\\]

- `u` = upper, `l` = lower  
- `n` = no-transpose, `t` = transpose

**Upper triangular (STRMV):**

![](https://raw.githubusercontent.com/devdeliw/coral/main/coral/plots/openblas/strumv_n.png)
![](https://raw.githubusercontent.com/devdeliw/coral/main/coral/plots/openblas/strumv_t.png)

**Lower triangular (STRMV):**

![](https://raw.githubusercontent.com/devdeliw/coral/main/coral/plots/openblas/strlmv_n.png)
![](https://raw.githubusercontent.com/devdeliw/coral/main/coral/plots/openblas/strlmv_t.png)

#### STRSV — triangular solve  
\\[
x \leftarrow A^{-1} b
\\]

**Upper triangular (STRSV):**

![](https://raw.githubusercontent.com/devdeliw/coral/main/coral/plots/openblas/strusv_n.png)
![](https://raw.githubusercontent.com/devdeliw/coral/main/coral/plots/openblas/strusv_t.png)

**Lower triangular (STRSV):**

![](https://raw.githubusercontent.com/devdeliw/coral/main/coral/plots/openblas/strlsv_n.png)
![](https://raw.githubusercontent.com/devdeliw/coral/main/coral/plots/openblas/strlsv_t.png)

---

### Level 3

#### SGEMM — matrix–matrix multiply  
\\[
C \leftarrow \alpha \operatorname{op}(A)\operatorname{op}(B) + \beta C
\\]

- `nn`: `op(A) = A`, `op(B) = B`
- `tt`: `op(A) = A^T`, `op(B) = B^T`

![](https://raw.githubusercontent.com/devdeliw/coral/main/coral/plots/openblas/sgemm_nn.png)
![](https://raw.githubusercontent.com/devdeliw/coral/main/coral/plots/openblas/sgemm_tt.png)

---

## Apple Accelerate

### Level 1 (Accelerate)

#### ISAMAX — index of max absolute value

![](https://raw.githubusercontent.com/devdeliw/coral/main/coral/plots/accelerate/isamax.png)

#### SASUM — sum of absolute values

![](https://raw.githubusercontent.com/devdeliw/coral/main/coral/plots/accelerate/sasum.png)

#### SAXPY — y ← α x + y

![](https://raw.githubusercontent.com/devdeliw/coral/main/coral/plots/accelerate/saxpy.png)

#### SCOPY — y ← x

![](https://raw.githubusercontent.com/devdeliw/coral/main/coral/plots/accelerate/scopy.png)

#### SDOT — dot product

![](https://raw.githubusercontent.com/devdeliw/coral/main/coral/plots/accelerate/sdot.png)

#### SNRM2 — Euclidean norm

![](https://raw.githubusercontent.com/devdeliw/coral/main/coral/plots/accelerate/snrm2.png)

#### SROT — Givens rotation (in-place)

![](https://raw.githubusercontent.com/devdeliw/coral/main/coral/plots/accelerate/srot.png)

#### SROTM — modified Givens rotation

![](https://raw.githubusercontent.com/devdeliw/coral/main/coral/plots/accelerate/srotm.png)

#### SSCAL — x ← α x

![](https://raw.githubusercontent.com/devdeliw/coral/main/coral/plots/accelerate/sscal.png)

#### SSWAP — swap two vectors

![](https://raw.githubusercontent.com/devdeliw/coral/main/coral/plots/accelerate/sswap.png)

---

### Level 2 (Accelerate)

#### SGEMV — matrix–vector multiply  
\\[
y \leftarrow \alpha \operatorname{op}(A)x + \beta y
\\]

![](https://raw.githubusercontent.com/devdeliw/coral/main/coral/plots/accelerate/sgemv_n.png)
![](https://raw.githubusercontent.com/devdeliw/coral/main/coral/plots/accelerate/sgemv_t.png)

#### SGER — rank-1 update

![](https://raw.githubusercontent.com/devdeliw/coral/main/coral/plots/accelerate/sger.png)

#### SSYMV — symmetric matrix–vector multiply

**Lower triangle stored:**

![](https://raw.githubusercontent.com/devdeliw/coral/main/coral/plots/accelerate/ssymv_lower.png)

**Upper triangle stored:**

![](https://raw.githubusercontent.com/devdeliw/coral/main/coral/plots/accelerate/ssymv_upper.png)

#### SSYR — symmetric rank-1 update

**Lower triangle stored:**

![](https://raw.githubusercontent.com/devdeliw/coral/main/coral/plots/accelerate/ssyr_lower.png)

**Upper triangle stored:**

![](https://raw.githubusercontent.com/devdeliw/coral/main/coral/plots/accelerate/ssyr_upper.png)

#### SSYR2 — symmetric rank-2 update

**Lower triangle stored:**

![](https://raw.githubusercontent.com/devdeliw/coral/main/coral/plots/accelerate/ssyr2_lower.png)

**Upper triangle stored:**

![](https://raw.githubusercontent.com/devdeliw/coral/main/coral/plots/accelerate/ssyr2_upper.png)

#### STRMV — triangular matrix–vector multiply

**Upper triangular (STRMV):**

![](https://raw.githubusercontent.com/devdeliw/coral/main/coral/plots/accelerate/strumv_n.png)
![](https://raw.githubusercontent.com/devdeliw/coral/main/coral/plots/accelerate/strumv_t.png)

**Lower triangular (STRMV):**

![](https://raw.githubusercontent.com/devdeliw/coral/main/coral/plots/accelerate/strlmv_n.png)
![](https://raw.githubusercontent.com/devdeliw/coral/main/coral/plots/accelerate/strlmv_t.png)

#### STRSV — triangular solve

**Upper triangular (STRSV):**

![](https://raw.githubusercontent.com/devdeliw/coral/main/coral/plots/accelerate/strusv_n.png)
![](https://raw.githubusercontent.com/devdeliw/coral/main/coral/plots/accelerate/strusv_t.png)

**Lower triangular (STRSV):**

![](https://raw.githubusercontent.com/devdeliw/coral/main/coral/plots/accelerate/strlsv_n.png)
![](https://raw.githubusercontent.com/devdeliw/coral/main/coral/plots/accelerate/strlsv_t.png)

---

### Level 3 (Accelerate)

#### SGEMM — matrix–matrix multiply

![](https://raw.githubusercontent.com/devdeliw/coral/main/coral/plots/accelerate/sgemm_nn.png)
![](https://raw.githubusercontent.com/devdeliw/coral/main/coral/plots/accelerate/sgemm_tt.png)

