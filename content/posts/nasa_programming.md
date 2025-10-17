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
two-nuclei system is given by 

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
&\hat{H}_Z|s, m\rangle |m\_{I_1}\rangle |m\_{I_2}\rangle = \\\\
&\underbrace{\left( mg_e \mu_B B_0 + m\_{I_1} g\_{n_1} \mu_N B_0 + m\_{I_2} g\_{n_2} \mu_N
B_0\right)}\_{\text{energies}}|s, m\rangle |m\_{I_1}\rangle |m\_{I_2}\rangle. 
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


Now we apply Equation (1-2) to every basis state; every combination of the above
electron + nuclei pairs. This will generate our 16 $\times$ 16 Zeeman
Hamiltonian. It will be a diagonal matrix with entries because the coupled-basis is already
the eigenbasis.


    // g_e  = sp.symbol("g_e")
    // g_n1 = sp.symbol("g_n1") 
    // ... 

    // zeeman frequencies
    omega_e  = g_e  * mu_B * B0
    omega_n1 = g_n1 * mu_N * B0
    omega_n2 = g_n2 * mu_N * B0

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
**two-electron ($a, b$) + one-nucleus ($I$) system in Zeeman basis**. Then we'll expand
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
\begin{align}
\hat{H}_{HF} = \sum\_{k \in \\{a, b\\}} A\_{kx} S\_{kx} I_x + A\_{ky}S\_{ky}I_y + A\_{kz}S\_{kz}I_z.
\end{align} 
$$

We use ladder operators $\hat{S}\_+ $ and $\hat{S}\_- $ that give  

$$
\hat{S}\_x = \frac{1}{2}\left(\hat{S}\_+ + \hat{S}\_- \right) \quad \hat{S}_y =
\frac{1}{2i} \left(\hat{S}\_+ - \hat{S}\_-\right),
$$

and likewise for $\hat{I}_x$ and $\hat{I}_y$. Plugging this into Equation (4)
yields 

$$
\begin{align*} 
\hat{H}\_{HF} &= \sum_k A_kx \left(\frac{1}{2}(\hat{S}\_{k+} + \hat{S}\_{k-}) \right)\left(
\frac{1}{2} ( \hat{I}\_+ + \hat{I}\_- ) \right) \\\\ 
&\qquad +A\_{ky} \left( \frac{1}{2i} (\hat{S}\_{k+} - \hat{S}\_{k-} ) \right)
\left( \frac{1}{2i} (\hat{I}\_+ - \hat{I}\_-) \right) + A\_{kz} S\_{kz} I_z \\\\ 
&= \sum_k \frac{A\_{kx}}{4} ( \hat{S}\_{k+} \hat{I}\_+ + \hat{S}\_{k+}
\hat{I}\_- + \hat{S}\_{k-} \hat{I}\_+ + \hat{S}\_{k-} \hat{I}\_-) \\\\ 
&\qquad - \frac{A\_{ky}}{4} (\hat{S}\_{k+}\hat{I}\_+ - \hat{S}\_{k+} \hat{I}\_- 
\hat{S}\_{k-} \hat{I}\_+ + \hat{S}\_{k-} \hat{I}\_- ) + A\_{kz} S\_{kz} I\_z. 
\end{align*} 
$$

We are almost done. From latter operators, we know 

$$ 
\begin{align} 
\hat{S}\_{\pm} |s, m\rangle = \hbar \sqrt{s (s+1) - m(m\pm 1)} |s, m\pm
1\rangle. 
\end{align}
$$

I'll again emphasize we are working in the **purely Zeeman basis** for two
electrons and one nucleus. Each basis state is of the form $|m_a, m_b, m_I\rangle$, 
where each $m_i \in \\{\uparrow, \downarrow \\}$.  

Let's go step by step to evaluate $\hat{H}\_{HF} |m_a, m_b, m_I\rangle$. 
From Equation (5), we find 

$$
\begin{align*} 
\hat{S}\_+ |\uparrow\rangle = 0 \qquad \hat{S}\_+|\downarrow\rangle =
\hbar|\uparrow\rangle \\\\ 
\hat{S}\_- |\downarrow\rangle = 0 \qquad \hat{S}\_+|\uparrow\rangle =
\hbar|\downarrow\rangle \\\\ 
\hat{S}_z|m\rangle = m\hbar |m\rangle, \quad m \in \\{\uparrow, \downarrow \\}.
\end{align*}
$$

Likewise for the nuclear state, where we use $m\in \\{\Uparrow, \Downarrow\\}$,

$$
\begin{align*} 
\hat{I}\_+ |\Uparrow\rangle = 0 \qquad \hat{I}\_+|\Downarrow\rangle =
\hbar|\Uparrow\rangle \\\\ 
\hat{I}\_- |\Downarrow\rangle = 0 \qquad \hat{I}\_+|\Uparrow\rangle =
\hbar|\Downarrow\rangle \\\\ 
\hat{I}_z|m_I\rangle = m_I\hbar |m_I\rangle, \quad m_I \in \\{\Uparrow, \Downarrow \\}.
\end{align*}. 
$$

There are five nontrivial (that don't end up = 0) operator products. One 
electron $\\{\uparrow, \downarrow\\}$ represents both electrons $a, b$ (i.e.
$|\downarrow, \Downarrow\rangle = |\downarrow, \downarrow, \Downarrow\rangle$). 

$$
\begin{align*} 
&\text{product} &&\text{nonzero for} &&&\text{result} \\\\ 
&\hat{S}\_{k+} \hat{I}\_+ && |\downarrow, \Downarrow\rangle &&&
\hbar^2|\uparrow, \Uparrow\rangle  \\\\ 
\hat{S}\_{k+} \hat{I}\_- && |\downarrow, \Uparrow\rangle &&& \hbar^2 |\uparrow,
\Downarrow\rangle \\\\ 
\hat{S}\_{k-} \hat{I}\_+ && |\uparrow, \Downarrow\rangle &&& \hbar^2
|\downarrow, \Uparrow \rangle \\\\ 
\hat{S}\_{k-} \hat{I}\_- && |\uparrow, \Uparrow\rangle &&& \hbar^2 |\downarrow,
\Downarrow \rangle \\\\ 
\hat{S}\_{kz} \hat{I}_z &&\text{any } m\_{a, b} m_I &&& \hbar^2 m\_{a, b} m_I
|m\_{a, b}m_I \rangle. 
\end{align*} 
$$
