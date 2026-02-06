#set page(width: 8.5in, height: 69in)
#show link: set text(fill: rgb("#005ad9"))

== Programming the Spin Hamiltonian
Deval Deliwala

The goal of this post is to program the spin Hamiltonian governing recombination
in silicon carbide. Our system has two electrons and two nuclei.

We fix an ordered orthonormal basis. The electrons are in the coupled basis
$|s, m chevron.r$. The nuclei remain in the Zeeman basis
$(|+1/2 chevron.r, |-1/2 chevron.r)$. Every state is written as

$
|s, m chevron.r
|m_(I 1) chevron.r
|m_(I 2) chevron.r.
$

We will build $hat(H)_Z$, $hat(H)_(H F)$, $hat(H)_(Z F S)$, and $hat(H)_(E X)$
in this same ordering.

=== Zeeman

The Zeeman Hamiltonian in this basis is diagonal:

$ 
hat(H)_Z |s, m chevron.r | m_(I 1) chevron.r | m_(I 2) chevron.r = 
(m g_e mu_B B_0 + mu_N B_0 ( m_(I 1) g_(n 1) + m_(I 2) g_(n 2))
|s, m chevron.r |m_(I 1) chevron.r | m_(I 2) chevron.r.
$

Here $g_e$ is the electron $g$-factor. $g_(n 1)$ and $g_(n 2)$ are the nuclear
$g$-factors (silicon and carbon). $mu_B$ and $mu_N$ are the
#link("https://en.wikipedia.org/wiki/Bohr_magneton")[Bohr magneton] and
#link("https://en.wikipedia.org/wiki/Nuclear_magneton")[nuclear magneton].

==== Implementation

We encode the basis ordering explicitly. Electron states run slow. Nuclear states
run fast.

#box(
  fill: luma(250),
  width: 100%,
  inset: 8pt,
  [
```py
import sympy as sp

# electron coupled basis |s, m>
electron_pairs = [
    (1, +1),
    (1,  0),
    (0,  0),
    (1, -1),
]

# nuclear Zeeman basis |mI1>|mI2>
nuclear_pairs = [
    (sp.Rational(+1, 2), sp.Rational(+1, 2)),
    (sp.Rational(+1, 2), sp.Rational(-1, 2)),
    (sp.Rational(-1, 2), sp.Rational(+1, 2)),
    (sp.Rational(-1, 2), sp.Rational(-1, 2)),
]
```
  ]
)

Then we apply the energy formula to every basis state in the same order.

#box(
  fill: luma(250),
  width: 100%,
  inset: 8pt,
  [
```py
g_e, g_n1, g_n2 = sp.symbols("g_e g_n1 g_n2")
mu_B, mu_N, B0  = sp.symbols("mu_B mu_N B0")

omega_e  = g_e  * mu_B * B0
omega_n1 = g_n1 * mu_N * B0
omega_n2 = g_n2 * mu_N * B0

energies = []
for s, m in electron_pairs:        # electrons run slow
    for mI1, mI2 in nuclear_pairs: # nuclei run fast
        energies.append(
            m   * omega_e +
            mI1 * omega_n1 +
            mI2 * omega_n2
        )

H_Z = sp.diag(*energies)
```
  ]
)

This nested-loop ordering is now fixed. Every other Hamiltonian must match it.

=== Hyperfine

The hyperfine Hamiltonian is simplest to construct in the Zeeman
$(|arrow.t chevron.r, |arrow.b chevron.r)$ basis. We will build
$hat(H)_(H F)$ in the Zeeman basis for both electrons and both nuclei, then
convert the electron subspace into the coupled basis using a Clebsch–Gordan
transform.

==== Two electrons and two nuclei

For two electrons $k in {a, b}$ and two nuclei $p in {1, 2}$,

$
hat(H)_(H F)
=
sum_(k in {a, b}) sum_(p = 1)^2
(
A_(k p x) S_(k x) I_(p x)
+ A_(k p y) S_(k y) I_(p y)
+ A_(k p z) S_(k z) I_(p z)
).
$

We implement this using ladder-operator bookkeeping. In the Zeeman basis, the
only actions we need are

$
S_+ |arrow.b chevron.r = planck |arrow.t chevron.r, \
S_- |arrow.t chevron.r = planck |arrow.b chevron.r, \
S_z |m chevron.r = m planck |m chevron.r,
$

and the same structure for $I_+, I_-, I_z$ on nuclear states.

