---
title: 'Puzzle: Quantifying Entanglement pt.1'
date: 2024-10-21T23:48:58-07:00
draft: false
---

10/22/2024

## Entanglement Background 

Quantum entanglement is something I think most people hear in science fiction
or in the news -- some fancy physics jargon not well understood. There's so
much research going on regarding local and nonlocal *faster-than-light*
entanglement (a Nobel prize was awarded for this work in 2022) that show we aren't
even close to fully understanding it. 

Quantum mechanics (QM) as a whole even -- Max Planck just thought of
considering light as a rattling gun of photons (small packets of energy) to
resolve the Ultraviolet Catastrophe -- and ultimately, with work from Einstein
and deBroglie, out came one of the founding
principles of QM, wave-particle duality. 

QM is truly beautiful in that it works, allowing us to probe and understand the
mind-boggingly weird nature of elementary particles. However, we don't *truly*
understand it. We don't know *why* non-commuting observables like position and
momentum have an uncertainty principle; we don't know why all electrons are
identical; we don't know why, fundamentally, entanglement is even a thing. Of
course, we know these properties are true, and we can use math to show they are
true. 

But is it true that *God* or *Nature* made everything this way, with a calculator in one hand
continuously computing the states of every atom in the universe. Possibly?. 
Mother Nature may just be some supercomputing entity controlling the time
evolution of every particle in the universe. Then perhaps we don't have any
free will. I shouldn't get into philosophy here though. The point is at the
base of QM lies many assumptions. QM works! Mathematical Proofs are there! But
the principle axioms of QM are just Nature, I guess. 

>The fact is, all electrons are utterly identical, in a way that no two classical objects can ever be. It’s not just that we don’t know which electron is which; **God** doesn’t know which is which.  -- Griffiths, Introduction to QM. 3rd ed.


Entanglement is a crazy phenomena that is a consequence of QM --
physically being able to alter the state of one qubit from measuring another.


Here's an example. 

Consider the following one-qubit state, 

$$ |\psi\rangle = \frac{1}{\sqrt{2}}(|0\rangle + |1\rangle).$$

The above equation tells us that if we *measure* \\( |\psi\rangle \\), we will
yield the state \\( |0\rangle \\) with \\( \frac{1}{2}  \\) probability and
likewise \\( |1\rangle \\) with \\( \frac{1}{2}  \\)  probability. But now
let's consider a similar setup, but with a two-qubit system, denoted \\(
|\Phi_+\rangle \\).

$$  
|\Phi_+\rangle = \frac{1}{\sqrt{2}}(|0\rangle \otimes |0\rangle + |1\rangle \otimes
|1\rangle), 
$$
$$
\hspace{-35px} = \frac{1}{\sqrt{2}}(|00\rangle + |11\rangle) .
$$ 

Let's say we measure the first qubit (the one on the left). On a side note, IBM
Qiskit has a really weird notation where the furthest qubit on the *right* is
actually the first. But anyways, measuring the *leftest* qubit yields, just
like the one-qubit state $|\psi\rangle$, 

$$ |0\rangle \quad \text{probability } \frac{1}{2}, $$
$$ |1\rangle \quad \text{probability } \frac{1}{2}. $$

But if you look back again at the two-qubit system, if the first qubit
collapses to \\( |0\rangle \\) post measurement, the two-qubit state becomes \\( |00\rangle \\) with certainty -- the second qubit collapes to \\( |0\rangle  \\) automatically! And likewise if the first qubit collapses to \\( |1\rangle \\), so too must the second qubit. What this means is measuring \\( |\Phi_+\rangle  \\) yields the two qubit states: 

$$ |00\rangle \quad \text{probability } \frac{1}{2}, $$
$$ |11\rangle \quad \text{probability } \frac{1}{2}. $$

Here, the first and second qubits, immediately post-measurement, *must* always be equivalent. Think about this carefully.
Just by *measuring* the state of the *first* qubit -- we automatically
**force** the second qubit into a state, in this case the same state. 

## The Partial Trace 
 
In the above case I used an intuitive relation between the two-qubit
$|\Phi_+\rangle$ system and the single-qubit $|\psi\rangle$ system to showcase
entanglement. Specifically, I said measuring the leftest qubit yields, *just
like the one-qubit state* $|\psi\rangle$, ... Or in other words,
I treated the first qubit as being in the same state as $|\psi\rangle$. 

Well, from Quantum Information Theory, we know that entangled states don't have
a tensor product decomposition. There exist no states $|\xi_1\rangle$ and
$|\xi_2\rangle$ such that 

$$ |\Phi_+\rangle = |\xi_1\rangle \otimes |\xi_2\rangle.$$

Therefore, there isn't a *purely* identifiable "leftest-qubit" state. Both
qubits, being entangled, are *intimately connected*. We can't isolate one from
the ohter. But then again, it does seem like for the $|\Phi_+\rangle$ state, the
leftest-qubit *can* be defined by $|\psi\rangle$. Or more accurately,
$|\psi\rangle$ defines the *left-part* of $|\Phi_+\rangle$.

