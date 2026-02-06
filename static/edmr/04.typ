#set page(width: 8.5in, height: 37in)
#show link: set text(fill: rgb("#005ad9"))

== The Exchange Interaction and The Spin Hamiltonian
Deval Deliwala

This note derives the final sub-Hamiltonian
for the
#link("https://en.wikipedia.org/wiki/Exchange_interaction")[exchange interaction],
and then writes the complete spin Hamiltonian $scr(H)$.

I use $scr(H)$ to represent the full spin Hamiltonian. Sub-Hamiltonians are
written as hatted $H$'s (for example, $hat(H)_Z$).

=== The Exchange Interaction

Quantum mechanics says electrons are indistinguishable fermions. Their combined
spatial and spin wavefunction must be antisymmetric. This symmetry links nearby
electrons’ spins and positions. The exchange interaction is another term that
splits energy levels.

Consider two electrons in orbitals $phi_a(arrow(r))$ and $phi_b(arrow(r))$. The
two-electron Hamiltonian is

$
H
= sum_(i=1)^2
  [
    underbrace(
      -planck^2 / (2 m) nabla_i^2
    , upright("kinetic energy"))
    +
    underbrace(
      V(arrow(r)_i)
    , upright("potential energy"))
  ]
  +
  underbrace(
    e^2 / (4 pi epsilon_0) 1 / (|arrow(r)_1 - arrow(r)_2|)
  , upright("Coulomb repulsion")).
$

Here, $V(arrow(r))$ is the one-particle potential. Because electrons are
fermions, the total state must be antisymmetric under exchange. We factor it
into spatial and spin parts:

$
Psi_("tot")(1, 2) = Psi(arrow(r)_1, arrow(r)_2) chi(s_1, s_2),
$

where antisymmetry requires

$
Psi_("tot")(2, 1) = -Psi_("tot")(1, 2).
$

If the spatial $Psi$ is symmetric, then the spin state $chi$ must be
antisymmetric (a singlet). If $Psi$ is antisymmetric, $chi$ must be symmetric
(a triplet).

We build orthonormal spatial orbitals $phi_a, phi_b$ and define

$
Psi_S(arrow(r)_1, arrow(r)_2)
= 1 / sqrt(2) [phi_a (1) phi_b (2) + phi_b (1) phi_a (2)],
$

$
Psi_A(arrow(r)_1, arrow(r)_2)
= 1 / sqrt(2) [phi_a (1) phi_b (2) - phi_b (1) phi_a (2)].
$

The corresponding spin states are

$
chi_S
= 1 / sqrt(2) (|arrow.t arrow.b⟩ - |arrow.b arrow.t⟩)
quad (upright("singlet")),
$

$
chi_A
= 1 / sqrt(2) (|arrow.t arrow.b⟩ + |arrow.b arrow.t⟩)
quad (upright("triplet")).
$

We can diagonalize $H$ in the two-dimensional subspace spanned by $phi_a phi_b$.
Both electrons share the same one-particle energy,

$
E_0
= ⟨phi_a| hat(h) |phi_a⟩ + ⟨phi_b| hat(h) |phi_b⟩,
quad
hat(h) = -planck^2 / (2 m) nabla^2 + V(arrow(r)).
$

Therefore, any energy splitting arises entirely from the Coulomb term.

=== Energy Splitting

Define the direct and exchange integrals:

$
K
equiv integral.double d^3 r_1 d^3 r_2 #h(1em)
|phi_a (1)|^2 e^2 / (4 pi epsilon_0 r_(1 2)) |phi_b (2)|^2,
$

$
J
equiv integral.double d^3 r_1 d^3 r_2 #h(1em)
phi_a^* (1) phi_b (1)
e^2 / (4 pi epsilon_0 r_(1 2))
phi_b^* (2) phi_a (2).
$

Then

$
⟨Psi_S| H |Psi_S⟩ = E_0 + K + J,
quad
⟨Psi_A| H |Psi_A⟩ = E_0 + K - J.
$

Thus the singlet sits at energy $E_S = E_0 + K + J$, while each triplet has
$E_T = E_0 + K - J$. Their energy splitting is

$
Delta E equiv E_S - E_T = 2 J.
$

The energy splitting due to $hat(H)_("ZFS")$ is analogously $2 D$. We now want a
pure spin Hamiltonian that reproduces the same singlet–triplet shift.

=== Exchange Operator

The operator exchanging two spins is

$
hat(P)_(1 2) chi(1, 2) = chi(2, 1).
$

Its eigenvalues are $+1$ on the symmetric (triplet) subspace and $-1$ on the
antisymmetric (singlet) subspace.

Define the total spin operator and its square:

$
hat(arrow(S))_("tot") = hat(arrow(S))_1 + hat(arrow(S))_2,
$

$
hat(S)^2_("tot")
= hat(S)_1^2 + hat(S)_2^2 + 2 hat(arrow(S))_1 dot hat(arrow(S))_2.
$

For spin-$1/2$ particles,

