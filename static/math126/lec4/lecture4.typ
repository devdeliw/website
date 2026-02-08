#set page(width: 8.5in, height: 11in)
#show link: set text(fill: rgb("#1e6bd6"))
#import "@preview/ctheorems:1.1.3": *
#show: thmrules 
#set math.equation(numbering: "(1)")

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
  Math 126 Lecture 4
][
  Model PDEs I 
]
======= Deval Deliwala 
2/02/26


== Derivation of the wave equation 

Consider a rope with fixed ends, and call the height displacement from the flat $u(t, x)$. 

//#align(center)[
//  #image("rope.png", width: 50%)    
//]

Assume the rope has density $rho$. An infinitesimal segment with length $h$ therefore has mass $rho h$, 
at $x = x_j$. 

//#align(center)[
//  #image("segment", width: 50%) 
//]

From Newton's laws: 

$ 
m a &= F(x, t) \
rho h dot frac(d^2 u, d t^2 ) &= {"vertical restoring force"} \ 
$ 


The vertical restoring force is given by 

$ 
F &= T sin alpha_j + T sin beta_j \ 
&approx T tan alpha_j + T tan beta_j \ 
&approx T ( frac(u(x_(j-1), t) - u(x_j, t), h) + frac(u(x_(j+1), t) - u(x_j, t), h) ) \ 
&approx T[u'(x_j, t) - u'(x_(j-1), t) ] 
$ 

After substituting Eq. (2) into Eq. (1), we have 

$ 
rho h dot frac(d^2 u, d t^2 ) &= {"vertical restoring force"} \ 
frac(partial^2  u, partial t^2) &= frac(T, rho) [ frac(u'(x_j, t) - u'(x_(j-1), t), h)] \ 
&= frac(T, rho) [u''(x_j, t) ].  
$ 

Defining $c^2 = frac(T, rho)$, the wave equation in 1 dimension reads 

$ 
frac(partial^2  u, partial t^2 )  = c^2  frac(partial^2  u , partial x^2 ).    
$ 


== Boundary and Initial Value Problems 

Recall the paradigm for solving ODEs. 

1. Apply a method of solving to obtain a general solution (with arbitrary constants).
2. Plug in knowledge of a specific situation (e.g. initial conditions) to get specific solution.

#definition[ 
The _initial value problem_ for the wave equation is to solve 

$ 
cases( 
frac(partial^2  u, partial t^2 ) &= c^2  frac(partial^2  u, partial x^2 ), 
u(0, x) &= g(x), 
frac(partial u(0, x), partial t)&= h(x),
)
$

for given functions $g(x)$, $h(x)$. 
]



Often to adapt concepts from ODEs to PDEs we "promote" values to functions. 
$
u(t) #h(1em) &" is a number " &&"(ODE) " \ 
u(t, -) #h(1em) &" is a function " &&"(PDE) " 
$

The initial condition similarly promotes $u(0) mapsto u(0, -)$. 



