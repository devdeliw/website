+++ 
title = "The Spin Hamiltonian" 
description = "NASA 1" 
tags = ["NASA"]
date = "2025-06-06" 
categories = ["Software", "Physics"] 
menu = "main"
+++

{{< katex />}}

This post will be math heavy. I'll try to walk through it all elegantly though.

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

The goal of this paper is to provide a thorough overview and derivation of each
Hamiltonian term. Finally, a complete Hamiltonian description is given. 

## The Zeeman Effect 

A spinning charged particle is a magnetic dipole. Its magnetic dipole moment,
$\vec{\mu}$, is proportional to its spin angular momentum, $\vec{S}$: 

$$ \vec{\mu} = \gamma \vec{S}.$$

The proportionality constant, $\gamma$ is the *gyromagnetic ratio.* From the
Dirac equation it can be shown 

$$
\vec{\mu} = \gamma \vec{S} = -g \frac{q}{2m\_e} \vec{S} = -\frac{g\mu\_B}{\hbar}
\vec{S}, 
$$

where $g \approx 2.0023$ is the Landé $g$-factor and $\mu\_B \approx 9.2 \cdot
10^{-24} J/T $ is the Bohr Magneton. 

