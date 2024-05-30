---
title : '§ 3. Quantum Circuits'
date : 2024-05-29T18:49:50-07:00
draft : false
description : 'Generating Quantum Circuits using qiskit.QuantumCircuit()'
---

So far we have discussed working with single-qubit and multi-qubit states. We have discussed many different operators and used the `.evolve()` method to apply these operators on statevectors. 

Now it is finally time to start building our own QuantumCircuits that can contain a series of operators. Of course, you could simply generate *one* matrix that is a result of compounding all the matrices via matrix multiplication tensor product. However, generating circuits allows us to visualize the change of information and trace the *evolution* of qubits through a *series* of quantum gates. 

Let's first import all the important tools for working with quantum circuits: 

```python
from qiskit import QuantumCircuit, QuantumRegister, ClassicalRegister
from qiskit.primitives import Sampler
from qiskit.visualization import plot_histogram
```

We build a circuit using the `QuantumCircuit()` method. 

```python
circuit = QuantumCircuit(1) # Quantum Circuit with 1 Qubit

circuit.h(0) # Apply a Hadamard Gate
circuit.s(0) # Apply an S Gate
circuit.h(0) # Apply another Hadamard Gate
circuit.t(0) # Apply a T gate

display(circuit.draw()) # Gates are performed left-to-right
```

![](/58.png)

In Qiskit, the *topmost* qubit in a circuit diagram has index 0 and corresponds to the *rightmost* position in a tuple of qubits. Qiskit's default names for the qubits in an $n$-qubit circuit are represented by the $n$-tuple $(q_{n-1}, \cdots, q_0)$, with $q_0$ being the qubit on top and $q_{n-1}$ on the bottom in quantum circuit diagrams. 

We can also create a 2-qubit gate like so: 

```python
# Generating Identical 2-qubit circuits 
# circuit_default has default q_0, q_1 names
# circuit_named allows us to define the names of the qubit using `QuantumRegister()`

circuit_default = QuantumCircuit(2) # 2 Qubits

circuit_default.h(0) # Hadamard Gate on the topmost qubit
circuit_default.cx(0, 1) # CNOT gate (control, target)

display(circuit_default.draw())

#-----------------------------#

X = QuantumRegister(1, "X")
Y = QuantumRegister(1, "Y")

circuit_named = QuantumCircuit(X, Y)

circuit_named.h(X)
circuit_named.cx(X, Y)

display(circuit_named.draw())
```

![](/59.png)

We have created two identical circuits, one default-named, and the other custom. Both circuits contain a Hadamard Gate on the first qubit and a CNOT gate with the first qubit as the control and the second as the target. 

Let's see the action of the above circuit on the standard computational basis states for a 2-qubit system: 

$$|00\rangle \quad |01\rangle \quad |10\rangle \quad |11\rangle$$

```python
zero = Statevector.from_label("0")
one = Statevector.from_label("1")

standard_basis_states = [zero.tensor(zero), zero.tensor(one), 
                         one.tensor(zero), one.tensor(one)]

names = ["|00>", "|01>", "|10>", "|11>"]

for i in range(len(standard_basis_states)): 
    print(f"{names[i]} -->")
    display(standard_basis_states[i].evolve(circuit_named).draw("latex"))
```

![](/60.png)

The cool thing about the circuit above, as you see, it generates the bell states. (entangled states that form a basis): 

$$|\phi^+\rangle = \frac{1}{\sqrt{2}}|00\rangle + \frac{1}{\sqrt{2}}|11\rangle $$
$$|\phi^-\rangle = \frac{1}{\sqrt{2}}|00\rangle - \frac{1}{\sqrt{2}}|11\rangle $$
$$|\psi^+\rangle = \frac{1}{\sqrt{2}}|01\rangle + \frac{1}{\sqrt{2}}|10\rangle $$
$$|\psi^-\rangle = \frac{1}{\sqrt{2}}|01\rangle - \frac{1}{\sqrt{2}}|10\rangle $$

except the final $|11\rangle$ state becomes the negative of the fourth $|\psi^-\rangle$ bell state. 

