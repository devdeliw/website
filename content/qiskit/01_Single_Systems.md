---
title: '§ 1. Single Qubit'
date: 2024-05-28T21:08:06-07:00
description: 'Understanding the Statevector Class & Single-Qubit Operations'
draft: false
---

## Preliminary Info

This tutorial series assumes you are already knowledgable of basic quantum
mechanics, statistics, linear algebra, and python. This is for people who want to focus
on directly learning IBM Qiskit, the python library, and not so much the math behind Quantum
Computing, although some math will be necessary. For learning the math along
with Qiskit, visit IBM's [Qiskit Textbook](https://learning.quantum.ibm.com).

If you do not know the math yet...**do not use this tutorial**.
Understanding the math is essential for understanding how the code works. 

I provide lessons covering the same rough topics as IBM's textbook with
exercises at the end. To fully master Qiskit, it is important to play and mess around with
Qiskit yourself at the end of each lesson, so you get a better grasp before
starting the next lesson. 

For any typos, issues, or suggestions on this tutorial, please fork to the `website` repo (.md files under `/content/qiskit/`), or
[email me](mailto:devaldeliwala@berkeley.edu). Thanks! 

___

To begin learning Qiskit, the software used to work with quantum circuits, we
need to understand how to define and work with qubits. 

### States, Measurements, & Operations
#### Defining Qubit Statevectors

The `Statevector` class provides functionality for defining and manipulating
quantum statevectors (or wave functions, if you are a physicist like me). 

Below I import the `Statevector` class from `qiskit.quantum_info` and generate three statevectors `u`, `v`and `w`. 



```python
from qiskit.quantum_info import Statevector
import numpy as np
from numpy import sqrt

u = Statevector([1/sqrt(2), 1/sqrt(2)])
v = Statevector([(1 + 2.0j)/3, -2/3])
w = Statevector([1/3, 2/3])
```

The `Statevector` class also provides a `draw()` method for displaying statevectors in $\LaTeX$ format (or just plain text if you want). 

```python
display(u.draw('latex'))
display(v.draw('latex'))
```

![](/screenshot1.png)

The `Statevector` class by default uses the computational basis. {$\{|0\rangle,
|1\rangle\}$}. We can check if these statevectors are valid using the `is_valid` method. 

```python
print(f"Statevector u is valid? {u.is_valid()}")
print(f"Statevector w is valid? {w.is_valid()}")
```
![](/screenshot.png)

Remember, as the norm of components squared $|c_i|^2$ of the statevector represent the probabilities to yield the eigenvalue for the basis we define the statevectors in -- the probabilities $|c_i|^2$ for each eigenvalue must sum to one: $$\sum_i |c_i|^2 = 1 $$ To put it simply, **the Euclidean norm must equal 1.**

#### Simulating Measurements

Using the `measure()` method is one way to measure statevectors in Qiskit. 

```python
# creating qubit wave function & displaying it
v = Statevector([(1 + 2.0j)/3, -2/3])
display(v.draw("latex"))

# measuring
v.measure()
```

![](/screenshot2.png)

Note that as the result of measurements is probabilistic, measuring the above
statevector could yield different results. 

Upon measurement, the qubit collapses into either $|0\rangle$ or $|1\rangle$,
since we have been using the computational basis {$\{ |0\rangle, |1\rangle \}$}
to define our statevectors thus far.

`v.measure()` returns a `tuple` which stores info on the eigenvalue measured, the collapsed wave function, and the dimension of the wave function.

```python
v.measure()[0] # measured eigenvalue
v.measure()[1] # collapsed resultant wave function 
```

If we run many iterations of `v.measure()` we should yield a graph that comes close to the intrinsic probabilities of each eigenvalue.

```python
import matplotlib.pyplot as plt

results = np.empty([0])

num_runs = 1000

for i in range(num_runs): 
    results = np.append(results, v.measure()[0]) # storing resulting eigenvalues

num_0 = len(np.where(results == '0')[0]) # # measurements yielding 0
num_1 = len(np.where(results == '1')[0]) # # measurements yielding 1 

fig, axis = plt.subplots(1, 1, figsize = (5, 5))
plt.hist(results) 
plt.title(f"Results from measuring {num_runs} times")
plt.ylabel("Count")

print("{:>3} | {:>3}".format("# 0", "# 1"))
print("{:>3} | {:>3}".format(num_0, num_1))
```
![](/screenshot3.png)

Qiskit provides a way to visualize probabilities in a much *simpler* and *direct* way using the `plot_histogram()` method in `qiskit.visualization`.

```python
from qiskit.visualization import plot_histogram

statistics = v.sample_counts(1000) # directly make 1000 measurements 
                                   # and store results in `statistics`
print(statistics) 
plot_histogram(statistics, figsize = (5, 5)) # makes histogram directly
```

![](/screenshot4.png)

We see the results are almost identical. If we took an infinite number of measurements and collected all the results, we would see the probabilities match with what is predicted from the statevector. 