Following this bookkeeping, the action on a Zeeman-basis state
$|m_a, m_b, m_(I 1), m_(I 2) chevron.r$ can be written compactly as:

#box(
  fill: luma(250),
  width: 100%,
  inset: 10pt,
  [
$
hat(H)_(H F) |m_a, m_b, &m_(I 1), m_(I 2) chevron.r
=
planck^2 sum_(p = 1)^2
(
A_(a p z) m_a m_(I p) + A_(b p z) m_b m_(I p)
)
|m_a, m_b, m_(I 1), m_(I 2) chevron.r \
&+
planck^2 / 4
(
(A_(a 1 x) - A_(a 1 y)) delta_(m_a, m_(I 1))
+ (A_(a 1 x) + A_(a 1 y)) delta_(m_a, -m_(I 1))
)
|-m_a, m_b, -m_(I 1), m_(I 2) chevron.r \
&+
planck^2 / 4
(
(A_(a 2 x) - A_(a 2 y)) delta_(m_a, m_(I 2))
+ (A_(a 2 x) + A_(a 2 y)) delta_(m_a, -m_(I 2))
)
|-m_a, m_b, m_(I 1), -m_(I 2) chevron.r \
&+
planck^2 / 4
(
(A_(b 1 x) - A_(b 1 y)) delta_(m_b, m_(I 1))
+ (A_(b 1 x) + A_(b 1 y)) delta_(m_b, -m_(I 1))
)
|m_a, -m_b, -m_(I 1), m_(I 2) chevron.r \
&+
planck^2 / 4
(
(A_(b 2 x) - A_(b 2 y)) delta_(m_b, m_(I 2))
+ (A_(b 2 x) + A_(b 2 y)) delta_(m_b, -m_(I 2))
)
|m_a, -m_b, m_(I 1), -m_(I 2) chevron.r.
$
  ]
)

This builds $hat(H)_(H F)$ in the Zeeman basis for the electrons. We now convert
the electron subspace to the coupled basis.

==== Clebsch–Gordan transform

The mapping between electron Zeeman states and electron coupled states is

$
mat(
|arrow.t arrow.t chevron.r;
|arrow.t arrow.b chevron.r;
|arrow.b arrow.t chevron.r;
|arrow.b arrow.b chevron.r;
)
=
U
mat(
|1, 1 chevron.r;
|1, 0 chevron.r;
|0, 0 chevron.r;
|1, -1 chevron.r;
),
$

with

$
U
=
mat(
1, 0, 0, 0;
0, 1/sqrt(2), 1/sqrt(2), 0;
0, 1/sqrt(2), -1/sqrt(2), 0;
0, 0, 0, 1;
).
$

We lift this to the full Hilbert space by leaving nuclei unchanged:

$
W = U times.o I_4.
$

If $H_(H F, "Zeeman")$ is built in the ordered Zeeman basis, then the coupled
basis matrix is

$
H_(H F, "coupled") = W H_(H F, "Zeeman") W^dagger.
$

==== Implementation

We generate the 16 Zeeman-basis kets in a fixed order.

#box(
  fill: luma(250),
  width: 100%,
  inset: 8pt,
  [
```py
import sympy as sp

def generate_zeeman_basis():
    half = sp.Rational(1, 2)
    return [
        (m_a, m_b, m_I1, m_I2)
        for m_a in (half, -half)      # electrons run slow
        for m_b in (half, -half)
        for m_I1 in (half, -half)     # nuclei run fast
        for m_I2 in (half, -half)
    ]
```
  ]
)

We implement the delta logic and build the sparse action map `{new_ket: coeff}`.
In the code below we set `planck = 1` and restore factors later.