So this circuit gives us a way to convert the standard computational basis into the Bell Basis. The -1 phase factor on the last state, $-|\psi^-\rangle$ could be eliminated if we wanted. For instance, we could add a controlled-Z gate at the beginning. (The Z gate performs the bit-flip operation. So a controlled-Z would perform a bit-flip if the first qubit is 1 $\rightarrow$ turning $-|11\rangle$ into $|11\rangle$)

Here is the altered circuit shown: 

```python
circuit = QuantumCircuit(2)

circuit.cz(0, 1)
circuit.h(0)
circuit.cx(0, 1)

circuit.draw()
```


![](/61.png)

Implementing the above circuit on the standard computational basis states: 

```python
for i in range(len(standard_basis_states)):
    print(f"{names[i]} --> ")
    display(standard_basis_states[i].evolve(circuit).draw("latex"))
```

![](/62.png)

which is identical to the Bell Basis! 

In general, quantum circuits can contain any number of qubit wires. We may also include classical bit wires, indicated by **double** lines:

```python
X = QuantumRegister(1, "X")
Y = QuantumRegister(1, "Y")
A = ClassicalRegister(1, "A")
B = ClassicalRegister(1, "B") # Using `Classical Register` to customize the name
                              # for two separate classical bits

circuit = QuantumCircuit(X, Y, A, B)
circuit.h(X)
circuit.cx(X, Y)
circuit.measure(X, A)
circuit.measure(Y, B)

circuit.draw()
```

![](/63.png)

In the above circuit, we have the same Hadamard & CNOT configuration on two qubits. However now we also have two *classical* bits A & B along with two measurement `M` gates. 

The measurement gates represent standard basis measurements (resulting in either $|0\rangle$ or $|1\rangle$ as the eigenvectors/post-measurement states). The measurement gate changes the qubits into their post-measurement states, while the classical measurement outcomes ($0 for |0\rangle$ or 1 for $|1\rangle$) are *overwritten* onto the classical bits to which the arrows point. 

The above circuit can be simulated using the `Sampler()` primitive. 

```python
sampler = Sampler() # Initialize Sampler
job = sampler.run(circuit) 
results = job.result()

statistics = results.quasi_dists[0].binary_probabilities()
plot_histogram(statistics)
```

![](/64.png)

It is not *super* important to understand primitives yet...but for those who are interested, 