$
hat(S)_1^2 = hat(S)_2^2
= hat(S)_x^2 + hat(S)_y^2 + hat(S)_z^2
= (3 planck^2) / 4 bb(1).
$

Hence,

$
hat(S)^2_("tot") = (3 planck^2) / 2 bb(1) + 2 hat(arrow(S))_1 dot hat(arrow(S))_2.
$

For triplet $S_("tot") = 1$ and singlet $S_("tot") = 0$ states,

$
hat(S)^2_("tot") |1 0⟩ = 2 planck^2 |1 0⟩,
quad
hat(S)^2_("tot") |0 0⟩ = 0.
$

But we need an exchange operator that satisfies

$
hat(P)_(1 2) |1 0⟩ = +|1 0⟩,
quad
hat(P)_(1 2) |0 0⟩ = -|0 0⟩.
$

Take an ansatz $hat(P)_(1 2) = a hat(S)^2_("tot") + b bb(I)$. Solving gives the
standard result

$
hat(P)_(1 2) = 1/2 (1 + 4 hat(arrow(S))_1 dot hat(arrow(S))_2).
$

Its eigenvalues are $-1$ on the singlet and $+1$ on the triplet manifold. An
operator proportional to $hat(P)_(1 2)$ therefore splits singlet and triplet.

=== Proportionality Coefficient

Define $J_("ex")$ such that

$
hat(H)_("EX")
= J_("ex") hat(P)_(1 2)
= J_("ex") / 2 (1 + 4 hat(arrow(S))_1 dot hat(arrow(S))_2).
$

Acting on the singlet and triplet manifolds:

$
hat(H)_("EX") chi_S = J_("ex") (-1) chi_S,
quad
hat(H)_("EX") chi_T = J_("ex") (+1) chi_T.
$

To reproduce $Delta E = 2 J$ requires $J_("ex") = -J$. Then

$
E_S = -J_("ex") = +J,
quad
E_T = +J_("ex") = -J,
$

$
Delta E = 2 J,
$

as desired. We treat $J$ as an exchange coupling proportional to orbital overlap.
Assuming isotropic exchange, the exchange Hamiltonian can be written as

#box(
  fill: luma(250),
  inset: 10pt,
  width: 100%,
  [
$
hat(H)_("EX") = -J hat(arrow(S))_a dot hat(arrow(S))_b.
$
  ],
)

This is the final component of the $16 times 16$ spin Hamiltonian. Together, the
Zeeman, hyperfine, ZFS, and exchange Hamiltonians describe the core mechanics of
spin-dependent recombination.

== Basis States

For a two-electron (carrier + defect) and two-nucleus (silicon and carbon) spin
system, there are 16 orthonormal basis states. The full spin Hamiltonian is a
$16 times 16$ matrix.

To make future calculations easier, we define basis states with the electrons
coupled into $|s, m⟩$ and the nuclei in their Zeeman basis
$(|arrow.t⟩, |arrow.b⟩) equiv (|+1/2⟩, |-1/2⟩)$.

==== Triplet $|1, +1⟩$ manifold

$
|1, 1⟩ times.o |+1/2⟩_1 times.o |+1/2⟩_2 \
|1, 1⟩ times.o |+1/2⟩_1 times.o |-1/2⟩_2 \
|1, 1⟩ times.o |-1/2⟩_1 times.o |+1/2⟩_2 \
|1, 1⟩ times.o |-1/2⟩_1 times.o |-1/2⟩_2
$

==== Triplet $|1, 0⟩$ manifold

$
|1, 0⟩ times.o |+1/2⟩_1 times.o |+1/2⟩_2 \
|1, 0⟩ times.o |+1/2⟩_1 times.o |-1/2⟩_2 \
|1, 0⟩ times.o |-1/2⟩_1 times.o |+1/2⟩_2 \
|1, 0⟩ times.o |-1/2⟩_1 times.o |-1/2⟩_2
$

==== Singlet $|0, 0⟩$ manifold

$
|0, 0⟩ times.o |+1/2⟩_1 times.o |+1/2⟩_2 \
|0, 0⟩ times.o |+1/2⟩_1 times.o |-1/2⟩_2 \
|0, 0⟩ times.o |-1/2⟩_1 times.o |+1/2⟩_2 \
|0, 0⟩ times.o |-1/2⟩_1 times.o |-1/2⟩_2
$

==== Triplet $|1, -1⟩$ manifold

$
|1, -1⟩ times.o |+1/2⟩_1 times.o |+1/2⟩_2 \
|1, -1⟩ times.o |+1/2⟩_1 times.o |-1/2⟩_2 \
|1, -1⟩ times.o |-1/2⟩_1 times.o |+1/2⟩_2 \
|1, -1⟩ times.o |-1/2⟩_1 times.o |-1/2⟩_2
$

The first $|s, m⟩$ term is the coupled two-electron basis. The
$|plus.minus 1/2⟩_1 times.o |plus.minus 1/2⟩_2$ terms are the two nuclei in their Zeeman basis.

Now we are ready to compute $scr(H)$ programmatically. We evaluate each
sub-Hamiltonian on the basis states above and sum the results.

