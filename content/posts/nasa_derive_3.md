+++ 
title = "The Spin Hamiltonian" 
description = "NASA 3" 
tags = ["NASA"]
date = "2025-06-10" 
categories = ["Math"] 
menu = "main"
+++

{{< katex />}}

{{% hint warning %}}
This post is math heavy. I'll try to walk through it all elegantly though. The
important equations are boxed if you'd like to skip through. On mobile some
equations may go overfull. 

{{% /hint %}}

In [Part 1](https://dev-undergrad.dev/posts/nasa_derive_1/) we derived the
Zeeman Hamiltonian and the Hyperfine Hamiltonian. In [Part
2](https://dev-undergrad.dev/posts/nasa_derive_2/) we derived the Zero-Field
Splitting Hamiltonian analogously. The goal of this post is to derive the last
sub-Hamiltonian for the [Exchange
Interaction](https://en.wikipedia.org/wiki/Exchange_interaction) and
consequently derive the complete Spin Hamiltonian $\mathscr{H}$.  

I use a fancy $\mathscr{H}$ to represent the Spin Hamiltonian.
Sub-Hamiltonians are normal $H$'s but with hats (e.g. $\hat{H}_Z$). 

---

## The Exchange Interaction 

> Quantum mechanics says electrons are *indistinguishable* fermions. Their combined
> spatial + spin wave function must be antisymmetric. This symmetry links
> neighboring electrons spins and positions. $\hat{H}\_{EX}$ is another term that shifts
> energy levels. 

Consider two electrons in orbitals $\phi_a (\vec{r}), \phi_b(\vec{r})$. The
two-electron Hamiltonian is 

$$
H = \sum_{i=1}^2 \left[\underbrace{-\frac{\hbar^2}{2m} \nabla_i^2}\_{\text{kinetic energy}} + 
\underbrace{V(\vec{r}_i)}\_{\text{potential energy}}\right] +
\underbrace{\frac{e^2}{4\pi\epsilon_0} |\vec{r}_1 - \vec{r}_2|}\_{\text{Coulomb
repulsion}}. 
$$

Here, $V(\vec{r})$ is the single-particle potential. Because electrons are
fermions, their state must be antisymmetric under spatial and spin exchange. We
factorize into spatial $\Psi(\vec{r}_1, \vec{r}_2)$ and spin $\chi(s_1, s_2)$
parts:

$$
\Psi_{\text{tot}} (1, 2) = \Psi(\vec{r}_1, \vec{r}_2)\chi(s_1, s_2), 
$$

where antisymmetry requires 

$$
\Psi_{\text{tot}}(2, 1) = -\Psi_{\text{tot}}(1, 2). 
$$

If spatial $\Psi$ is symmetric, then the spin state $\chi$ must be antisymmetric
(a singlet). If $\Psi$ is antisymmetric, $\chi$ must be symmetric (a triplet).

We build orthonormal spatial orbitals $\phi_a, \phi_b$. Let's choose 

$$
\begin{align*} 
\Psi_S(\vec{r}_1, \vec{r}_2) &= \frac{1}{\sqrt{2}}[\phi_a(1) \phi_b(2) +
\phi_b(1)\phi_a(2)] \\\\ 
\Psi_A(\vec{r}_1, \vec{r}_2) &= \frac{1}{\sqrt{2}}[\phi_a(1)\phi_b(2) -
\phi_b(1)\phi_a(2)]. 
\end{align*}
$$

The corresponding spin states are 

$$
\begin{align*} 
\chi_S &= \frac{1}{\sqrt{2}}(|\uparrow \downarrow\rangle - |\downarrow
\uparrow\rangle) \quad \text{(singlet)}, \\\\ 
\chi_A &= \frac{1}{\sqrt{2}}(|\uparrow \downarrow \rangle + |\downarrow
\uparrow\rangle) \quad \text{(triplet)}. 
\end{align*} 
$$

We can diagonalize $H$ into the two-dimensional
subspace spanned by $\phi_a\phi_b$.  Both electrons share the same one-particle
energy, 

$$
E_0 = \langle \phi_a | \hat{h} | \phi_a\rangle + \langle
\phi_b|\hat{h}|\phi_b\rangle, \quad \hat{h} = -\frac{\hbar^2}{2m}\nabla^2 +
V(\vec{r}). 
$$

Therefore, any energy splitting arises entirely from the Coulomb term.

### Energy Splitting

Let's define the "direct" and "exchange" integrals: 

$$
\begin{align*} 
K &\equiv \int \int d^3r\_1 d^3r\_2 \\, |\phi_a (1)|^2 \frac{e^2}{4\pi\epsilon\_0
r\_{12}} |\phi\_b(2)|^2, \\\\ 
J &\equiv \int \int d^3r_1 d^3r_2 \phi_a^* (1) \phi_b (1)
\frac{e^2}{4\pi\epsilon_0r\_{12}} \phi_b^* (2) \phi_a (2). 
\end{align*} 
$$

By magic, 

$$
\begin{align} 
\langle \Psi_S | H | \Psi_S \rangle = E_0 + K + J,  \\\\
\langle \Psi_A | H | \Psi_A \rangle = E_0 + K - J. 
\end{align} 
$$

Thus the singlet sits at energy $E_S = E_0 + K + J$, while each triplet has $E_T
= E_0 + K - J$. Their energy difference/splitting is 

$$ 
\begin{align} 
\Delta E \equiv E_S - E_T = 2J. 
\end{align}
$$

The energy splitting due to the Zero Field $\hat{H}\_{ZFS}$ is analogously also
$2D$. We now wish to replace this two-level spatial + spin system with a pure spin
Hamiltonian that reproduces the same energy shift between singlet and triplet. 

### Exchange Operator 

Recall that the operator exchanging two spins is 

$$
\hat{P}_{12}\chi(1, 2) = \chi(2, 1). 
$$

Its eigenvalues are +1 on the symmetric (triplet) subspace and -1 on the
antisymmetric (singlet) subspace. Define the total spin operator and its square 

$$
\begin{align*}
\hat{\vec{S}}\_{\text{tot}} &= \hat{\vec{S}}_1 + \hat{\vec{S}}_2, \\\\
\hat{S}\_{\text{tot}}^2 &= \hat{S}_1^2 + \hat{S}_2^2 + 2\hat{\vec{S}}_1 \cdot
\hat{\vec{S}}_2. 
\end{align*} 
$$


for spin-1/2 particles, $\hat{S}_1^2 = \hat{S}_2^2 = \hat{S}_x^2 + \hat{S}_y^2 +
\hat{S}_z^2 = \frac{3\hbar^2}{4}\mathbb{I}$. Hence, 

$$
\hat{S}\_{\text{tot}}^2 = \frac{3\hbar^2}{2}\mathbb{I} + 2\hat{\vec{S}}_1 \cdot
\hat{\vec{S}}_2. 
$$

Now for both triplet ($S\_{\text{tot}} = 1$) and singlet ($S\_{\text{tot}} = 0$)
states, 

$$
\begin{align} 
\hat{S}\_{\text{tot}}^2 |10\rangle &= S(S+1)\hbar^2 |10\rangle = 2\hbar^2
|10\rangle \\\\ 
\hat{S}\_{\text{tot}}^2 |00\rangle &= S(S+1)\hbar^2 |00\rangle = 0
\end{align} 
$$

But we need an exchange operator that satisfies 

$$
\begin{align} 
\hat{P}\_{12}|10\rangle &= +|10\rangle \\\\ 
\hat{P}\_{12}|00\rangle &= -|00\rangle. 
\end{align}
$$

We define an ansatz $\hat{P}_{12} = a \hat{S}\_{\text{tot}}^2 + b \mathbb{I}$.
Plugging Equations (4) and (5) into (6) and (7) gives 

$$
\begin{align*} 
\hat{P}\_{12} |10\rangle &= a(2) + b |10\rangle = +1 |00\rangle \\\\
\hat{P}\_{12} |00\rangle &= a(0) + b |00\rangle = -1 |00\rangle. 
\end{align*}
$$

Solving for a and b gives $a = 1$ and $b = -1$. So we get the exchange operator: 

$$
\hat{P}_{12} = 1 \cdot \hat{S}\_{\text{tot}}^2 - 1 \cdot \mathbb{I} =
\hat{S}\_{\text{tot}}^2 - \mathbb{I}. 
$$

The final expression for the exchange operator is 

$$
\hat{P}\_\text{12} = \frac{1}{2} \left(1 + 4 \hat{\vec{S}}_1 \cdot
\hat{\vec{S}}_2 \right). 
$$

Its eigenvalues are correctly -1 on the singlet and +1 on the triplet manifold.
Hence, an operator proportional to $\hat{P}\_{12}$ will split singlet/triplet.


### Proportionality Coefficient 

Define the proportionality coefficient $J\_{ex}$ such that 

$$
\hat{H}\_{EX} = J\_{ex} \hat{P}\_{12} = \frac{J\_{ex}}{2} \left(1 +
4\hat{\vec{S}}_1 \cdot \hat{\vec{S}}_2\right). 
$$

Acting on the singlet and triplet manifolds: 

$$
\begin{align} 
\hat{H}\_{EX} \chi_S &= J\_{ex}(-1)\chi_S \\\\ 
\hat{H}\_{EX} \chi_T &= J\_{ex}(+1)\chi_T. 
\end{align} 
$$

To reproduce the $\Delta E = 2J$ energy splitting from Equation (2) demands $J\_{ex} = -J$. Then 

$$
E_{S} = -J\_{ex} = +J \qquad E_{T} = +J\_{ex} = -J; 
$$
$$ \Delta E = 2J, $$ 

as desired. We set $J$ to be the exchange coupling matrix proportional to the
degree of overlap between wave functions. The Exchange Hamiltonian can finally
be expressed as 

$$
\hat{H}\_{EX} = \hat{\vec{S}}_a \cdot J \cdot \hat{\vec{S}}_b. 
$$

Assuming the exchange coupling is isotropic, we get 

$$ 
\boxed{ 
    \hat{H}\_{EX} = -J \hat{\vec{S}}_a \cdot \hat{\vec{S}}_b. 
}
$$

This is the final component of the 16 $\times$ 16 Spin Hamiltonian. Together,
the Zeeman, Hyperfine, ZFS, and Exchange Hamiltonians can describe the
mechanics of spin-dependent recombination. 

--- 

## Basis States 

For a two-electron (carrier + defect) and two-nuclei (silicon and carbon) spin
system, there are 16 orthonormal basis states. Our Spin Hamiltonian is a matrix
of shape $16 \times 16$.

To make future calculations easier, we'll define our basis states with the
electrons coupled ($|s, m\rangle$) and the nuclei in their Zeeman $\\{\uparrow,
\downarrow \\} \equiv \\{ +\frac{1}{2}, -\frac{1}{2} \\}$ basis. 

### Triplet $|1, +1\rangle$ manifold 

$$
\begin{cases}
|1,1\rangle \otimes |+\tfrac{1}{2}\rangle_1 \otimes |+\tfrac{1}{2}\rangle_2 \\\\ 
|1,1\rangle \otimes |+\tfrac{1}{2}\rangle_1 \otimes |-\tfrac{1}{2}\rangle_2 \\\\ 
|1,1\rangle \otimes |-\tfrac{1}{2}\rangle_1 \otimes |+\tfrac{1}{2}\rangle_2 \\\\ 
|1,1\rangle \otimes |-\tfrac{1}{2}\rangle_1 \otimes |-\tfrac{1}{2}\rangle_2
\end{cases}
$$

### Triplet $|1, 0\rangle$ manifold 

$$
\begin{cases}
|1,0\rangle \otimes |+\tfrac{1}{2}\rangle_1 \otimes |+\tfrac{1}{2}\rangle_2 \\\\ 
|1,0\rangle \otimes |+\tfrac{1}{2}\rangle_1 \otimes |-\tfrac{1}{2}\rangle_2 \\\\ 
|1,0\rangle \otimes |-\tfrac{1}{2}\rangle_1 \otimes |+\tfrac{1}{2}\rangle_2 \\\\ 
|1,0\rangle \otimes |-\tfrac{1}{2}\rangle_1 \otimes |-\tfrac{1}{2}\rangle_2
\end{cases}
$$


### Singlet $|0, 0\rangle$ manifold 

$$
\begin{cases}
|0,0\rangle \otimes |+\tfrac{1}{2}\rangle_1 \otimes |+\tfrac{1}{2}\rangle_2 \\\\ 
|0,0\rangle \otimes |+\tfrac{1}{2}\rangle_1 \otimes |-\tfrac{1}{2}\rangle_2 \\\\ 
|0,0\rangle \otimes |-\tfrac{1}{2}\rangle_1 \otimes |+\tfrac{1}{2}\rangle_2 \\\\ 
|0,0\rangle \otimes |-\tfrac{1}{2}\rangle_1 \otimes |-\tfrac{1}{2}\rangle_2
\end{cases}
$$
 

### Triplet $|1, -1\rangle$ manifold 

$$
\begin{cases}
|1,-1\rangle \otimes |+\tfrac{1}{2}\rangle_1 \otimes |+\tfrac{1}{2}\rangle_2 \\\\ 
|1,-1\rangle \otimes |+\tfrac{1}{2}\rangle_1 \otimes |-\tfrac{1}{2}\rangle_2 \\\\ 
|1,-1\rangle \otimes |-\tfrac{1}{2}\rangle_1 \otimes |+\tfrac{1}{2}\rangle_2 \\\\ 
|1,-1\rangle \otimes |-\tfrac{1}{2}\rangle_1 \otimes |-\tfrac{1}{2}\rangle_2
\end{cases}
$$

The first $|s, m\rangle$ states represent the two electrons in their coupled
basis. The second $|\pm\frac{1}{2}\rangle_1 \otimes |\pm \frac{1}{2}\rangle_2$
states represent the two nuclei in their Zeeman basis.  


Now we are ready to programmatically calculate the Spin Hamiltonian $\mathscr{H}$. 
We'll evaluate its effect on each basis state above. To do this, we program the Zeeman,
Hyperfine, ZFS, and Exchange Hamiltonian's effect on each basis state, and then
sum them together.  


<br> 

<div style="position: relative; width: 100%; margin-top: 2em;">
  <div style="position: absolute; right: 0;">
    {{< button relref="nasa_programming" class="btn" >}}Next →{{< /button >}}
  </div>
  <div style="position: absolute; left: 0;">
    {{< button relref="nasa_derive_2" class="btn" >}}← Previous{{< /button >}}
  </div>
</div>