The `Sampler()` primitive samples outputs of quantum circuits. It basically runs a simulation on a bunch of statevectors and stores the results. It displays the **exact** measurement probabilities of a circuit if the `Sampler().run(shots = ...)` parameter is unspecified. We use it by calling its `run()` method with the circuit. This results a `BasePrimitiveJob` object, where calling the method `result()` results in output samples and corresponding metadata. (We'll get to this in the future -- if you are confused do not worry, still continue onwards -- you are doing great!). 

It is mainly important to see how the the results show an equal probability for the measurement yielding the *classical* values of 00 and 11. 

### Quantum Circuits Review

Let's play with some qubits and bits in a complicated circuit and plot the resultant probabilities. 

```python
q = QuantumRegister(2, name = 'qubit')
c = ClassicalRegister(2, name = 'bit')

circuit = QuantumCircuit(q, c)

circuit.h(q[0])
circuit.cx(q[0], q[1])      # Note you do not have to specify q[...]
circuit.cz(q[1], q[0])      # I just do it for readability
circuit.h(q[1])
circuit.cz(q[0], q[1])
circuit.measure(q, c)

circuit.draw('mpl')
```

![](/65.png)

```python
sampler = Sampler() # sampler initialization

job = sampler.run(circuit, shots = 128) # sampling 128 runs
results = job.result()

statistics = results.quasi_dists[0].binary_probabilities()
plot_histogram(statistics)
```

![](/66.png)

We see we get roughly an equal 1/4 probabilitiy to yield each computational basis state in its classical form. Let us see this result more closely by performing this circuit on the computational basis states: 

```python
# Generating the same circuit, but without the measurement gates
circuit = QuantumCircuit(2)
circuit.h(0)
circuit.cx(0, 1)      
circuit.cz(1, 0)      
circuit.h(1)
circuit.cz(0, 1)

zero, one = Statevector.from_label("0"), Statevector.from_label("1")

standard_basis_states = [zero.tensor(zero), zero.tensor(one), 
                         one.tensor(zero), one.tensor(one)]
names = ["|00>", "|01>", "|10>", "|11>"]

for i in range(len(standard_basis_states)): 
    print(f"{names[i]} -->")
    display(standard_basis_states[i].evolve(circuit).draw("latex"))
```

![](/67.png)

Here we can clearly see the probabilities for yielding each state is 1/4. 

However, let's apply the circuit on a different, more complicated statevector. 

```python
plus = Statevector.from_label("+")
vec = Statevector([(1 + 2.0j)/3, -2/3])
statevec = plus.tensor(vec)

statevec.draw('latex')
```

![](/68.png)


The post-circuit statevector: 

```python
display(statevec.evolve(circuit).draw('latex'))
```

![](/69.png)

Now the only possible measurement outcomes are either $|00\rangle$ or $|11\rangle$. 

---

## Exercises

> 1. Generate the following circuit using the diagram below. 

![](/70.png)

> 2. Implement the circuit from Problem 1 on the statevector given by $|+-+-\rangle$. What is the resultant statevector? Plot the probability distributions for 4000 samples using `plot_histogram()`.

> 3. Add a measurement gate to all the qubits using the `circuit.measure_all()` method. You should yield the following circuit: 

![](/71.png)

> Afterwards use a sampler primitive to visualize the classical probabilities resulting from this circuit. What are the possible classical results? 

. 

.
 
.

.

.

.

.

.

## Solutions 

#### Problem 1.

```python
from qiskit import QuantumCircuit

circuit = QuantumCircuit(4)

circuit.h(range(4)) # Applying Hadamard on all four Qubits
circuit.cx(2, 3)
circuit.cx(3, 1)
circuit.h(range(3))

circuit.draw()
````

![](/70.png)

#### Problem 2. 

Let's first generate the statevector for $|+-+-\rangle$. To do this I first generate the tensor product $|+\rangle |-\rangle$. I then take its tensor product with itself to yield $|+\rangle|-\rangle|+\rangle|-\rangle = |+-+-\rangle$. 

```python
from qiskit.quantum_info import Statevector

plus = Statevector.from_label('+')
minus = Statevector.from_label('-')

plusminus = plus.tensor(minus) # Generating |+>|->
plusminus_twice = plusminus.tensor(plusminus) # Generating |+>|->|+>|-> = |+-+->

plusminus_twice.draw("latex")
```

![](/72.png)

Applying the circuit from Problem 1, 

```python
plusminus_twice.evolve(circuit).draw('latex')
```

![](/73.png)

We don't *really* need to plot a histogram of the probabilities for each eigenvector -- we can see clearly they are all 1/8th. But let's do it anyways for practice. 

```python
from qiskit.visualization import plot_histogram

results = plusminus_twice.evolve(circuit).sample_counts(4000)
plot_histogram(results)
```

![](/74.png)

From 4000 sample runs we get a rough 500 yields for each state -- a 1/8th probability. 

#### Problem 3

Let's add the measurement gates to the circuit from Problem 1 using `measure_all()`

```python
circuit = QuantumCircuit(4)

circuit.h(range(4)) # Applying Hadamard on all four Qubits
circuit.cx(2, 3)
circuit.cx(3, 1)
circuit.h(range(3))

# ---- same as problem 1 thus far ---- #

circuit.measure_all() # Apply a measurement gate on all four Qubits
                      # Stores the results as classical bits
                      # Notice how we did not specify any classical wire 
                      # Calling .measure() automatically produced appropriate 
                      # classical wires to store the results

circuit.draw()
```

![](/75.png)

Notice the rectangular barrier that was automatically placed to separate the measurement gates from the quantum circuit. This `circuit.barrier()` is used for visualization and aesthetic purposes. 

Let's use the sampler primitive to visualize the probabilities resulting from this circuit. 

```python
from qiskit.primitives import Sampler

sampler = Sampler() # initilialize Sampler
job = sampler.run(circuit, shots = 4000) # 4000 samples
results = job.result()

statistics = results.quasi_dists[0].binary_probabilities()

plot_histogram(statistics)
```

![](/76.png)

[Previous -- Multi-Qubit States](https://dev-undergrad.dev/qiskit/02_multi_qubit/) $\sim$ [Next -- Quantum Entanglement](https://dev-undergrad.dev/qiskit/04_entanglement/)









