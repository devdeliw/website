#set page(width: 8.5in, height: 48in)
#show link: set text(fill: rgb("#1e6bd6"))
#import "@preview/lovelace:0.3.0": *
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
  Math 126 Lecture 1
][
  Review
]
01/21/2026

Deval Deliwala 

#set heading(numbering: "1.1")
= Ordinary Differential Equations 

#definition[ 
  A _first-order_ ordinary differential equation (ODE) is an equation
$
frac(d u, d t) = F(u, t),  
$ 
for an unknown $u: (a, b) -> RR $.
]

== Solving 

=== Direct Integration <dir-int>

If $F(u, t) = f(t)$ is $u$-independent, 
$ 
u'(t) = frac(d u, d t) = f(t).   
$ 

By the Fundamental Theorem of Calculus, 
$ 
integral_0^t u'(s) #h(0.2em) d s &= integral_0^t f(s) #h(0.2em) d s \ 
u(t) &= integral_0^t f(s) #h(0.2em) d s + C. 
$

#definition[ An ODE $u'(t) = F(u, t)$ is _separable_ if 
$ 
F(u, t) = f(u)g(t). 
$ 
]

=== Separation of Variables for ODEs <sep-var>

A separable equation can be rearranged so the right-hand side (RHS) becomes $u$-independent. 

$ 
frac(d u, d t) &= f(u)g(t)  \ 
frac(d u, d t) frac(1, f(u)) &= g(t).    
$ 

Then we solve via #link(<dir-int>)[direct integration]: 

$ 
frac(d u, d t) &= f(u)g(t) \ 
integral frac(d u, d t) frac(1, f(u))  #h(0.2em) d t &= integral g(t) #h(0.2em) d t + C \
integral frac(1, f(u)) #h(0.2em)  d u &= integral f(t) #h(0.2em) d t + C. 
$ 

#exercise[ 
    Solve $ frac(d y, d t) = 3t^2 (y^2 - 1). $ 

    
    #solution[ Recognize the RHS is separable and perform #link(<sep-var>)[separation of variables]: 

    $ 
    integral frac(d y, y^2 - 1) &= integral 3t^2 #h(0.2em)  d t \ 
    frac(1, 2) "ln" abs(frac(y-1, y+1)) &= t^3 + C \ 
    frac(y-1, y+1) &= D e^(2t^3) \ 
    y(t) &= frac(1 + D e^(2t^3), 1 - D e^(2t^3)),    
    $

    where $D = e^C$. 
  ]
]

#remark[ 
  It is very easy to write down an ODE resulting in an integral without 
  an anti-derivative in terms of standard functions. Hence, not all ODEs have closed
  form solutions in terms of functions we have names for. Solutions still exist, but must be 
  understood qualitatively or numerically. 
]

#definition[ 
  A second-order _linear_ ODE with constant coefficients takes the form: 

  $ 
  a u''(t) + b u'(t) + c u(t) = 0  
  $ 
  
  for $a, b in RR$. 
  
] 

=== The Characteristic Polynomial

Take the guess or _ansatz_ $u(t) = C e^(lambda t)$ and plug in: 

$ 
u'(t) &= C lambda e^(lambda t) \ 
u''(t) &= C lambda^2 e^(lambda t) 
$ 

into the differential equation. This gives 

$ 
0 &= a u'' + b u' + c u \ 
&= a( C lambda^2 e^(lambda t) ) + b ( C lambda e^(lambda t)) + c C e^(lambda t) \ 
&= C e^(lambda t) (a lambda^2 + b lambda + c ). 
$ 

Hence, either $C = 0$, which means $u(t) = 0$ trivially constant, or 
$ a lambda^2 + b lambda + c = 0$, for which we can use the quadratic formula 
that yields two roots $lambda_1, lambda_2$. Hence, our solution is 

$ 
u(t) = C_1 e^(lambda_1 t) + C_2 e^(lambda_2 t).
$ 

More generally, this method works for any constant coefficient ODE of any order: 

$ 
a_k u^((k)) + a_(k - 1) u^((k-1)) + dots.h.c + a_0 u = 0.  
$ 

There are also other possible ansatzes (ansatzi?) that are possible. 

#exercise[ 
  Solve the non-constant coefficient second-order linear ODE

  $ 
  r^2 u''(r) + r u'(r) + Lambda u(r) = 0. 
  $ 

  using the ansatz $u(r) = r^alpha$. 
]


== Initial Value Problems 

