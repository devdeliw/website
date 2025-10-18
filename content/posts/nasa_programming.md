+++ 
title = "Hamiltonian Programming" 
description = "NASA 4" 
tags = ["NASA"]
date = "2025-06-20" 
categories = ["Software", "Math"] 
menu = "main"
+++

{{< katex />}}

{{% hint info %}}
This is a long post. On mobile some equations may go overfull. 
{{% /hint %}}

The goal of this post is to elegantly program the *Spin Hamiltonian* governing
recombination in Silicon Carbide. Our system involves two electrons and two nuclei.

We define our orthonormal basis as follows: 

The ${\uparrow, \downarrow}$ spin basis is called the Zeeman basis.
I define the basis with the two electrons coupled and the nuclei
in the Zeeman Basis as the *coupled basis*.  Every state in our two-electron +
two-nuclei system is given by 

$$
\underbrace{|s, m\rangle}\_{\text{electrons}} \underbrace{|m\_{I_1}\rangle
|m\_{I_2}\rangle}\_{\text{nuclei}}. 
$$

We will evaluate $\hat{H}_Z, \hat{H}\_{HF}, \hat{H}\_{ZFS}$, and $\hat{H}\_{EX}$
on the above state(s). 

## Zeeman 

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

### Implementation

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

    // zeeman constants
    g_e  = sp.symbol("g_e")
    g_n1 = sp.symbol("g_n1") 
    // ... 

    // zeeman frequencies
    omega_e  = g_e  * mu_B * B0
    omega_n1 = g_n1 * mu_N * B0
    omega_n2 = g_n2 * mu_N * B0

    energies = []
    for s, m in electron_pairs:         // electrons run slow  
        for mI1, mI2 in nuclear_pairs:  // nuclei run fast 
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

## Hyperfine

> The Hyperfine Hamiltonian is simplest when all electrons and nuclei are in the
Zeeman $\\{ \uparrow, \downarrow \\}$ basis. We'll first attack solving a
**two-electron ($a, b$) + one-nucleus ($I$) system in Zeeman basis**. Then we'll expand
to the two-electron + two-nuclei system and ultimately convert to the coupled-basis
at the end via a Clebsch-Gordan transformation. 

### Two electrons and one nucleus

