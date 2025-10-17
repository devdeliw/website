+++ 
title = "Hamiltonian Programming" 
description = "NASA 4" 
tags = ["NASA"]
date = "2025-06-20" 
categories = ["Software", "Math"] 
menu = "main"
+++

{{< katex />}}

The goal of this post is to program the *Spin Hamiltonian* governing
recombination in Silicon Carbide. 

Our system involves two electrons and two nuclei. We define our orthonormal
basis as follows: 

I define the basis of spin $\\{ \uparrow, \downarrow\\}$ as the
*Zeeman Basis*. I define the basis with the two electrons coupled and the nuclei
in the Zeeman Basis as the *coupled basis*.  Every state in our two-electron +
two-nuclei system is then 

$$
\underbrace{|s, m\rangle}\_{\text{electrons}} \underbrace{|m\_{I_1}\rangle
|m\_{I_2}\rangle}\_{\text{nuclei}}. 
$$

We will evaluate $\hat{H}_Z, \hat{H}\_{HF}, \hat{H}\_{ZFS}$, and $\hat{H}\_{EX}$
on the above state(s). 

## Zeeman Hamiltonian 

The Zeeman Hamiltonian, from [Part
1](https://dev-undergrad.dev/posts/nasa_derive_1/), is defined in the *coupled
basis* via 

$$
\begin{align}
\hat{H}_Z |s, m\rangle |m\_{I_1}\rangle |m\_{I_2}\rangle = \underbrace{\left(mg_e \mu_B B_0 + 
m\_{I_1} g\_{n_1} \mu_N B_0 + m\_{I_2} g\_{n_2} \mu_N B_0
\right)}\_{\text{energies}}|s, m\rangle 
|m\_{I_1}\rangle |m\_{I_2}\rangle. 
\end{align}
$$

Here, $g_e$ is $\simeq g$-factor for the electron, $g\_{n_1}$ is the $g$-factor
for the first nucleus (silicon), and $g\_{n_2}$ is the $g$-factor for the second
nucleus (carbon). $\mu_B$ and $\mu_N$ are the [Bohr
Magneton](https://en.wikipedia.org/wiki/Bohr_magneton) and [Nuclear
Magneton](https://en.wikipedia.org/wiki/Nuclear_magneton) respectively. 

The coupled-basis is itself the eigenbasis. To build the Zeeman Hamiltonian, we
first define the coupled basis: 

    import sympy as sp 

    // electron |s, m> pairs 
    electron_pairs = [
        (1, +1),
        (1,  0),
        (0,  0),
        (1, -1),
    ]

    // nuclear |mI1>|mI2> pairs 
    nuclear_pairs = [
        ( sp.Rational(+1,2), sp.Rational(+1,2) ),
        ( sp.Rational(+1,2), sp.Rational(-1,2) ),
        ( sp.Rational(-1,2), sp.Rational(+1,2) ),
        ( sp.Rational(-1,2), sp.Rational(-1,2) ),
    ]


Now we use Equation (1) to every basis state; every combination of the above
electron + nuclei pairs. This will generate our 16 $\times$ 16 Zeeman
Hamiltonian. It will be a diagonal matrix with entries because the coupled-basis is already
the eigenbasis.


    // g_e  = sp.symbol("g_e")
    // g_n1 = sp.symbol("g_n1") 
    // ... 

    // zeeman frequencies
    omega_e   = g_e  * mu_B * B0
    omega_n1  = g_n1 * mu_N * B0
    omega_n2  = g_n2 * mu_N * B0

    energies = []
    for s, m in electron_pairs: 
        for mI1, mI2 in nuclear_pairs: 
            energies.append(
                m*omega_e    +  // electron
                mI1*omega_n1 +  // nucleus 1 
                mI2*omega_n2    // nucleus 2 
            )

    // zeeman hamiltonian  
    H_Z = sp.diag(*energies) 


However, we have to be careful. We rendered the Zeeman Hamiltonian 
in a nested for-loop over the coupled-basis states. This ordering needs to be
immutable for calculating all Hamiltonians.  

--- 

## Hyperfine Hamiltonian

> The Hyperfine Hamiltonian is simplest when all electrons and nuclei are in the
Zeeman $\\{ \uparrow, \downarrow \\}$ basis. We'll first attack solving a
two-electron ($a, b$) + one-nucleus ($I$) system in this basis. Then we'll expand
to the two-electron + two-nuclei system and ultimately convert to the coupled-basis
at the end via a Clebsch-Gordan transformation. 

The Hyperfine Hamiltonian, from [Part 1](https://dev-undergrad.dev/posts/nasa_derive_1/), is defined as 

$$
\begin{align}
\hat{H}_\{HF} = \hat{S}_a \cdot A_a \cdot \hat{I} + \hat{S}_b \cdot A_b \cdot
\hat{I}, 
\end{align}
$$

for a two-electron ($a, b$) and one-nuclei ($I$) system. This is equivalent to 

$$
\hat{H}_{HF} = \sum\_{k \in \\{a, b\\}} A\_{kx} S\_{kx} I_x + A\_{ky}S\_{ky}I_y + A\_{kz}S\_{kz}I_z. 
$$


