+++ 
title = "What is CORAL?" 
description = "Core Rust Architecture for Linear Algebra" 
tags = ["BLAS"]
date = "2025-10-09" 
categories = ["Software"] 
menu = "main"
+++

{{< katex />}}

In the past few months I've become immensely interested in scientific computing
and writing fast code. I started [CORAL](https://github.com/devdeliw/CORAL) as a project to learn both at the same
time. And learn [Rust](https://rust-lang.org). 

CORAL stands for *COre Rust Architecture for Linear algebra*. It is an
implementation of the [Basic Linear Algebra
Subprograms](https://en.wikipedia.org/wiki/Basic_Linear_Algebra_Subprograms), or
*BLAS*, in pure Rust. It is written for AArch64 architectures only.

BLAS is the set of the most common low-level operations, "kernels", for linear
algebra. Most numerical routines involve linear algebra; it is clear
that a useful BLAS must be *as fast as possible*. These kernels naturally separate 
into three levels, each monumentally more difficult than the last. 

{{% steps %}} 
1. ### Level 1 
    *Vector-Vector Operations* <br><br>
    Think of things like calculating the dot product, $\vec{x} \cdot \vec{y}$, 
    or multiplying by a scalar, $\alpha \vec{x}$. <br> 
    These operations are *memory bound*; the bottleneck is how fast memory 
    is moved around, not how fast the CPU is. Good performance can be achieved 
    if code is written intelligently.

2. ### Level 2 
    *Matrix-Vector Operations* <br><br> 
    Think of things like calculating $A\vec{x}$, or solving a system of
    equations $A\vec{x} = \vec{b}$ given a triangular matrix
    $A$ and $\vec{b}$. These operations are also memory bound. It is here
    though, that clever tricks leveraging cache to maximize performance begin.
    Good performance can still be achieved with smart code.

3. ### Level 3 
    *Matrix-Matrix Operations* <br><br> 
    Think of things like calculating $AB$. It's fair to say $AB$ is
    the most executed mathematical operation on the planet. It is also *compute bound*, which means 
    reaching peak performance is *[still an active area of research](https://en.wikipedia.org/wiki/Computational_complexity_of_matrix_multiplication).*
    
    A BLAS's performance is almost entirely dependent on how fast it can 
    calculate $AB$. Consequently, solving many $AB$s is [how supercomputers are
    benchmarked today](https://en.wikipedia.org/wiki/LINPACK_benchmarks). AI
    only exists today because matrix multiplication became fast enough. 
    

{{% /steps %}}

One of BLAS's pioneers is [Kazushige
Goto](https://en.wikipedia.org/wiki/Kazushige_Goto), who hand optimized assembly
routines for his [GotoBLAS](https://www.cs.utexas.edu/~flame/pubs/GotoTOMS_final.pdf). 
This implementation outperformed many BLAS used at the time and became the
backbone for the current industry standard [OpenBLAS](https://github.com/OpenMathLib/OpenBLAS). 
If you use Python and NumPy for vector calculations, OpenBLAS is why it's so fast. 

CORAL isn’t built to compete with industry BLAS, but to reach $\simeq$ 80 % of their
performance **on AArch64**.$^\dagger$ This is to educate myself and others on how these 
fast low-level algorithms work. The purpose of this "blog" is to walk through how to
intelligently write code to make a fast BLAS. Just not one that's used by
supercomputers.

<br>

--- 
$^\dagger$ Turns out, **on AArch64**, CORAL is actually comparable to OpenBLAS
*when both are single-threaded*. CORAL outperforms for `D/C/ZGEMM`, and is $\sim$comparable
for `SGEMM` (single precision general matrix multiplication). This makes sense,
since `SGEMM` is the most used. You can see the benchmark(s)
[here](https://github.com/devdeliw/CORAL/blob/main/benches/plots/). 
However, optimized for Apple Silicon, [Apple
Accelerate](https://developer.apple.com/documentation/accelerate), another BLAS
implementation, absolutely wrecks both CORAL and OpenBLAS. 

<br> 

<div style="position: relative; width: 100%; margin-top: 2em;">
  <div style="position: absolute; right: 0;">
    {{< button relref="memory" class="btn" >}}Next →{{< /button >}}
  </div>
</div>