The Hyperfine Hamiltonian, from [Part 1](https://dev-undergrad.dev/posts/nasa_derive_1/), is defined as 

$$
\begin{align}
\hat{H}_{HF} = \hat{S}_a \cdot A_a \cdot \hat{I} + \hat{S}_b \cdot A_b \cdot
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
\hat{H}\_{HF} &= \sum_k A\_{kx} \left(\frac{1}{2}(\hat{S}\_{k+} + \hat{S}\_{k-}) \right)\left(
\frac{1}{2} ( \hat{I}\_+ + \hat{I}\_- ) \right) \\\\ 
&\qquad +A\_{ky} \left( \frac{1}{2i} (\hat{S}\_{k+} - \hat{S}\_{k-} ) \right)
\left( \frac{1}{2i} (\hat{I}\_+ - \hat{I}\_-) \right) + A\_{kz} S\_{kz} I_z \\\\ 
&= \sum_k \frac{A\_{kx}}{4} ( \hat{S}\_{k+} \hat{I}\_+ + \hat{S}\_{k+}
\hat{I}\_- + \hat{S}\_{k-} \hat{I}\_+ + \hat{S}\_{k-} \hat{I}\_-) \\\\ 
&\qquad - \frac{A\_{ky}}{4} (\hat{S}\_{k+}\hat{I}\_+ - \hat{S}\_{k+}\hat{I}\_- - \hat{S}\_{k-}\hat{I}\_+ + \hat{S}\_{k-}\hat{I}\_- ) + A\_{kz} S\_{kz} I\_z. 
\end{align*} 
$$

We are almost done. From ladder operators, we know 

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
\hat{S}\_- |\downarrow\rangle = 0 \qquad \hat{S}\_-|\uparrow\rangle =
\hbar|\downarrow\rangle \\\\ 
\hat{S}_z|m\rangle = m\hbar |m\rangle, \quad m \in \\{\uparrow, \downarrow \\}.
\end{align*}
$$

Likewise for the nuclear state, where we use $m\in \\{\Uparrow, \Downarrow\\}$,

$$
\begin{align*} 
\hat{I}\_+ |\Uparrow\rangle = 0 \qquad \hat{I}\_+|\Downarrow\rangle =
\hbar|\Uparrow\rangle \\\\ 
\hat{I}\_- |\Downarrow\rangle = 0 \qquad \hat{I}\_-|\Uparrow\rangle =
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
&\hat{S}\_{k+} \hat{I}\_- && |\downarrow, \Uparrow\rangle &&& \hbar^2 |\uparrow,
\Downarrow\rangle \\\\ 
&\hat{S}\_{k-} \hat{I}\_+ && |\uparrow, \Downarrow\rangle &&& \hbar^2
|\downarrow, \Uparrow \rangle \\\\ 
&\hat{S}\_{k-} \hat{I}\_- && |\uparrow, \Uparrow\rangle &&& \hbar^2 |\downarrow,
\Downarrow \rangle \\\\ 
&\hat{S}\_{kz} \hat{I}_z &&\text{any} &&& \hbar^2 m\_{a, b} m_I
|m\_{a, b}, m_I \rangle. 
\end{align*} 
$$

The last term contributes to *diagonal* terms only. It leaves the state $|m\_{a, b}, m_I\rangle$
constant; adds no mixing.

We can construct the Hyperfine Hamiltonian *in the Zeeman basis* using this
table. 

$$
\begin{align*}
\hat{H}\_{HF} |m\_a, m\_b, m\_I\rangle &= \sum\_{k\in\\{a, b\\}} \frac{\hbar^2}{4}
(A\_{kx} - A\_{ky}) \hat{S}\_{k+} \hat{I}\_+ \delta\_{m\_k, m\_I} |-m\_k, \quad,
-m\_I\rangle  \\\\ 
&\qquad\\;\\; +\frac{\hbar^2}{4} (A\_{kx} - A\_{ky}) \hat{S}\_{k+} \hat{I}\_{-} \delta\_{m\_k,
-m\_I} |-m\_k,\quad, -m_I\rangle \\\\ 
&\qquad\\;\\; + A\_{kz} \hbar^2 m_k m_I |m_k, \quad, m_I\rangle.
\end{align*}
$$

A blank $m_b$ means it can be either $\uparrow$ or $\downarrow$. Expanding the
summation, 

$$
\begin{align*} 
\hat{H}\_{HF} |m_a, m_b, m_I \rangle &= \hbar^2 (A\_{az} m_a m_I + A\_{bz}m_b
m_I ) |m_a, m_b, m_I\rangle \\\\ 
&+ \frac{\hbar^2}{4} [ (A\_{ax} - A\_{ay}) \delta\_{m_a, m_I} + (A\_{ax} +
A\_{ay}) \delta\_{m_a, -m_I}] |-m_a, m_b, -m_I\rangle \\\\ 
&+ \frac{\hbar^2}{4} [ (A\_{bx} - A\_{by}) \delta\_{m_b, m_I} + (A\_{bx} +
A\_{by}) \delta\_{m_b, -m_I} ] |m_a, -m_b, m_I\rangle, 
\end{align*} 
$$

where $m_a, m_b, m_I$ all run over $\\{\uparrow, \downarrow\\}$. The equation
above defines $\hat{H}\_{HF}$ for an 8 Zeeman-basis two-electron + one-nucleus
system. Evolving it to our two-electron + two-nuclei system in silicon carbide
is straightforward.

### Two electrons and two nuclei 

For two electrons $k\in\\{a, b\\}$ and two nuclei $p \in \\{1, 2\\}$, 

$$
\hat{H}\_{HF} = \sum\_{k\in\\{a, b\\}} \sum\_{p=1}^2 ( A\_{kpx} S\_{kx} I\_{px} + A\_{kpy} S\_{ky} I\_{py} + A\_{kpz} S\_{kz} I\_{pz}). 
$$

Following the same procedure as the one-nucleus system, we get the full
Hyperfine Hamiltonian action on $|m_a, m_b, m\_{I_1}, m\_{I_2} \rangle$.

$$
\boxed{
\begin{align*} 
\hat{H}\_{HF} &|m_a, m_b, m\_{I_1}, m\_{I_2} \rangle \\\\
&= \hbar^2 \sum\_{p=1}^{2} (A\_{apz} m_a m\_{I_p} + A\_{bpz} m_b m\_{I_p}) |m_a, m_b, m\_{I_1}, m\_{I_2}\rangle \\\\ 
&+ \frac{\hbar^2}{4} [ (A\_{a1x} - A\_{a1y}) \delta\_{m_a, m\_{I_1}} + (A\_{a1x} + A\_{a1y}) \delta\_{m_a, -m\_{I_1}} ] |-m_a, m_b, -m\_{I_1}, m\_{I_2}\rangle \\\\ 
&+ \frac{\hbar^2}{4} [ (A\_{a2x} - A\_{a2y}) \delta\_{m_a, m\_{I_2}} + (A\_{a2x} + A\_{a2y}) \delta\_{m_a, -m\_{I_2}} ] |-m_a, m_b, m\_{I_1}, -m\_{I_2}\rangle \\\\ 
&+ \frac{\hbar^2}{4} [ (A\_{b1x} - A\_{b1y}) \delta\_{m_b, m\_{I_1}} + (A\_{b1x} + A\_{b1y}) \delta\_{m_b, -m\_{I_1}} ] |m_a, -m_b, -m\_{I_1}, m\_{I_2}\rangle \\\\ 
&+ \frac{\hbar^2}{4} [ (A\_{b2x} - A\_{b2y}) \delta\_{m_b, m\_{I_2}} + (A\_{b2x} + A\_{b2y}) \delta\_{m_b, -m\_{I_2}} ] |m_a, -m_b, m\_{I_1}, -m\_{I_2}\rangle.
\end{align*} 
}
$$

However, we must remember this is the Zeeman $\uparrow, \downarrow$ basis. We
need to convert it to the same coupled basis we used for defining the Zeeman
Hamiltonian. 

In Quantum mechanics, you learn about Clebsch-Gordan coefficients. These are
coefficients that describe how to map the Zeeman $|\uparrow, \downarrow\rangle$ basis to the 
coupled $|s, m\rangle$ basis. We make a matrix transformation out of these
coefficients. 

For mapping the coupled basis to the Zeeman basis, we have 

$$
\begin{pmatrix} |\uparrow \uparrow \rangle \\\\ 
|\uparrow \downarrow \rangle \\\\ 
|\downarrow \uparrow \rangle \\\\
|\downarrow \downarrow \rangle \end{pmatrix} = 
\begin{pmatrix} 
1 & 0 & 0 & 0 \\\\ 
0 & \frac{1}{\sqrt{2}} & \frac{1}{\sqrt{2}} & 0 \\\\ 
0 & \frac{1}{\sqrt{2}} & -\frac{1}{\sqrt{2}} & 0 \\\\ 
0 & 0 & 0 & 1 
\end{pmatrix} \begin{pmatrix} 
|11\rangle \\\\ 
|10\rangle \\\\ 
|00\rangle \\\\ 
|1-1\rangle 
\end{pmatrix}.
$$

Therefore, we cleverly define $W$: 

$$
\begin{align}
W = 
\begin{pmatrix} 
1 & 0 & 0 & 0 \\\\ 
0 & \frac{1}{\sqrt{2}} & \frac{1}{\sqrt{2}} & 0 \\\\ 
0 & \frac{1}{\sqrt{2}} & -\frac{1}{\sqrt{2}} & 0 \\\\ 
0 & 0 & 0 & 1 
\end{pmatrix} 
\otimes
\begin{pmatrix} 
1 & 0 & 0 & 0 \\\\ 
0 & 1 & 0 & 0 \\\\ 
0 & 0 & 1 & 0 \\\\ 
0 & 0 & 0 & 1 
\end{pmatrix},
\end{align}
$$

where we $\otimes \mathbb{I}_4$ because we want to leave the nuclear $|m\_{I_1},
m\_{I_2}\rangle$ in the Zeeman basis and only couple the electrons into $|s,
m\rangle$. Then, once we have the full 16 $\times$ 16 Hyperfine Hamiltonian in
the Zeeman Basis, we can directly apply the transformation 

$$
\begin{align}
\hat{H}\_{HF\_{\text{coupled}}} = W \left(\hat{H}\_{HF\_{\text{Zeeman}}}\right)
W^\dagger
\end{align}
$$

to get the final Hyperfine Hamiltonian in the coupled basis. We have to ensure
that after this transformation, the ordering is identical to the ordering of the
Zeeman Hamiltonian. 

### Implementation

We first build the 16 Zeeman basis states in correct order. Electron states run
slow. Nuclear states run fast. 

    /// builds correctly ordered zeeman basis 
    def _generate_zeeman_basis(self):

        half = sp.Rational(1, 2)
        return [
            (m_a, m_b, m_I1, m_I2)
            for m_a in (half, -half)
            for m_b in (half, -half)
            for m_I1 in (half, -half)
            for m_I2 in (half, -half)
        ] // len 16 

The trickiest part is emulating the boxed equation above.  To begin, we define
the following helper functions for working with delta functions.  
    
    /// if spins are parallel
    def _delta_parallel(self, m_e, m_I): 
        return m_e == m_I

    /// if spins are antiparallel
    def _delta_antiparallel(self, m_e, m_I):
        return m_e == -m_I

Next, we have to write a function that takes in a $|m_a, m_b, m\_{I_1},
m\_{I_2}\rangle$ and outputs the resulting coefficient in front from performing 
$\hat{H}\_{HF} |m_a, m_b, m\_{I_1}, m\_{I_2}\rangle$. 

The coefficients are of the form 

$$
\frac{\hbar^2}{4}\left[(A\_{i1x} - A\_{i1y}) \delta\_{m_i, m\_{I_j}} + (A\_{i1x} +
A\_{i1y})\delta\_{m_i, -m\_{I_j}} \right], 
$$

where $i \in \\{a, b \\}$ and $j \in \\{1, 2\\}$. We'll do this by generating a
`dict[new_ket, coeff]` that associates each key `new_ket` with its `coeff` in
front step by step. In code we set $\hbar = 1$ to simplify. It'll get included later.  

{{% steps %}} 
1. #### Hyperfine $A$ constants. 
   These are unknown constants that are present in $\hat{H}\_{HF}$. We generate
   another `dict[key, sp.Symbol]`. where the `sp.Symbol`s are the actual
   constants. We'll access them via their `key`

        self.A = {}  
        for e in ('a', 'b'):
            for n in ('1', '2'):
                for comp in ('x', 'y', 'z'):
                    key = f'A{e}{n}{comp}'
                    self.A[key.upper()] = sp.symbols(key) 

2. #### Diagonal $\hat{S}_z\hat{I}_z$ terms. 
   The first term in the boxed $\hat{H}\_{HF}$ expression is simplest. It leaves 
   $|m_a, m_b, m\_{I_1}, m\_{I_2}\rangle$ as an eigenstate. The coefficients 
   in front are just products of $A m\_{a/b} m\_{I\_{1, 2}}$. We'll attack these
   first. 

        def _action_on_ket(self, ket): 
            m_a, m_b, m_I1, m_I2 = ket

            // {new_ket: coeff} 
            psi = {}

            // diagonal S_z I_z term
            // A * m_e * m_I
            diag = (
                self.A['AA1Z'] * m_a * m_I1 + // A_{a1z}
                self.A['AB1Z'] * m_b * m_I1 + // A_{b1z} 
                self.A['AA2Z'] * m_a * m_I2 + // A_{a2z}
                self.A['AB2Z'] * m_b * m_I2   // A_{b2z}
            )
            psi[ket] = diag 

            // more to come

3. #### Off-Diagonal $\delta$ terms 
   These coefficients are more difficult. They involve delta functions that
   either do nothing or collapse states to 0 depending on spins 
   $m_i$ and $m\_{I_j}$ being parallel or antiparallel. This will be where we use
   our `_delta_parallel` and `_delta_antiparallel` helpers. 

            /// off-diagonal flip-flop
            /// S_x I_x + S_y I_y -> (A_x - A_y)/4 
            def add_flip(m_e, m_I, x_key, y_key, new_ket):
                if self._delta_parallel(m_e, m_I):
                    coeff = (self.A[x_key] - self.A[y_key]) / 4
                    psi[new_ket] = coeff
                elif self._delta_antiparallel(m_e, m_I):
                    coeff = (self.A[x_key] + self.A[y_key]) / 4
                    psi[new_ket] = coeff

                                                // --- final states we know 
            add_flip(m_a, m_I1, 'AA1X', 'AA1Y', (-m_a,  m_b, -m_I1,  m_I2))
            add_flip(m_a, m_I2, 'AA2X', 'AA2Y', (-m_a,  m_b,  m_I1, -m_I2))
            add_flip(m_b, m_I1, 'AB1X', 'AB1Y', ( m_a, -m_b, -m_I1,  m_I2))
            add_flip(m_b, m_I2, 'AB2X', 'AB2Y', ( m_a, -m_b,  m_I1, -m_I2))

            return psi

{{% /steps %}} 

Now, evaluating $\hat{H}\_{HF}$ on every *Zeeman* state gives us the full
Hyperfine Hamiltonian in the Zeeman basis. We just iterate through and build.
`SymPy` syntax isn't important. 

    /// 16x16 hyperfine hamiltonian 
    /// zeeman Basis 
    def _build_zeeman_matrix(self):
        self.basis_ze = self._generate_zeeman_basis()  
        self.index_ze = { 
            ket: i for i, ket in enumerate(self.basis_ze)
        }

        size = len(self.basis_ze) 
    
        // initialize 16x16 matrix 
        H = sp.MutableDenseMatrix(size, size, lambda *_: 0)

        // iterate through zeeman states 
        for j, ket in enumerate(self.basis_ze):
            action = self._action_on_ket(ket)

            // input coefficients into matrix
            for new_ket, coeff in action.items():
                i = self.index_ze[new_ket]
                H[i, j] = coeff

        return H.as_immutable()

Now all that is left is to apply the Clebsch-Gordan $W$ transformation in
Equation (7). Let's first build $W$ from Equation (6). It's a tensor product of
a $4\times 4$ Clebsch-Gordan matrix with the $4\times 4$ identity. 

    /// builds the unitary Clebsch-Gordan transformation W 
    def _build_cg_unitary(self):
        half = sp.sqrt(sp.Rational(1, 2))

        U = sp.Matrix([                    // 4x4 CG
            [1,    0,     0,    0],
            [0,  half,  half,   0],
            [0,  half, -half,   0],
            [0,    0,     0,    1]
        ])

        I4 = sp.eye(4)                     // 4x4 identity

        return sp.kronecker_product(U, I4) // W 

Finally! We can calculate $\hat{H}\_{HF}$ in our ordered coupled-basis. 

        // zeeman basis 
        self.H_ze = self._build_zeeman_matrix() 

        // clebsch gordan W 
        self.W = self._build_cg_unitary()                       

        // final hyperfine hamiltonian 
        // coupled basis
        self.H_HF = sp.simplify(self.W * self.H_ze * self.W.H)


<br> 

<div style="position: relative; width: 100%; margin-top: 2em;">
  <div style="position: absolute; left: 0;">
    {{< button relref="nasa_derive_3" class="btn" >}}← Previous{{< /button >}}
  </div>
</div>

## Zero-Field Splitting

In [Part 2](https://dev-undergrad.dev/posts/nasa_derive_2/) we derived
$\hat{H}\_{ZFS}$'s action on a general $|s, m\rangle$. 

$$
\begin{align} 
\hat{H}\_{ZFS}|s, m\rangle &= Dm^2 |s, m\rangle - \frac{D}{3}(s(s+1))|s, m\rangle \\\\ 
&+ \frac{E}{2} (s(s+1) - m(m+1))|s, m+2\rangle \\\\ 
&+ \frac{E}{2} (s(s+1) - m(m-1))|s, m-2\rangle.
\end{align}. 
$$ 

The last two terms give the forbidden $m \pm 2$ transitions that create the
half-field response (to be described later). This Hamiltonian acts on the
electrons only. It's a dipole-dipole interaction. Nuclear terms are left alone.
That makes things quite easy. 

### Implementation

We directly build $\hat{H}\_{ZFS}$ while maintaining the ordered basis. From the
[Zeeman
Implementation](https://dev-undergrad.dev/posts/nasa_programming/#zeeman-hamiltonian), we have 

    // electron |s, m> pairs 
    electron_pairs = [
        (1, +1),
        (1,  0),
        (0,  0),
        (1, -1),
    ]


We'll just use that again to maintain the basis. The first term, Equation (8),
give the diagonal elements ($|s, m\rangle$ are the eigenstates). Equation
(9-10) give the off-diagonal elements that mix $m \rightarrow m\pm 2$.

    // zfs constants
    D = sp.symbols('D')
    E = sp.symbols('E') 

    // 4x4 
    // zfs on coupled electrons
    H_elec = sp.zeros(4)

    for i, (s, m) in enumerate(electron_pairs):

        // diagonal term
        // D * m^2 - (D/3) * s(s+1)
        H_elec[i, i] = D*m**2 - (D/3)*s*(s + 1)

        // off-diagonal term 
        // coupling m -> m +/- 2
        for dm, expr in [
            (2, E/2*(s*(s + 1) - m*(m + 1))),
            (-2, E/2*(s*(s + 1) - m*(m - 1)))
        ]:
            // m +/- 2
            final_m = m + dm
            if (s, final_m) in electron_pairs:
                j = electron_pairs.index((s, final_m))

                H_elec[i, j] = expr
                H_elec[j, i] = expr

    // 4x4 
    // nuclei identity 
    I_nuc = sp.eye(4)

    // 16x16 zfs hamiltonian 
    H_ZFS = sp.kronecker_product(H_elec, I_nuc)

We take the tensor product $\hat{H}\_{ZFS\_{\text{electron}}} \otimes
\mathbb{I}_4$ again to lift the electronic $4\times 4$ Hamiltonian to a $16\times 16$ one
in our Hilbert space. This gives $\hat{H}\_{ZFS}$ in the coupled-basis.

## Exchange Interaction 

From [Part 3](https://dev-undergrad.dev/posts/nasa_derive_3/), we derived 

$$
\hat{H}\_{EX} = -J \hat{S}_a \cdot \hat{S}_b, 
$$

Let's take $\hat{S} = \hat{S}_a + \hat{S}_b$. Then 

$$
\hat{S}^2 = \hat{S}_a^2 + \hat{S}_b^2 + 2 \hat{S}_a \cdot \hat{S}_b. 
$$

Rearranging to calculate $\hat{S}_a \cdot \hat{S}_b$, we find that 

$$
\hat{S}_a \cdot \hat{S}_b = \frac{1}{2}(\hat{S}^2 - \hat{S}_a^2 - \hat{S}_b^2). 
$$

Acting on the coupled electron basis $|s, m\rangle$, the three terms in the
parenthesis satisfy 

$$
\begin{align*}
\hat{S}^2 |s, m\rangle &= \hbar^2 s(s+1)|s, m\rangle, \\ 
\hat{S}_a^2 |s, m\rangle &= \frac{3\hbar^2}{4}|s, m\rangle, \\ 
\hat{S}_b^2 |s, m\rangle &= \frac{3\hbar^2}{4}|s, m\rangle. 
\end{align*}
$$

Hence, 

$$
\hat{S}_a \cdot \hat{S}_b |s, m\rangle = \frac{\hbar^2}{2}\left[ s(s+1) -
\frac{3}{2} \right] |s, m\rangle. 
$$

$\hat{H}\_{EX}$ immediately follows: 

$$
\hat{H}\_{EX} |s, m\rangle = -J \frac{\hbar^2}{2} \left[ s(s+1) -
\frac{3}{2}\right] |s, m\rangle. 
$$

We'll also program this with $\hbar = 1$. $\hat{H}\_{EX}$ already
acts on the coupled-basis (nuclear $|m_I\rangle$ are left alone). Additionally,
all states are eigenstates; $\hat{H}\_{EX}$ is diagonal. Programming
this is the easiest. 

    // exchange constant 
    J = sp.symbols('J')

    // 4x4 
    H_ex_elec = sp.zeros(4) 

    for i, (s, m) in enumerate(electron_pairs): 
        H_ex_elec[i, i] = -J*(s*(s + 1) - 1.5) / 2 

    // 4x4 
    // nuclear identity 
    I_nuc = sp.eye(4) 

    // 16x16 exchange hamiltonian 
    H_EX = sp.kronecker_product(H_ex_elec, I_nuc) 

Again, we take the tensor product of the 4$\times$ 4 electron Hamiltonian with
the 4$\times$ 4 identity to yield the full 16$\times$ 16 $\hat{H}\_{EX}$ in our
Hilbert space.

## Full Spin 

The Spin Hamiltonian $\mathscr{H}$ is just 

    H_SPIN = H_Z + H_HF + H_ZFS + H_EX

### Basis 

The coupled-basis is shown below. Indices 0-15 indicate top-to-bottom and
left-to-right row/column basis states in $\mathscr{H}$'s matrix representation. 

$$
\begin{align*}
0  && \qquad |1,1\rangle \otimes |+\tfrac{1}{2}, +\tfrac{1}{2}\rangle \\\\
1  && \qquad |1,1\rangle \otimes |+\tfrac{1}{2}, -\tfrac{1}{2}\rangle \\\\
2  && \qquad |1,1\rangle \otimes |-\tfrac{1}{2}, +\tfrac{1}{2}\rangle \\\\
3  && \qquad |1,1\rangle \otimes |-\tfrac{1}{2}, -\tfrac{1}{2}\rangle \\\\
4  && \qquad |1,0\rangle \otimes |+\tfrac{1}{2}, +\tfrac{1}{2}\rangle \\\\
5  && \qquad |1,0\rangle \otimes |+\tfrac{1}{2}, -\tfrac{1}{2}\rangle \\\\
6  && \qquad |1,0\rangle \otimes |-\tfrac{1}{2}, +\tfrac{1}{2}\rangle \\\\
7  && \qquad |1,0\rangle \otimes |-\tfrac{1}{2}, -\tfrac{1}{2}\rangle \\\\
8  && \qquad |0,0\rangle \otimes |+\tfrac{1}{2}, +\tfrac{1}{2}\rangle \\\\
9  && \qquad |0,0\rangle \otimes |+\tfrac{1}{2}, -\tfrac{1}{2}\rangle \\\\
10 && \qquad |0,0\rangle \otimes |-\tfrac{1}{2}, +\tfrac{1}{2}\rangle \\\\
11 && \qquad |0,0\rangle \otimes |-\tfrac{1}{2}, -\tfrac{1}{2}\rangle \\\\
12 && \qquad |1,-1\rangle \otimes |+\tfrac{1}{2}, +\tfrac{1}{2}\rangle \\\\
13 && \qquad |1,-1\rangle \otimes |+\tfrac{1}{2}, -\tfrac{1}{2}\rangle \\\\
14 && \qquad |1,-1\rangle \otimes |-\tfrac{1}{2}, +\tfrac{1}{2}\rangle \\\\
15 && \qquad |1,-1\rangle \otimes |-\tfrac{1}{2}, -\tfrac{1}{2}\rangle
\end{align*}.
$$

$|+\frac{1}{2}\rangle = |\Uparrow\rangle$ and $|-\frac{1}{2}\rangle =
|\Downarrow\rangle$ (nuclei-only). 

Now we have a Spin Hamiltonian. However, it has many unknown constants. 

$$
\begin{align*} 
&g_e && \quad \text{electron $g$-factor} \\\\ 
&g\_{n_1}, g\_{n_2} && \quad \text{nuclear $g$-factor (Si, C)} \\\\ 
&\mu_B &&\quad \text{Bohr magneton} \\\\ 
&\mu_N &&\quad \text{Nuclear magneton} \\\\ 
&B_0 &&\quad \text{external magnetic field} \\\\ 
&A\_{ijx}, \\, A\_{ijy} \\, A\_{ijz} &&\quad \text{hyperfine tensor components} \\\\ 
&D &&\quad\text{axial zero-field splitting} \\\\ 
&E &&\quad\text{transverse zero-field splitting} \\\\ 
&J &&\quad \text{exchange coupling}
\end{align*}
$$




Our next challenge is to perform eigenenergy simulations. I want a plot like in
[Part 1](https://dev-undergrad.dev/posts/nasa_derive_1/#the-zeeman-effect) but
for *every* combination of every sub-Hamiltonian in $\mathscr{H}$, and for all
16 coupled-basis states. 

This may seem ambitious, but it's very straightforward. We already have matrices
for all the Hamiltonians. We just need to substitute values for all the
constants above and sweep over the $B_0$ field parameter in $\hat{H}_Z$. Then
we'll use [LAPACK](https://www.netlib.org/lapack/) to calculate the energy eigenvalues 
at each $B_0$ field point. Consequently we'll have our plots for $B_0$ vs.
energy. 

<div style="position: relative; width: 100%; margin-top: 2em;">
  <div style="position: absolute; left: 0;">
    {{< button relref="nasa_derive_3" class="btn" >}}← Previous{{< /button >}}
  </div>
</div>