#box(
  fill: luma(250),
  width: 100%,
  inset: 8pt,
  [
```py
def delta_parallel(m_e, m_I):
    return m_e == m_I

def delta_antiparallel(m_e, m_I):
    return m_e == -m_I

class HyperfineBuilder:
    def __init__(self):
        self.A = {}
        for e in ("a", "b"):
            for n in ("1", "2"):
                for comp in ("x", "y", "z"):
                    key = f"A{e}{n}{comp}".upper()
                    self.A[key] = sp.symbols(key)

    def action_on_ket(self, ket):
        m_a, m_b, m_I1, m_I2 = ket
        psi = {}

        # diagonal Sz Iz terms
        diag = (
            self.A["AA1Z"] * m_a * m_I1 +
            self.A["AB1Z"] * m_b * m_I1 +
            self.A["AA2Z"] * m_a * m_I2 +
            self.A["AB2Z"] * m_b * m_I2
        )
        psi[ket] = diag

        def add_flip(m_e, m_I, x_key, y_key, new_ket):
            if delta_parallel(m_e, m_I):
                psi[new_ket] = (self.A[x_key] - self.A[y_key]) / 4
            elif delta_antiparallel(m_e, m_I):
                psi[new_ket] = (self.A[x_key] + self.A[y_key]) / 4

        # off-diagonal flip-flops
        add_flip(m_a, m_I1, "AA1X", "AA1Y", (-m_a,  m_b, -m_I1,  m_I2))
        add_flip(m_a, m_I2, "AA2X", "AA2Y", (-m_a,  m_b,  m_I1, -m_I2))
        add_flip(m_b, m_I1, "AB1X", "AB1Y", ( m_a, -m_b, -m_I1,  m_I2))
        add_flip(m_b, m_I2, "AB2X", "AB2Y", ( m_a, -m_b,  m_I1, -m_I2))

        return psi
```
  ]
)

We build the Zeeman-basis matrix by iterating through basis states and inserting
coefficients.

#box(
  fill: luma(250),
  width: 100%,
  inset: 8pt,
  [
```py
def build_hyperfine_zeeman_matrix():
    builder = HyperfineBuilder()

    basis = generate_zeeman_basis()
    index = {ket: i for i, ket in enumerate(basis)}

    n = len(basis)
    H = sp.MutableDenseMatrix(n, n, lambda *_: 0)

    for j, ket in enumerate(basis):
        action = builder.action_on_ket(ket)
        for new_ket, coeff in action.items():
            i = index[new_ket]
            H[i, j] = coeff

    return H.as_immutable()
```
  ]
)

Now we build $W = U times.o I_4$ and transform into the coupled basis.

#box(
  fill: luma(250),
  width: 100%,
  inset: 8pt,
  [
```py
def build_cg_unitary():
    half = sp.sqrt(sp.Rational(1, 2))
    U = sp.Matrix([
        [1,    0,     0,    0],
        [0,  half,  half,   0],
        [0,  half, -half,   0],
        [0,    0,     0,    1],
    ])
    I4 = sp.eye(4)
    return sp.kronecker_product(U, I4)

H_HF_ze = build_hyperfine_zeeman_matrix()
W = build_cg_unitary()

H_HF = sp.simplify(W * H_HF_ze * W.H)
```
  ]
)

=== Zero-Field Splitting

From the previous derivation, the action on a general $|s, m chevron.r$ is

$
hat(H)_(Z F S) |s, m chevron.r
&=
(D m^2) |s, m chevron.r
- D / 3 (s (s + 1)) |s, m chevron.r \
&+
E / 2 (s (s + 1) - m (m + 1)) |s, m + 2 chevron.r \
&+
E / 2 (s (s + 1) - m (m - 1)) |s, m - 2 chevron.r.
$

This term acts only on the electron subspace, so we lift it with a tensor product
by $I_4$ on the nuclei.

==== Implementation

#box(
  fill: luma(250),
  width: 100%,
  inset: 8pt,
  [
```py
import sympy as sp

electron_pairs = [
    (1, +1),
    (1,  0),
    (0,  0),
    (1, -1),
]

D, E = sp.symbols("D E")

# 4x4 electron ZFS matrix (coupled basis)
H_elec = sp.zeros(4)

for i, (s, m) in enumerate(electron_pairs):
    H_elec[i, i] = D * m**2 - (D / 3) * s * (s + 1)

    for dm, expr in [
        ( 2, (E / 2) * (s * (s + 1) - m * (m + 1))),
        (-2, (E / 2) * (s * (s + 1) - m * (m - 1))),
    ]:
        m2 = m + dm
        if (s, m2) in electron_pairs:
            j = electron_pairs.index((s, m2))
            H_elec[i, j] = expr
            H_elec[j, i] = expr

I_nuc = sp.eye(4)
H_ZFS = sp.kronecker_product(H_elec, I_nuc)
```
  ]
)

=== Exchange Interaction

From the previous derivation,

$
hat(H)_(E X) = -J (hat(S)_a dot hat(S)_b).
$

Using $hat(S) = hat(S)_a + hat(S)_b$,

$
hat(S)_a dot hat(S)_b
= 1/2 (hat(S)^2 - hat(S)_a^2 - hat(S)_b^2).
$

