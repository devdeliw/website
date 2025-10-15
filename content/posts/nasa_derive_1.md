+++ 
title = "The Spin Hamiltonian" 
description = "NASA 1" 
tags = ["NASA"]
date = "2025-06-06" 
categories = ["Physics"] 
menu = "main"
+++

{{< katex />}}

This post is math heavy. I'll try to walk through it all elegantly though. 

The Spin Hamiltonian $\mathscr{H}$ governs the spin-physics of recombination. It's what we
need to program before starting to simulate EDMR.

$ \mathscr{H} $ is a combination of the Zeeman Effect, Hyperfine Interactions,
the Zero-field Splitting Effect, and the Exchange Interaction. 

$$
\mathscr{H} = 
\hat{H}\_{\mathrm{Z}}   + 
\hat{H}\_{\mathrm{HF}}  + 
\hat{H}\_{\mathrm{ZFS}} + 
\hat{H}\_{\mathrm{EX}}
$$ 

Normally $\mathscr{H}$ also has a "Nuclear Quadropole Interaction Hamiltonian"
as well. But since Silicon Carbide (4H-SiC) has no nuclei with nuclear spin $I >
1/2$, it's set to 0. 

The goal of this post is to provide a good enough derivation of each
Hamiltonian term. Finally, a complete Hamiltonian description is given. 

I use a fancy $\mathscr{H}$ to represent the full Spin Hamiltonian.
Sub-Hamiltonians are normal $H$'s but with hats (e.g. $\hat{H}_Z$). 

---

## The Zeeman Effect 

A spinning charged particle is a magnetic dipole. Its magnetic dipole moment,
$\vec{\mu}$, is proportional to its spin angular momentum, $\vec{S}$ 

$$ \vec{\mu} = \gamma \vec{S}.$$

The proportionality constant, $\gamma$ is the *gyromagnetic ratio.* From the
Dirac equation it can be shown 

$$
\vec{\mu} = \gamma \vec{S} = -g \frac{q}{2m\_e} \vec{S} = -\frac{g\mu\_B}{\hbar}
\vec{S}, 
$$

where $g \approx 2.0023$ is the Landé $g$-factor for the free electron
and $\mu_B \approx 9.2 \cdot 10^{-24} J/T $ is the Bohr Magneton.  

When a magnetic dipole is placed in a magnetic field $\vec{B}$, it experiences
a torque, $\vec{\mu} \times \vec{B}$, which tends to line it up parallel to the
field like a compass. The energy associated with this torque is 

$$
H = -\vec{\mu} \cdot \vec{B} = -\gamma \vec{B} \cdot \vec{S}. 
$$

Therefore, the Zeeman Hamiltonian is 

$$
\hat{H}_Z = -\mu_0 \cdot \vec{B}_0 = \frac{g\mu_B}{\hbar} \vec{S} \cdot
\vec{B}_0 = \frac{g\mu_B}{\hbar}B_0 S_z
$$    

where $S_z = \frac{\hbar}{2} \hat{\sigma}_z$ and $\sigma_z$ is the Pauli-$z$ spin
matrix. Applying $\hat{H}_Z$ on an arbitrary spin state $|s, m_s\rangle$ gives 

$$
\begin{align*}
\hat{H}_Z |s, m_s\rangle &= \frac{g\mu_B}{\hbar}B_0 \cdot S_z |s, m_s\rangle
\\\\ &= \frac{g\mu_B}{\hbar}B_0 \cdot m_s\hbar|s, m_s\rangle \\\\ 
&= m_s g \mu_B B_0 |s, m_s\rangle. 
\end{align*}
$$

Ordinarily we use an anisotropic $g$-tensor. Magnetic fields across different
axes act differently on $|s, m_s\rangle$. So we would replace with a $3 \times 3$ $g$
tensor, 

$$\hat{H}_Z = \mu_B \vec{S} \cdot g \cdot \vec{B}_0.$$

This can be diagonalized along $|s, m_s\rangle$'s principle axis to make things easier.  

$$ g\_{\mathrm{diag}} = \begin{pmatrix} g_x & 0 & 0 \\\\ 0 & g_y & 0 \\\\ 0 & 0
& g_z \end{pmatrix}. $$

For our simulation though, we'll start with a scalar $g \approx 2.0023$. 
Our Zeeman Hamiltonian is defined as

$$ 
\boxed { 
\hat{H}_Z |s, m_s\rangle = m_s g \mu_B B_0 |s, m_s\rangle.
}
$$
