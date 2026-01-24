#set page(width: 8.5in, height: 39.5in)
#show link: set text(fill: rgb("#1e6bd6"))
#import "@preview/ctheorems:1.1.3": *
#show: thmrules 

#let definition = thmbox(
  "definition",         
  "Definition",
  fill: rgb("#e8f8e8")
).with(numbering: none)

#let exercise = thmbox(
  "exercise",
  "Exercise",
  stroke: rgb("#ffaaaa") + 1pt,
  base: none,           
).with(numbering: "I")  

#let solution = thmplain(
  "solution",
  "Solution",
  base: "exercise",
  inset: 0em,
).with(numbering: none)

#let remark = thmplain(
  "remark",
  "Remark",
  inset: 0em
).with(numbering: none)

#let example = thmplain(
  "example", 
  "Example"
).with(numbering: none)

#let remark = thmplain(
  "remark",
  "Remark",
  inset: 0em
).with(numbering: none)

#let theorem = thmbox(
  "theorem",
  "Theorem",
  fill: rgb("#e8e8f8")
)

= #grid(
  columns: (1fr, auto),
  align: (left, right),
  gutter: 0pt,
)[
  Math 126 Lecture 2
][
  The three classes of linear PDEs
]
======Deval Deliwala 
1/22/26


$ 
cases(
  "single variable calculus", 
  f(x) #h(0.5em) frac(d , d x)
) #h(1em) arrow.r.long.bar "ODEs"  
$

$ 
cases(
  "multivariable calculus", 
  f(x, y, z) #h(0.5em) frac(partial , partial x) #h(0.5em) nabla  
) #h(1em) arrow.r.long.bar "PDEs"  
$ 

#set heading(numbering: "1.1")
= Definitions

#definition[ 
An _ordinary differential equation_ (ODE) is an equation relating an unknown function $f(x)$ of a single variable 
to its own derivatives. 
]

#example[ 
  Some examples of ODEs: 

  $ 
  frac(d P, d t) = k P #h(2em) frac(d T, d t) = -k(T-T_0) #h(2em) frac(d^2 theta, d t^2) + frac(g, ell)theta = 0          
  $ 
  
]

Most quantities in nature depend on multiple variables though. Newton's cooling ODE does not acknowledge 
when dipping a hot ball in water, the outsides cool down first. E.g. heat clearly varies in both 
time and space: 

$ 
f(x) arrow.r.long.bar u(t, x, y, z) 
$ 

#definition[ 
A _partial differential equation_ (PDE) is an equation relating an unknown function $u(t, x, y, z, dots.h)$ 
to its own partial derivatives. 

The _order_ of the equation is the highest derivative magnitude that appears. 
]

#example[ 
  Some examples of PDEs: 

  $ 
  frac(partial u, partial t) + frac(partial u, partial x) &= 0 #h(5em)  &&"first order"    \
  3 frac(partial^2 u, partial x^2) + 4 frac(partial^2 u, partial x partial y) + 7u &= 0 #h(5em)  &&"second order with constant coeffs."   \ 
  a(t, x) frac(partial^2 u, partial x^2) + b(t, x)frac(partial^2 u, partial y^2) + dots.h.c + f(t, x, y, z)u &= 0 &&"second order with non-constant coeffs"
  $ 
  
  
]

= Three Classes of Linear PDEs 

#definition[ 
A PDE is _linear_ if each term is a fixed, known functino times a partial derivative. It 
depends linearly on the partial derivatives: 

$ 
cos(t + x) frac(partial^2 u, partial y^2) #h(0.2em) &checkmark #h(5em) &&( frac(partial u, partial x) )^2 &&&crossmark \ 
3x frac(partial u, partial z) #h(0.2em) &checkmark && frac(partial u, partial x) frac(partial u, partial y) &&&crossmark \
e^(y+z) frac(partial^(15) u , partial x^(8) partial y^(7))#h(0.2em) &checkmark && e^u frac(partial u, partial z) &&&crossmark  
$

]


#remark[ 
Bizzare fact of nature: Effectively every equation coming from physics, chemistry, engineering, biology, 
economics, etc. is a first or second order equation. 
]

#box(
  fill: luma(250), 
  width: 100%, 
  inset: 8pt, 
  [ 
    _Notation:_ derivatives of $u(t, x, y, z)$ are denoted as 
    $ 
    frac(partial u, partial x) &= partial_x u = partial_1 u = u_x \ 
    frac(partial^2 u, partial t partial y) &= partial_t partial_y u  = partial_0 partial_2 u= u_(t y) 
    $   
  ]
)

A second-order linear PDE can be written in the form: 

$ 
sum_(i, j = 0)^3 A_(i j)(t, x, dots.h) partial_i partial_j u + sum_(k=0)^3 B(t, x, dots.h) partial_k u + C(t, x, dots.h) u = f(t, x, y, z),
$ 

where $f(t,  x, y, z) = 0$ if the PDE is homogeneous and nonzero if inhomogeneous. 
Therefore using four variables $t, x, y, z$, $A_(i j)$ can be expressed as a $4 times 4$ matrix:  

$ 
A equiv mat(
  A_(00), A_(10), ...; 
  A_(01), A_(11), ...; 
  dots.v, dots.v, dots.down; 
)
$