By now you should start to feel that Qiskit is just plain and simple python. Of course, it is known Qiskit is just a python library, however for many it seems like an entire new language. One just has to understand how *to work* with all the features of Qiskit *within* python. The first step is understanding all the quantum gates/operators. 

---

### Single-Qubit Quantum Gates / Operators

We start with the Pauli Operators that are used when measuring spins of elementary particles. Spin is one of the ways qubits are defined in real-life. (spin up $|\uparrow\rangle$ could mean $|0\rangle$ and spin down $|\downarrow\rangle$ could mean $|1\rangle$).

#### Pauli $X$ (NOT) Operator

The simplest logic gate is the Pauli-$X$ / NOT operator. It inverts a value of a qubit from $0\rightarrow 1$ or $1\rightarrow0$, assuming we are in the computational basis. Its matrix representation is accordingly, 

![](/screenshot5.png)


We can see its action on the following statevector $|0\rangle = v= \left(1 \atop 0\right)$

```python
from qiskit.quantum_info import Operator

X = Operator([[0, 1], [1, 0]]) # Pauli X Operator

v_initial = Statevector([1, 0]) # Statevector

print("Starting Statevector:")
display(v_initial.draw("latex"))

v_final = v_initial.evolve(X) # applies X on v_i

print("Post Pauli-X Operator:")
display(v_final.draw("latex"))
```

![](/screenshot6.png)

If we apply two $X$-gates in succession, we see the qubit flip back to its
original state $|0\rangle$. 

```python
v_intermediate = v_initial.evolve(X)
v_final = v_intermediate.evolve(X)

print("Starting statevector:") 
display(v_initial.draw("latex"))

print("Post 1 Pauli-X Operator:") 
display(v_intermediate.draw("latex"))

print("Post 2 Pauli-X Operators:")
display(v_final.draw("latex"))
```

![](/screenshot7.png)

Let's introduce the other 2 Pauli Operators (besides the identity matrix --
which you already know).

#### Pauli $Y$ Operator 

![](/screenshot8.png)

#### Pauli $Z$ Operator

![](/screenshot9.png)

While not important right now, just like how we saw previously the $X$ gate performs the "bit-flip" operation,

The $Z$ gate performs a "phase-flip" operation: $$ Z|0\rangle = |0\rangle \qquad Z|1\rangle = -|1\rangle $$

The $Y$ gate performs both a bit-flip and a phase-flip. Phase operations are any operation described by the matrix

![](/screenshot10.png)

(i.e. they leave the $|0\rangle$ constant and tack on a phase to the
$|1\rangle$ component). The $Z$ operator is the case of $P_\pi$. There are also
some other operators important enough to have a name: 

#### Hadamard Operator

![](/screenshot11.png)

The Hadamard Gates puts the standard basis states {\\( |0\rangle, |1\rangle \\)} into a superposition. 

![](/s12.png)

Performing the same operations instead on $|+\rangle$ and $|-\rangle$, $$ H|+\rangle = |0\rangle $$ $$ H|-\rangle = |1\rangle $$

Since both $ |+\rangle $ and $ |-\rangle $ carry the same probability distributions for measuring 0 or 1, measuring either $|+\rangle$ or $|-\rangle$ provides no information on what the initial state actually was. But by performing the $H$ gate like you see above, we obtain 0 with certainty that the initial state was $|+\rangle$ and we obtain 1 with certainty that the initial state was $|-\rangle$.

#### T Gate

The T gate is the equivalent to a $P_{\pi/4}$ phase operation. That is, 

![](/14.png)

---

### Quantum Gates Review

Let's define a quantum circuit using `qiskit.QuantumCircuit()` and implement
some gates we've discussed on $|0\rangle$. We will fully discuss the `QuantumCircuit()` method
soon. 

```python 
from qiskit import QuantumCircuit 

circuit = QuantumCircuit(1) # initialize circuit with 1 qubit

circuit.x(0)
circuit.y(0) 
circuit.z(0) 

circuit.draw()
```
![](/15.png) 

You can also display the circuit more colorfully using the `output = 'mpl'` parameter: 

```python
circuit.draw('mpl')
```

![](/16.png) 

```python
ket0 = Statevector([1, 0])

v = ket0.evolve(circuit) # Apply the circuit above on the |0> statevector
                         # Note the operations are applied sequentially
                         # left-to-right

print("The initial vector:") 
display(ket0.draw("latex"))

print("The resultant vector:")
display(v.draw("latex"))
```

![](/17.png) 

Let's apply the Hadamard Gate $H$ on $|0\rangle$. 

For the following code segments, predict first what the output will be based on information about the gates provided above.

```python
circuit = QuantumCircuit(1) 

circuit.h(0) 
circuit.draw()
```

![](/19.png) 

```python
v = ket0.evolve(circuit) 
v.draw("latex")
```

![](/20.png) 