#definition[ 
  An ODE is called _homogeneous_ if its equal to 0. In other words, all terms in the equation 
  depend on $u(t)$. Otherwise, if there exist terms independent of $u(t)$, we can lump them 
  together into a unified $f(t)$ only dependent on $t$, and place it on the RHS. 

  $ 
  a_k(t) u^((k)) + a_(k-1)(t) u^((k-1)) + dots.h.c + a_0(t) u &= 0 #h(2em) &&"homogeneous" \ 
  &= f(t) #h(2em) &&"inhomogeneous". 
  $ 
]

Inhomogeneous terms appear as external sources or driving forces in applications. 
Typically the method of solving an inhomogeneous ODE involves solving the homogeneous variant 
first. 

#example[Inhomogeneous ODEs from external/driving forces. 
$ 
underbrace(frac(d P, d t), "population") = underbrace(k P, "births") + underbrace(I(t), "im/emmigration")   
$ 

$ 
underbrace( frac(d T, d t), "temperature") = k(T - T_0) + underbrace(s(t), "external heat source") 
$ 

]

#theorem[ 
  An $n$th order ODE has a solution with $n$ arbitrary constants if it is linear. 
  The solution then has the form: 

  $ 
  u(t) = C_1 f_1(t) + C_2 f_2(t) + dots.h.c + C_n f_n(t).  
  $ 
]

#definition[ 
An _initial value problem_ (IVP) or _boundary value_ problem imposes $n$ real-valued 
constraints at ends of the problem interval. 
]

#exercise[ 
  Solve the IVP on $[0, 1]$. 
$
  cases(
    u''(t) - w^2 u(t) = 0,
    u(0) = 0, 
    u'(0) = 4,
  ).
$

#solution[ 
  By characteristic polynomials, $u(t) = C_1 e^(w t) + C_2 e^(-w t)$. Plugging in, 

  $ 
  3 &= u(0) &&= C_1 + C_2 \ 
  4 &= u'(0) &&= C_1 omega e^0 + C_2 omega e^0 = C_1w - C_2 omega, 
  $ 

  which gives two equations and two unknowns and is therefore solvable.   
]

]

#remark[ 
An interpretation of the system at $t = "initial time"$ is required to know its complete 
evolution. The initial position and velocity of a ball thrown dictates the ball's future position.
These two unknowns correspond to Newton's second law being a second-order differential equation. 
Similarly, the initial population of a civilization influences how fast the population grows afterwards 
and corresponds to a first-order differential equation. 
]

= Structure on $RR^n$

#definition[ 
$RR^n = { (x_1, dots.h, x_n) | x_i in RR }.$ 

$RR^n$ is a vector space of dimension $n$. This defines algebraic operations 

$ 
&"/"  v + w  \
&"/" c v, 
$ 

which under _linear maps_, satisfy 

$ 
T(v + w) &= T(v) + T(w) \ 
T(c v) &= c T(v). 
$

This gives $RR^n$ _algebraic structure_. 

]

#definition[ 
  The Euclidean norm of a vector, 
  $ 
  ||x|| = sqrt(x_1^2 + x_2^2 + dots.h.c + x_n^2), 
  $

  gives $RR^n$ a _topology_, a notion of open and closed sets, and of proximity. 
]

#definition[ 
  A subset $Omega subset.eq RR^n$ is _open_ if for any $x in Omega$, there is a radius $r > 0$
  so the ball ${y | ||x - y|| < r }$ remains $subset.eq Omega$. 

  #align(center)[
    #image("open-set.png", width: 50%)  
  ]

  Intuitively open sets contain none of the boundary. Otherwise any infinitesimal $r > 0$ escapes $Omega$. 
]

#definition[ 
 A subset $Omega subset.eq RR^n$ is _closed_ if for all converging sequences ${x_k} subset.eq Omega$,
 the limit $x$ is _also_ $in Omega$. In other words, there exist no holes or punctures in $Omega$.

 An equivalent definition is $ Omega "closed" <==> RR^n backslash Omega $ is open. Intuitively, 
 closed means the boundary is included. 
]

#remark[ 
In $RR$, open/closed agrees with $(a, b)$ or $[a, b]$ for intervals. 
]

#definition[ 
  The Euclidean innter product on $RR^n$ is the _bilinear_ pairing 

  $ 
  chevron.l dot , dot chevron.r &: RR^n times RR^n -> RR \ 
  chevron.l x, y chevron.r &= x_1 y_1 + x_2 y_2 + dots.h.c + x_n y_n
  $

  Two vectors are orthogonal if $chevron.l v, w chevron.r = 0$. 
]

#example[ 
  The orthogonal complement of a vector or subspace is $
  "span"{v}^perp " or " V^perp = { w in RR^n | chevron.l v, w chevron.r = 0 #h(0.2em)  forall v in V }
  $

    #align(center)[
    #image("ortho.png", width: 30%) 
  ]

  It is the set of all vectors orthogonal to $V$. 
]