The three types of linear PDEs depend on the structure of $A$. 

== Elliptical 

A prototypical example is _The Laplace Equation_: 
$ 
frac(partial^2 u, partial x^2) + frac(partial^2 u, partial y^2) + frac(partial^2 u, partial z^2) &= 0     \ 
nabla dot nabla u &= 0 \ 
triangle.stroked.t u &= 0

$ 

which corresponds to $A$ being the $4 times 4$ identity $bb(1)_4$. 

#definition[ 
  A second order linear PDE that's independent of time: 
  $ 
  sum_(i j=1)^3 A_(i j)(x, dots.h) partial_i partial_j u + sum_(k=1)^3 b_k (x, dots.h) partial_k u + c(x, y, z)u = 0
  $ 

  is _elliptic_ if $ A = mat(A_(11), , ; , A_(22), ; , , A_(33); ) $ is _diagonal_ with strictly 
  positive entries.  
]

However, from linear algebra we know matrices representing the same linear transformation, 
can appear different in different bases, so $A$ being diagonal is not a good definition. 

#align(center)[
  #image("coords.png", width: 50%) 
]

We need a rigorous definition to be independent of coordinates. From linear algebra 
we also know the eigenbasis _is_ a diagonal basis. Therefore, 

#definition[ 
  A second order linear PDE
    $ 
  sum_(i j=1)^3 A_(i j)(x, dots.h) partial_i partial_j u + sum_(k=1)^3 b_k (x, dots.h) partial_k u + c(x, y, z)u = 0
  $ 
  if elliptic if $A(x, y, z)$ has all eigenvalues $lambda_1(x, y, z), dots.h, lambda_n (x, y, z) > 0$ 
  strictly positive for all $x, y, z$. Then $A$ is diagonal in the eigenbasis ${lambda_1, lambda_2, dots.h. lambda_n}$. 
]

#example[ 
  Some examples of elliptic ODEs: 

  $ 
  triangle.stroked.t u + Lambda u = 0 &#h(2em) Lambda <= 0 #h(3em) &&"Helmholtz equation" \ 
  - triangle.stroked.t u + V(x, y, z)u = 0 &#h(2em) V "potential" #h(3em) && "time-indep. Schrodinger"
  $ 
]

== Parabolic 

A prototypical example is the heat equation: 

$ 
frac(partial u, partial t) - triangle.stroked.t u = 0.   
$ 

#remark[ 
  The diffusion equation, which describes how the concentration $u$ of solute in water 
  changes over time: 

  $
  frac(partial u, partial t) - alpha triangle.stroked.t u = 0  
  $

  is the same as the heat equation but with a constant $alpha$. The Poincaré principle then 
  tells us we can import intuition from the one to the other, because their underlying PDE 
  is mathematically the same. 
]

#definition[ 
  A second order linear PDE on $RR_t times RR^3$ is _parabolic_ if it has the form 

  $ 
  frac(partial u, partial t) - { "any time ind. second order linear elliptial" } u = 0.  
  $  
]

== Hyperbolic 

A prototypical example is the wave equation: 

$ 
frac(partial^2  u , partial t^2 ) - c^2 triangle.stroked.t u = 0 #h(2em) c = "propagation speed".   
$ 

#definition[ 
A second order PDE on $RR_t times RR^3$ is _hyperbolic_ if for 

$ 
sum_(i j = 0)^3 A_(i j)(t, dots.h) partial_i partial_j u + sum_(k=0)^3 B_k (t, dots.h) partial_k u + C(t, dots.h )u = 0, 
$

$A$ has _exactly one strictly negative_ eigenvalue with the rest remaining strictly positive (for all $t, x, y, z$). 
]


#exercise[ 
Is this second order equation elliptic, parabolic, hyperbolic, or none? 

$ 
partial_t^2 u + 4 partial_t partial_x u + 3 partial_x^2 u + 8 underbrace(partial_t partial_y u, 4partial_t partial_y u + 4 partial_y partial_t u) + 2 partial_y^2 u - 2partial_x partial_y u = 0  
$ 

#solution[ 
  From this PDE, we have 

  $ 
  A = mat(1, 2, 4; 2, 3, -1; 4, -1, 2; ),  
  $ 

  which has eigenvalues ${-3.279, 3.592, 5.686}$. Therefore this is a hyperbolic PDE. 
]

If an arbitrary PDE is none of the above types, it is typically not well-behaved, even if it 
has a solution, and most do not. Fortunately God made these equations rarely observed in nature. 
]


#remark[ 
  The PDEs are called elliptical, parabolic, and hyperbolic from their algebraic structure. Replacing 
  derivatives $frac(partial, partial t) mapsto T, #h(0.2em) frac(partial, partial x) mapsto X$, we find 

  $ 
  a frac(partial^2 , partial x^2 ) + frac(partial^2 , partial y^2 ) #h(5em) & a X^2 + b Y^2 #h(5em) &&"(ellipse)" \ 
  frac(partial, partial t) - frac(partial^2, partial x^2) #h(5em) & T - X^2 #h(5em) &&"(parabola)" \ 
  frac(partial^2 , partial t^2 ) - frac(partial^2 , partial x^2 ) #h(5em) & T^2 - X^2 #h(5em) &&"(hyperbola)"    
  $ 
  
]