Applying the Hadamard Gate on `v` = $|+\rangle$ (same as applying two Hadamard Gates on `ket0` = $|0\rangle$: 

```python
w = v.evolve(circuit) # Applying the same circuit on v 
                      # (a second hadamard gate on |0>)
w.draw("latex")
```

![](/21.png) 

We get back the original statevector $|0\rangle$. 

Now let's build some random circuit with a bunch of gates and apply it on
$|0\rangle$. 

```python
circuit = QuantumCircuit(1)

circuit.h(0)
circuit.t(0)
circuit.h(0)
circuit.t(0)
circuit.z(0) 

circuit.draw()
```

![](/22.png) 

```python
ket0 = Statevector([1, 0])
v = ket0.evolve(circuit)

v.draw("latex")
```

![](/23.png) 

We get a very ugly statevector. Perhaps seeing its probability distribution
will help. 

```python
statistics = v.sample_counts(4000)
plot_histogram(statistics)
```

![](/24.png)

---

## Exercises

> 1. Plot the probability distribution from measuring the $|+\rangle$ and
   $|-\rangle$ statevectors. 
   
> 2. Perform a Hadamard Gate on $|0\rangle$ twice. What is the final statevector? 
   
> 3. Perform a Phase $P_\frac{\pi}{3}$ operation on $|1\rangle$. What is the final
   statevector? 
  
  .
  
  .
  
  .
  
  .
  
  .
  
  .
  
  .
  
  .
  
## Solutions 

First attempt the problems! 

#### Problem 1. 

```python
from qiskit.quantum_info import Statevector
from qiskit import QuantumCircuit

# We can generate the plus and minus vectors via two different ways. 
# 1. Implementing an H gate on the |0> and |1> vectors, respectively
# 2. Calling directly from Statevector.from_label("+") and .from_label("-") 

# Method 1 ---------------
ket0 = Statevector([1, 0]) # We could also say ket0 = Statevector.from_label("0")
ket1 = Statevector([0, 1]) 

circuit_with_a_hadamard_gate = QuantumCircuit(1)
circuit_with_a_hadamard_gate.h(0)
circuit_with_a_hadamard_gate.draw()
```

![](/25.png) 

```python
plus = ket0.evolve(circuit_with_a_hadamard_gate)
minus = ket1.evolve(circuit_with_a_hadamard_gate)

display(plus.draw("latex"))
display(minus.draw("latex"))
```

![](/26.png) 

```python
# Method 2 -----------------------
plus = Statevector.from_label("+")
minus = Statevector.from_label("-")

display(plus.draw("latex"))
display(minus.draw("latex"))
```


![](/27.png) 

```python
from qiskit.visualization import plot_histogram

plus_stats = plus.sample_counts(1000)
minus_stats = minus.sample_counts(1000)

print("|+>")
display(plot_histogram(plus_stats))

print("|->")
display(plot_histogram(minus_stats))
```

![](/28.png) 
  
 We see the probabilities for measuring 0 and 1i are roughly equal for both $|+\rangle$ and
 $|-\rangle$ -- as they should be.
 
 #### Problem 2. 
 
 Let's define a `QuantumCircuit` with one Hadamard Gate. This way we do not
 have to define the Hadamard matrix with the `Operator()` method. Though that
 still works. 
 
 ```python
from qiskit.quantum_info import Statevector
from qiskit import QuantumCircuit

circuit = QuantumCircuit(1)

circuit.h(0)

circuit.draw()
```

![](/29.png) 

```python
ket0 = Statevector([1, 0]) # or you could call ket0 = Statevector.from_label("0")
ket0.draw('latex')
```
![](/30.png) 

Let's implement the circuit *once* (one Hadamard gate) on $|0\rangle$ and see the result. 

```python
display(ket0.evolve(circuit).draw("latex"))
```

![](/31.png) 

We get the $|+\rangle$ as expected. Now let's run this new statevector back through the circuit. (This is the same as applying a Hadamard gate twice on $|0\rangle$).

```python
plus = ket0.evolve(circuit)

display(plus.evolve(circuit).draw("latex"))
```

![](/32.png)

We see that applying two Hadamard gates to the $|0\rangle$ statevector re-yields $|0\rangle$.

#### Problem 3. 

Recall that a *Phase* operation is given by 

![](/33.png)

Therefore, $P_{\pi/3}$ 

![](/34.png) 

Let's define this operator in Qiskit and see its effect on $|1\rangle$. 

```python
from qiskit.quantum_info import Operator
import math

ket1 = Statevector([0, 1]) # or you could call Statevector.from_label("1")
PhasePi3 = Operator([[1, 0], [0, math.cos(math.pi / 3) + 1j * math.sin(math.pi / 3)]]) # using Euler's formula

display(ket1.evolve(PhasePi3).draw("latex"))
```

![](/35.png) 

[Next](https://dev-undergrad.dev/qiskit/02_multi_qubit/)





