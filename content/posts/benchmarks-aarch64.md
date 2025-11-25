+++
title       = "coral-aarch64 benchmarks"
description = "benchmarks against OpenBLAS and Apple Accelerate"
tags        = ["BLAS"]
date        = "2025-10-31"
categories  = [""]
menu        = "main"
+++

{{< katex />}}

Apple M4 (6P + 4E), 16GB unified memory. All benchmarks are single-threaded.

In all plots, CORAL is benchmarked against OpenBLAS. Some routines also include
Apple Accelerate. When Accelerate is omitted, it is because its AMX-backed
kernels on this M4 MacBook Pro are much faster and completely mask any
comparison with OpenBLAS. For `sgemm`, [faer](https://faer.veganb.tw) is included, also single-threaded. 

---

## Table of Contents

- [Level 1](#level-1)
  - [AXPY](#axpy)
  - [SCAL](#scal)
  - [DOT](#dot)
- [Level 2](#level-2)
  - [GEMV](#gemv)
  - [TRSV](#trsv)
  - [TRMV](#trmv)
- [Level 3](#level-3)
  - [GEMM](#gemm)

---

# Level 1

## AXPY

AXPY performs a scaled vector addition:
\\[
y \leftarrow \alpha x + y
\\]

### f32

![](https://raw.githubusercontent.com/devdeliw/coral/main/benches/plots/SAXPY.png)

### f64

![](https://raw.githubusercontent.com/devdeliw/coral/main/benches/plots/DAXPY.png)

### c32

![](https://raw.githubusercontent.com/devdeliw/coral/main/benches/plots/CAXPY.png)

### c64

![](https://raw.githubusercontent.com/devdeliw/coral/main/benches/plots/ZAXPY.png)

---

## SCAL

SCAL scales a vector by a scalar:
\\[
x \leftarrow \alpha x
\\]

### f32

![](https://raw.githubusercontent.com/devdeliw/coral/main/benches/plots/SSCAL.png)

### f64

![](https://raw.githubusercontent.com/devdeliw/coral/main/benches/plots/DSCAL.png)

### c32

![](https://raw.githubusercontent.com/devdeliw/coral/main/benches/plots/CSCAL.png)

### c64

![](https://raw.githubusercontent.com/devdeliw/coral/main/benches/plots/ZSCAL.png)

---

## DOT

Real dot product:
\\[
\operatorname{dot}(x, y) = \sum_i x_i y_i
\\]

Complex variants:
- conjugated: \\(\operatorname{dotc}(x, y) = \sum_i \overline{x_i} y_i\\)
- unconjugated: \\(\operatorname{dotu}(x, y) = \sum_i x_i y_i\\)

### f32

![](https://raw.githubusercontent.com/devdeliw/coral/main/benches/plots/SDOT.png)

### f64

![](https://raw.githubusercontent.com/devdeliw/coral/main/benches/plots/DDOT.png)

### c32

#### conj (cdotc)

![](https://raw.githubusercontent.com/devdeliw/coral/main/benches/plots/CDOTC.png)

#### unconj (cdotu)

![](https://raw.githubusercontent.com/devdeliw/coral/main/benches/plots/CDOTU.png)

### c64

#### conj (zdotc)

![](https://raw.githubusercontent.com/devdeliw/coral/main/benches/plots/ZDOTC.png)

#### unconj (zdotu)

![](https://raw.githubusercontent.com/devdeliw/coral/main/benches/plots/ZDOTU.png)

---

# Level 2

## GEMV

Matrix–vector multiply:
\\[
y \leftarrow \alpha \operatorname{op}(A) x + \beta y,
\quad
\operatorname{op}(A) \in \{A, A^T, A^H\}
\\]

### f32

![](https://raw.githubusercontent.com/devdeliw/coral/main/benches/plots/SGEMV_NOTRANSPOSE.png)
![](https://raw.githubusercontent.com/devdeliw/coral/main/benches/plots/SGEMV_TRANSPOSE.png)

### f64

![](https://raw.githubusercontent.com/devdeliw/coral/main/benches/plots/DGEMV_NOTRANSPOSE.png)
![](https://raw.githubusercontent.com/devdeliw/coral/main/benches/plots/DGEMV_TRANSPOSE.png)

### c32

![](https://raw.githubusercontent.com/devdeliw/coral/main/benches/plots/CGEMV_NOTRANSPOSE.png)
![](https://raw.githubusercontent.com/devdeliw/coral/main/benches/plots/CGEMV_TRANSPOSE.png)
![](https://raw.githubusercontent.com/devdeliw/coral/main/benches/plots/CGEMV_CONJTRANSPOSE.png)

### c64

![](https://raw.githubusercontent.com/devdeliw/coral/main/benches/plots/ZGEMV_NOTRANSPOSE.png)
![](https://raw.githubusercontent.com/devdeliw/coral/main/benches/plots/ZGEMV_TRANSPOSE.png)
![](https://raw.githubusercontent.com/devdeliw/coral/main/benches/plots/ZGEMV_CONJTRANSPOSE.png)

---

## TRSV

Triangular solve:
\\[
x \leftarrow A^{-1} b,
\quad A \text{ triangular}
\\]

### f32

#### LOWER TRIANGULAR

![](https://raw.githubusercontent.com/devdeliw/coral/main/benches/plots/STRSV_LOWER_NOTRANSPOSE.png)
![](https://raw.githubusercontent.com/devdeliw/coral/main/benches/plots/STRSV_LOWER_TRANSPOSE.png)

#### UPPER TRIANGULAR

![](https://raw.githubusercontent.com/devdeliw/coral/main/benches/plots/STRSV_UPPER_NOTRANSPOSE.png)
![](https://raw.githubusercontent.com/devdeliw/coral/main/benches/plots/STRSV_UPPER_TRANSPOSE.png)

### f64

#### LOWER TRIANGULAR

![](https://raw.githubusercontent.com/devdeliw/coral/main/benches/plots/DTRSV_LOWER_NOTRANSPOSE.png)
![](https://raw.githubusercontent.com/devdeliw/coral/main/benches/plots/DTRSV_LOWER_TRANSPOSE.png)

#### UPPER TRIANGULAR

![](https://raw.githubusercontent.com/devdeliw/coral/main/benches/plots/DTRSV_UPPER_NOTRANSPOSE.png)
![](https://raw.githubusercontent.com/devdeliw/coral/main/benches/plots/DTRSV_UPPER_TRANSPOSE.png)

### c32

#### LOWER TRIANGULAR

![](https://raw.githubusercontent.com/devdeliw/coral/main/benches/plots/CTRSV_LOWER_NOTRANSPOSE.png)
![](https://raw.githubusercontent.com/devdeliw/coral/main/benches/plots/CTRSV_LOWER_TRANSPOSE.png)

#### UPPER TRIANGULAR

![](https://raw.githubusercontent.com/devdeliw/coral/main/benches/plots/CTRSV_UPPER_NOTRANSPOSE.png)
![](https://raw.githubusercontent.com/devdeliw/coral/main/benches/plots/CTRSV_UPPER_TRANSPOSE.png)

### c64

#### LOWER TRIANGULAR

![](https://raw.githubusercontent.com/devdeliw/coral/main/benches/plots/ZTRSV_LOWER_NOTRANSPOSE.png)
![](https://raw.githubusercontent.com/devdeliw/coral/main/benches/plots/ZTRSV_LOWER_TRANSPOSE.png)

#### UPPER TRIANGULAR

![](https://raw.githubusercontent.com/devdeliw/coral/main/benches/plots/ZTRSV_UPPER_NOTRANSPOSE.png)
![](https://raw.githubusercontent.com/devdeliw/coral/main/benches/plots/ZTRSV_UPPER_TRANSPOSE.png)

---

## TRMV

Triangular matrix–vector multiply:
\\[
x \leftarrow \operatorname{op}(A) x,
\quad A \text{ triangular}
\\]

### f32

#### LOWER TRIANGULAR

![](https://raw.githubusercontent.com/devdeliw/coral/main/benches/plots/STRMV_LOWER_NOTRANSPOSE.png)
![](https://raw.githubusercontent.com/devdeliw/coral/main/benches/plots/STRMV_LOWER_TRANSPOSE.png)

#### UPPER TRIANGULAR

![](https://raw.githubusercontent.com/devdeliw/coral/main/benches/plots/STRMV_UPPER_NOTRANSPOSE.png)
![](https://raw.githubusercontent.com/devdeliw/coral/main/benches/plots/STRMV_UPPER_TRANSPOSE.png)

### f64

#### LOWER TRIANGULAR

![](https://raw.githubusercontent.com/devdeliw/coral/main/benches/plots/DTRMV_LOWER_NOTRANSPOSE.png)
![](https://raw.githubusercontent.com/devdeliw/coral/main/benches/plots/DTRMV_LOWER_TRANSPOSE.png)

#### UPPER TRIANGULAR

![](https://raw.githubusercontent.com/devdeliw/coral/main/benches/plots/DTRMV_UPPER_NOTRANSPOSE.png)
![](https://raw.githubusercontent.com/devdeliw/coral/main/benches/plots/DTRMV_UPPER_TRANSPOSE.png)

### c32

#### LOWER TRIANGULAR

![](https://raw.githubusercontent.com/devdeliw/coral/main/benches/plots/CTRMV_LOWER_NOTRANSPOSE.png)
![](https://raw.githubusercontent.com/devdeliw/coral/main/benches/plots/CTRMV_LOWER_TRANSPOSE.png)

#### UPPER TRIANGULAR

![](https://raw.githubusercontent.com/devdeliw/coral/main/benches/plots/CTRMV_UPPER_NOTRANSPOSE.png)
![](https://raw.githubusercontent.com/devdeliw/coral/main/benches/plots/CTRMV_UPPER_TRANSPOSE.png)

### c64

#### LOWER TRIANGULAR

![](https://raw.githubusercontent.com/devdeliw/coral/main/benches/plots/ZTRMV_LOWER_NOTRANSPOSE.png)
![](https://raw.githubusercontent.com/devdeliw/coral/main/benches/plots/ZTRMV_LOWER_TRANSPOSE.png)

#### UPPER TRIANGULAR

![](https://raw.githubusercontent.com/devdeliw/coral/main/benches/plots/ZTRMV_UPPER_NOTRANSPOSE.png)
![](https://raw.githubusercontent.com/devdeliw/coral/main/benches/plots/ZTRMV_UPPER_TRANSPOSE.png)

---

# Level 3

## GEMM

Matrix–matrix multiply:
\\[
C \leftarrow \alpha \operatorname{op}(A)\operatorname{op}(B) + \beta C,
\quad
\operatorname{op}(A), \operatorname{op}(B) \in \{\,\cdot, {}^T, {}^H\}
\\]

### f32

![](https://raw.githubusercontent.com/devdeliw/coral/main/benches/plots/SGEMM_NOTRANSPOSE_x_NOTRANSPOSE.png)
![](https://raw.githubusercontent.com/devdeliw/coral/main/benches/plots/SGEMM_TRANSPOSE_x_TRANSPOSE.png)

### f64

![](https://raw.githubusercontent.com/devdeliw/coral/main/benches/plots/DGEMM_NOTRANSPOSE_x_NOTRANSPOSE.png)
![](https://raw.githubusercontent.com/devdeliw/coral/main/benches/plots/DGEMM_TRANSPOSE_x_TRANSPOSE.png)

### c32

![](https://raw.githubusercontent.com/devdeliw/coral/main/benches/plots/CGEMM_NOTRANSPOSE_x_NOTRANSPOSE.png)
![](https://raw.githubusercontent.com/devdeliw/coral/main/benches/plots/CGEMM_TRANSPOSE_x_TRANSPOSE.png)
![](https://raw.githubusercontent.com/devdeliw/coral/main/benches/plots/CGEMM_CONJTRANSPOSE_x_CONJTRANSPOSE.png)

