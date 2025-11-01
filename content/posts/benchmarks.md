+++
title = "CORAL Benchmarks"
description = "benchmarks against OpenBLAS and Apple Accelerate"
tags = ["BLAS"]
date = "2025-10-31"
categories = [""]
menu = "main"
+++

{{< katex />}}

Apple M4 (6P + 4E), 16GB unified memory. single-threaded (1 P-core). 

In all plots I benchmark against OpenBLAS. For some I also benchmark against
Apple Accelerate. Routines that don't have Accelerate shown mean Accelerate was
much faster on my M4 Macbook pro and masked any comparison with OpenBLAS. 

---

# Level 1

## AXPY

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

### f32
![](https://raw.githubusercontent.com/devdeliw/coral/main/benches/plots/SDOT.png)

### f64
![](https://raw.githubusercontent.com/devdeliw/coral/main/benches/plots/DDOT.png)

### c32

#### conj (`cdotc`)
![](https://raw.githubusercontent.com/devdeliw/coral/main/benches/plots/CDOTC.png)

#### unconj (`cdotu`)
![](https://raw.githubusercontent.com/devdeliw/coral/main/benches/plots/CDOTU.png)

### c64

#### conj (`zdotc`)
![](https://raw.githubusercontent.com/devdeliw/coral/main/benches/plots/ZDOTC.png)

#### unconj (`zdotu`)
![](https://raw.githubusercontent.com/devdeliw/coral/main/benches/plots/ZDOTU.png)

---

# Level 2

## GEMV
\\[
y \leftarrow \alpha \operatorname{op}(A) x + \beta y
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
\\[
x \leftarrow A^{-1} b
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
\\[
x \leftarrow \operatorname{op}(A) x
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
\\[
C \leftarrow \alpha \operatorname{op}(A)\operatorname{op}(B) + \beta C
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

