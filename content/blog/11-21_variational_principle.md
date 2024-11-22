---
title: 'The Variational Principle'
date: 2024-11-21T12:55:50-08:00
draft: false
comments: true
---


I'm currently working on writing an animation package for visualizing quantum
circuits. I had hoped it would have been finished sooner so I could complete
Part 2 of visualizing entanglement. Until then, I'd like to talk about something
I learned in a lecture that may be one of the most useful results in quantum
mechanics, while also being embarrassingly simple. It's called the *Variational
Principle* and is the basis for how variational quantum algorithms work,
specifically the variational quantum eigensolver (VQE).

I'll boldly state the result here and build up to it as we go on. Pick *any
normalized wave function \\( \psi \\) whatsoever.* Then  

$$ E_\text{gs} \leq \langle \psi | \hat{H} | \psi \rangle \equiv \langle \hat{H}
\rangle $$

which says the expectation value of the Hamiltonian \\( \hat{H} \\) with any
arbitrary wave function \\(\psi\\) will always overestimate the ground state
energy of \\( \hat{H} \\). Of course, if \\( \psi \\) just happens to be the ground
state wave function, then the above equation is an equivalence. If \\( \psi \\)
happens to be any of the excited states, then of course \\( E_\text{gs} \leq
\langle \hat{H} \rangle\\). The point is that this overestimation holds for any $
\psi $ whatsoever.


The proof is actually quite simple. 

> **Proof**: Since the (unknown) eigenstates of $\hat{H}$ are orthonormal and
> linearly independent (i.e. $\langle \psi_i | \psi_j \rangle = \delta_{ij} $)
> for any two eigenstates, they form a complete set. Therefore, we can express
> any arbitrary $\psi$ as a linear combination of them: 
>
> $$ \psi = \sum_{n} c_n \psi_n, \qquad \text{with } \hat{H} \psi_n = E_n \psi_n,
>$$
>
>Since $\psi$ is normalized, 
>
>$$ 1 = \langle \psi | \psi \rangle = \big\langle \sum{m} c_m \psi_m \big|
>\sum{n}c_n \psi_n \big\rangle$$ 
> $$ \qquad \qquad \qquad \quad \\; \\;    = \sum_m \sum_n c_m^* c_n \langle \psi_m | \psi_n
>\rangle = \sum_n |c_n|^2. $$
>
>(because any two eigenstates are orthonormal: $\langle \psi_m | \psi_n \rangle =
>\delta_{mn}$). 
>
> Calculating $\langle \hat{H} \rangle$, 
>
>$$ \langle \hat{H} \rangle = \big\langle \sum_m c_m \psi_m \big| \hat{H} |
>\sum_n c_n \psi_n \big\rangle 
>= \big\langle c_m \psi_m | \hat{H} \sum_n c_n
>\psi_n \big\rangle$$ 
>$$ = \sum_m \sum_n c_m^* E_n c_n \langle \psi_m | \psi_n \rangle
>= \sum_n E_n |c_n|^2. \qquad $$
>
>But the ground state energy $E_\text{gs}$ is, by definition, the *lowest*
>eigenvalue, $E_\text{gs} \leq E_{n} \\; \forall n$. Hence, 
>
>$$ 
>\langle \hat{H} \rangle  = \sum_n E_n |c_n|^2 \geq E_\text{gs} \sum_n |c_n|^2 =
>E_\text{gs}
>$$
>
>$$ \langle \hat{H} \rangle \geq E_\text{gs}. $$ 

### Helium 


I think the best example to showcase the power of the Variational Principle is 
calculating the ground state energy of Helium.

Despite Helium being the second simplest elemental Hamiltonian, consisting of
only two electrons in orbit around a nucleus containing two protons (with some
neutrons), its Schrödinger equation is actually unsolvable.

![](/helium.pdf)
$$ \text{The Helium Atom}. $$