For spin-1/2 electrons in the coupled basis,

$
hat(S)^2 |s, m chevron.r = planck^2 s (s + 1) |s, m chevron.r, \
hat(S)_a^2 |s, m chevron.r = (3 planck^2) / 4 |s, m chevron.r, \
hat(S)_b^2 |s, m chevron.r = (3 planck^2) / 4 |s, m chevron.r.
$

Therefore,

$
hat(H)_(E X) |s, m chevron.r
=
-J planck^2 / 2 (s (s + 1) - 3/2) |s, m chevron.r.
$

This is diagonal in the coupled basis and lifts by $times.o I_4$ on nuclei.

==== Implementation

#box(
  fill: luma(250),
  width: 100%,
  inset: 8pt,
  [
```py
import sympy as sp

J = sp.symbols("J")

H_ex_elec = sp.zeros(4)

for i, (s, m) in enumerate(electron_pairs):
    H_ex_elec[i, i] = -J * (s * (s + 1) - sp.Rational(3, 2)) / 2

I_nuc = sp.eye(4)
H_EX = sp.kronecker_product(H_ex_elec, I_nuc)
```
  ]
)

=== Full spin Hamiltonian

Once all four sub-Hamiltonians are constructed in the same ordered basis, the
full Hamiltonian is

#box(
  fill: luma(250),
  width: 100%,
  inset: 8pt,
  [
```py
H_SPIN = H_Z + H_HF + H_ZFS + H_EX
```
  ]
)

==== Basis ordering

Indices 0–15 refer to the row/column ordering of $scr(H)$.

#box( 
  fill: luma(250),
  inset: 8pt, 
  width: 100%, 
  [
$ 
&0  &&|1, 1 chevron.r &&&times.o |+1/2, +1/2 chevron.r \
&1  &&|1, 1 chevron.r &&&times.o |+1/2, -1/2 chevron.r \
&2  &&|1, 1 chevron.r &&&times.o |-1/2, +1/2 chevron.r \
&3  &&|1, 1 chevron.r &&&times.o |-1/2, -1/2 chevron.r \
&4  &&|1, 0 chevron.r &&&times.o |+1/2, +1/2 chevron.r \
&5  &&|1, 0 chevron.r &&&times.o |+1/2, -1/2 chevron.r \
&6  &&|1, 0 chevron.r &&&times.o |-1/2, +1/2 chevron.r \
&7  &&|1, 0 chevron.r &&&times.o |-1/2, -1/2 chevron.r \
&8  &&|0, 0 chevron.r &&&times.o |+1/2, +1/2 chevron.r \
&9  &&|0, 0 chevron.r &&&times.o |+1/2, -1/2 chevron.r \
&10 &&|0, 0 chevron.r &&&times.o |-1/2, +1/2 chevron.r \
&11 &&|0, 0 chevron.r &&&times.o |-1/2, -1/2 chevron.r \
&12 &&|1, -1 chevron.r &&&times.o |+1/2, +1/2 chevron.r \
&13 &&|1, -1 chevron.r &&&times.o |+1/2, -1/2 chevron.r \
&14 &&|1, -1 chevron.r &&&times.o |-1/2, +1/2 chevron.r \
&15 &&|1, -1 chevron.r &&&times.o |-1/2, -1/2 chevron.r
$
]
)

(For nuclei only: $|+1/2 chevron.r = |arrow.t chevron.r$ and
$|-1/2 chevron.r = |arrow.b chevron.r$.)

=== Next step

At this point $scr(H)$ contains unknown constants:

#box( 
  fill: luma(250),
  inset: 8pt, 
  width: 100%, 
[
$
g_e &quad upright("electron g-factor") \
g_(n 1), g_(n 2) &quad upright("nuclear g-factors (Si, C)") \
mu_B &quad upright("Bohr magneton") \
mu_N &quad upright("nuclear magneton") \
B_0 &quad upright("external magnetic field") \
A_(k p x), A_(k p y), A_(k p z) &quad upright("hyperfine tensor components") \
D &quad upright("axial zero-field") \
E &quad upright("transverse zero-field") \
J &quad upright("exchange coupling").
$
]
)

The next step is eigenenergy simulation. We substitute values for these
constants and sweep over $B_0$ in $hat(H)_Z$. At each field point we compute the
eigenvalues of $scr(H)$, producing $B_0$ vs. energy curves for all 16 states. We
will use #link("https://www.netlib.org/lapack/")[LAPACK] solves.