![](/trace1.pdf)


It turns out, there is actually a way, to *trace*-out, or extract, the single qubit component of
a multi-qubit system, even for a system that can not be decomposed into tensor products of
states. The **partial-trace** is kind of like the inverse of a tensor product.
Rather than *building* states and combining them, it throws out states we *don't* care about and 
restricts our view to the rest. 

For a density operator  \\( \rho = \xi_1 \otimes \xi_2 \\) defining the system
\\( \mathcal{H}_A \otimes \mathcal{H}_B \\) with \\(
\xi_1 \\) corresponding to the \\( \mathcal{H}_A \\) part  and \\( \xi_2 \\)
corresponding to the \\( \mathcal{H}_B \\) part,  we define tracing away 
\\( \xi_1 \\) and \\( \xi_2 \\) as 

$$ \text{tracing away } |\xi_1\rangle: \quad tr_{\xi_1} \xi_1 \otimes \xi_2
= (tr \xi_1) \cdot \xi_2, $$

$$ \text{tracing away } |\xi_2\rangle: \quad tr_{\xi_2} \xi_1 \otimes \xi_2
= \xi_1 \cdot (tr \xi_2). $$

It quite literally is taking the trace of the part you want to throw out. 

Let's work with \\( |\Phi_0\rangle \\) 

$$ |\Phi_0\rangle = \frac{1}{\sqrt{2}} (|00\rangle + |11\rangle)  .$$


I'll call the left-most (first) qubit \\( A \\) and the second qubit \\( B \\). Let's try to extract the "$A$-part" of the $|\Phi_+\rangle$ state. I'll denote
the density matrix of \\( |\Phi_+\rangle \\) as \\( \rho_+ = |\Phi_+\rangle
\langle \Phi_+|\\). I'll begin by calculating $\rho_+$. 

$$  \rho_+ = |\Phi_+\rangle \langle \Phi_+\rangle $$
$$  = \frac{1}{2}[ |00\rangle \langle 00| + |00\rangle \langle 11| + |11\rangle \langle 00| + |11\rangle\langle 11|]. $$ 

Unfortunately, like I said before, this matrix can not be represented in a nice
\\( \xi_1 \otimes \xi_2 \\) form. Luckily, the trace operator is linear:  \\(
tr_a (u + v) = tr_a u + tr_a v \\). And since intrinsically 

$$|00\rangle \langle
00 | = (|0\rangle \otimes |0\rangle)(\langle 0 | \otimes \langle 0 |)
= |0\rangle \langle 0| \otimes |0\rangle \langle 0),$$

we can just apply the
linear trace operator to each summand separately. We trace out \\( B \\) to
extract \\( A \\) as follows: 

$$ tr_B \rho_+ = \frac{1}{2} (|0\rangle \langle 0| \cdot tr |0\rangle \langle
0 | + |0\rangle \langle 1| \cdot tr |0\rangle \langle 1| $$ 
$$ \hspace{62px}  + \hspace{30px}| 1\rangle \langle 0 | \cdot tr|1\rangle \langle 0| + |1\rangle \langle 1| \cdot tr |1\rangle \langle
1|)$$ 

And since for two basis vectors \\( i,j \\) the matrix \\( |i\rangle \langle
j | \\) just has a nonzero element in the \\( (i,j) \\) position, the only
nonzero \\( tr |i\rangle \langle j| \\) is when \\( i = j \\). Therefore we can
simplify to get 

$$ tr_B \rho_+ = \frac{1}{2} (|0\rangle \langle 0 | + |1\rangle \langle 1|)
= \frac{1}{2} \mathbb{1}   .$$

Going back to the single-qubit $|\psi\rangle$ state... Considering that its
post-measurement state is either 

$$ |0\rangle \text{ probability } \frac{1}{2},  $$
$$ |1\rangle \text{ probability } \frac{1}{2}.  $$

This means the post-measurement states' density matrix is just the sum of all the pure state density
matrices, scaled by their corresponding probabilities. i.e., 

$$ \rho_\psi = \frac{1}{2} |0\rangle \langle 0 | + \frac{1}{2}|1\rangle
\langle1| = \frac{1}{2}\mathbb{1}. $$


Which is the exact same as \\( tr_B \hspace{3px} \rho_+ \\).  We started with
an entangled pair \\( |\Phi_+\rangle \\). By tracing out the second qubit, we
effectively measured and threw out the result of the one that's left. 

It turns out we can actually use partial traces with von Neumann entropy to quantify *how entangled*
a state is. This is extremely cool. We can actually quantify *how intimate* and
correlated particles are. In my next post, hopefully I'll present some code
than can act as a *quantum entanglement detector* with some cool
visualizations. 