Like any many-body system, its differential equation is impossible to solve
exactly. When astrodynamicists calculate trajectories of satellites traveling
to, say, Jupiter, they would have to account for the gravitational attraction of
the Sun, Earth, and Jupiter at a minimum to be exact. However, there exists no
solvable equation to account for the pull of a three-body system. They instead
discretize the system, calculating the Earth-satellite system when the satellite
is near Earth, and the Jupiter-satellite system when the satellite is near
Jupiter. (Helium electrons are always close together, unfortunately, so you
can't really do this.) Elsewhere, they employ numerical techniques and possibly
some perturbation theory.

The Hamiltonian for Helium (ignoring fine structure) is given by 

$$ 
\hat{H} = - \frac{\hbar^2}{2m} \left( \nabla_1^2 + \nabla_2^2 \right) - 
\frac{e^2}{4\pi \epsilon_0} \left( \frac{2}{r_1} + \frac{2}{r_2} -
\frac{1}{|\vec{r_1} - \vec{r_2}|}\right). 
$$

The ground state of Helium has been measured experimentally to be $$E_\text{gs}
\approx -78.975 \text{ eV (experimental)}. $$ 

This is the quantity we'll do our best to reproduce mathematically. 

The issue with trying to solve this Hamiltonian 
comes from the electron-electron repulsion potential, 

$$ V_{ee} = \frac{e^2}{4\pi\epsilon_0} \frac{1}{|\vec{r_1} - \vec{r_2}|}.$$  

We could employ time-independent perturbation theory using $\hat{H'} = V_{ee}$.
However, because the $V_{ee}$ is not a small perturbation, this
approximation would be quite far off. 

If we just ignore $V_{ee}$, the Helium Hamiltonian simplifies into two
hydrogenic Hamiltonians 

$$ \hat{H} = \left(-\frac{\hbar^2}{2m}\nabla_1^2 - \frac{e^2}{4\pi\epsilon_0} \frac{2}{2r_1}\right)  
-\frac{\hbar^2}{2m} \nabla_2^2 - \left(\frac{e^2}{4\pi\epsilon_0} \frac{2}{r_2}\right)$$. 

with a nuclear charge of \\( 2e \\) instead of \\( e \\). The exact solution is
just the product of hydrogenic wave functions: 

$$ \psi_0(\vec{r_1}, \vec{r_2}) \equiv
\psi_{100}(\vec{r_1})\psi_{100}(\vec{r_2}) = \frac{8}{\pi a^3} e^{-2(r_1 +
r_2)/a}, $$

and the energy is \\( 8E_1 \approx -109\\) eV, which is very far from \\( -78.975 \\) eV.
Let's instead use the Variational Principle with the hydrogenic \\( \psi_0 \\) as the ansatz 
wave function. 

As we'll see soon, the closer the ansatz is to the actual ground state wave
function, the better an approximation the Variational Principle gives. So this
ansatz make sense since it's an eigenfunction for *most* of the Hamiltonian: 

$$ \hat{H} \psi_0 = (8E_1 + V_{ee})\psi_0. $$ 

#### Hydrogenic Ansatz 

The Variational Principle tells us \\( E_\text{gs} \leq \langle \hat{H} \rangle \\). Hence, with 
the hydrogenic ansatz, we are tasked with solving 

$$ \langle \hat{H}\rangle  = 8E_1 + \langle V_{ee} \rangle. $$ 

where $$ \langle V_{ee} \rangle = \Big\langle \psi_0 \Big|
\frac{e^2}{4\pi\epsilon_0} \frac{1}{|\vec{r_1}-\vec{r_2}|} \Big| \psi_0\Big\rangle.  \qquad \\; \qquad\qquad\quad \qquad $$
$$ = \left(\frac{e^2}{4\pi\epsilon_0} \right) \left(\frac{8}{\pi a^3}  \right)
\int \frac{e^{-4(r_1+r_2)/a}}{|\vec{r_1}-\vec{r_2}|} d^3\vec{r_1}
d^3\vec{r_2}.$$

Solving the $\vec{r_2}$ integral first, we align \\( \vec{r_1} \\) to be
along the polar axis in the \\( \vec{r_2} \\) frame.  

![](/heliumdiag2.pdf)

By the law of cosines, \\( |\vec{r_1}-\vec{r_2}| = \sqrt{r_1^2 + r_2^2 - 2r_1r_2\cos\theta_2}\\). Hence, 

$$ I_2 \equiv \int \frac{e^{-4r_2/a}}{|\vec{r_1}-\vec{r_2}|} d^3 \vec{r}_2 = \int
\frac{e^{-4r_2/a}}{\sqrt{r_1^2 + r_2^2 - 2r_1r_2\cos\theta_2}}r_2^2 d\theta_2
d\varphi_2 $$ 

The integrand has no \\( \varphi_2 \\) dependence, so the its contribution is just \\( 2\pi \\).
The \\( \theta_2 \\) integral can be calculated, 

$$ \int_0^\pi \frac{sin\theta_2}{\sqrt{r_1^2 + r_2^2 - 2r_1r_2 \cos\theta_2}} d\theta_2 = 
\frac{\sqrt{r_1^2 + r_2^2 - 2r_1r_2\cos\theta_2}}{r_1r_2} \Big|_0^\pi $$
$$ = \frac{1}{r_1r_2} \big[(r_1+r_2) - |r_1 - r_2|\big] = \begin{cases} 2/r_1, \quad
r_2<r_1, \\\ 2/r_2, \quad r_2>r_1 \end{cases}.$$

Therefore, 

$$ I_2 = 4\pi \left( \frac{1}{r_1} \int_0^{r_1} e^{-4r_2/a} r_2^2dr_2 +
\int_{r_1}^\infty e^{-4r_2/a}r_2dr_2\right) $$
$$ = \frac{\pi a^3}{8r_1} \left\[ 1 - \left( 1 + \frac{2r_1}{a} \right)
e^{-4r_1/a}\right\]. \qquad \qquad \quad\\;\\;$$ 

The \\( r_1 \\) part of the integral is still left. Finally solving for \\( V_{ee} \\), 

$$ \langle V_{ee} \rangle  = \left( \frac{e^2}{4\pi\epsilon_0} \right) \left( \frac{8}{\pi a^3} \right)
\int \left\[ 1 - \left( 1 + \frac{2r_1}{a} \right) e^{-4r_1/a}\right\]
e^{-4r_1/a} r_1 \sin\theta_1 dr_1 d\theta_1 d\varphi_1$$

$$ = \left( \frac{e^2}{4\pi\epsilon_0} \right) \left( \frac{8}{\pi a^3} \right)
\cdot 4\pi \int_0^\infty \left\[ re^{-4r/a} - \left(r+\frac{2r^2}{a} \right)
e^{-8r/a}\right\] dr \qquad \\; \\;    $$

$$ = \frac{5}{4a} \left( \frac{e^2}{4\pi\epsilon_0} \right) = -\frac{5}{2} E_1 =
34 \text{ eV}. \qquad \qquad \qquad \qquad \qquad \qquad \qquad  $$

And hence, 

$$ \langle \hat{H} \rangle = -109 \text{ eV} + 34 \text{ eV} = -75 \text{ eV} . $$

Given the experimental value is \\(\approx -79 \\) eV, we're already only 5%
off from solving an unsolvable equation. Let's keep going!   

To beat this approximation, we have to find a better ansatz wave function. The
closer the ansatz is to the intrinsic Helium ground state, the better. 

Helium is a system wherein electrons ($-e$) not only get pulled by the nuclear charge
$(Z=+2e)$, but also feel a repulsion between each other. This repulsion acts
against the inward pull from the nucleus. In this manner, we can think of each electron
partially "shielding" the nucleus from the other by, making the *net effective*
nuclear charge $Z$ slightly less than 2.  This suggests a ansatz of the form 

$$ \psi_1(\vec{r_1}, \vec{r_2}) \equiv \frac{Z^3}{\pi a^3} e^{-Z(r_1 + r_2)/a}, $$

where we treat \\( Z \\)  as a variational parameter, rather than equating it to
2. This equation is an eigenstate of a hydrogenic Hamiltonian, only with \\( Z \\) this time instead 
of 2. Thus, \\( \hat{H} \\) is evidently 

$$ \hat{H} = -\frac{\hbar^2}{2m} \left( \nabla_1^2 + \nabla_2^2\right) - \frac{e^2}{4\pi\epsilon_0} 
\left( \frac{Z}{r_1} + \frac{Z}{r_2} \right)\quad$$

$$ + \frac{e^2}{4\pi\epsilon_0} \left( \frac{Z-2}{r_1} + \frac{Z-2}{r_2} + \frac{1}{|\vec{r_1} - \vec{r_2}|}\right).$$ 


We'll solve for $\langle \hat{H} \rangle$ similarly which will give us an 
expression involving an arbitary Z. 

$$ \langle \hat{H} \rangle = 2Z^2 E_1 + 2(Z-2)\left(\frac{e^2}{4\pi\epsilon_0} \right)
\Bigg\langle \frac{1}{r} \Bigg\rangle + \langle V_{ee}\rangle. $$ 

For hydrogenic wave functions with nuclear charge \\( Z \\) , the expectation
value $\big\langle \frac{1}{r} \big\rangle = \frac{Z}{a} \hspace{20px}$
($a$ being the Bohr radius).  The expectation value \\( \langle
V_{ee}\rangle  \\) is the exact same as before, just with \\( Z \\) instead of 2. Because the Bohr radius also 
scaled inversely with \\( Z \\), we also adjust \\( a \mapsto \frac{2}{Z}a \\).


$$ \langle V_{ee} \rangle  = \frac{5Z}{8a} \left( \frac{e^2}{4\pi\epsilon_0}
\right) = -\frac{5Z}{4} E_1. $$

Hence, 

$$ \langle \hat{H} \rangle = \left\[ 2Z^2 - 4Z(Z-2) - \frac{5}{4} Z\right\]E_1
= \left\[ -2Z^2 + \frac{27}{4} Z\right\] E_1. $$ 

We're getting close now. Because \\( E_\text{gs} \leq \langle \hat{H} \rangle \\), that is, 
the value above *exceeds* \\( E_\text{gs} \\) for *any* value of \\( Z \\), the
*closest* value to \\( E_\text{gs} \\) occurs when \\( \langle \hat{H} \rangle \\) is minimized. 

$$ \frac{d}{dZ} \langle \hat{H} \rangle = \left\[ -4Z + \frac{27}{4}\right\] E_1
= 0. $$ 

It directly follows that 

$$ Z = \frac{27}{16} = 1.6875. $$ 

So the electrons in Helium shield the nucleus by roughly 16%. Plugging this
value of \\( Z \\)  back into \\( \langle \hat{H} \rangle \\), 


$$ \langle \hat{H} \rangle = \frac{1}{2} \left(\frac{3}{2} \right)^6 E_1 = -77.5
\text{ eV}.$$

This is within 2% of Helium's actual ground state. 

While this was a bit of math, it does showcase the power of the Variational
Principle and how easy it is to use, albeit the complicated integrals. This
procedure is the basis for quantum algorithms like VQE, which quantum chemists
use to approximate the ground state energies for any system. VQE generates its
ansätze using parameterized quantum circuits. In this way, the Variational
Principle turns into a machine learning problem. By continuously adjusting the
parameters of the quantum circuit using gradient descent on the system's Hilbert
space, more accurate ansätze are formed, which yield better ground state energy
approximations.

$$ \hspace{3px} $$ 
$$ \hspace{3px} $$ 




