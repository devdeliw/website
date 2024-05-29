---
title : '§ 2. Multiple Qubits'
date : 2024-05-29T11:59:11-07:00
draft : False
description : 'Working with Multi-Qubit Quantum Gates'
---

## Multi-Qubit Quantum Gates / Operators

Now that we know how to work with single-qubit gates, we can move on to multi-qubit operators which act on more than one qubit/statevector. 

Remember a multi-qubit state $$|XY\rangle$$ is the tensor product

$$ |XY\rangle = |X\rangle \otimes |Y\rangle = |X\rangle|Y\rangle$$

Let's discuss the important Quantum Gates that deal with Multi-Qubit states.

---

### SWAP 
$$ \text{SWAP} |a\rangle |b\rangle = |b\rangle |a\rangle $$

It's matrix representation 

![](/57.png)

### Controlled Operations

A controlled $U$ operator performs an action on a **target** qubit depending on the state of a **control** qubit. 

When dealing with the computational basis of $|0\rangle$ and $|1\rangle$ that defines each statevector, a controlled $U$ operation takes the form 

$$ CU = |0\rangle \langle 0| \otimes I_R + |1\rangle\langle 1| \otimes U $$

To make this idea clearer, let's discuss the CNOT gate. 

#### CX / CNOT

The action of a CNOT gate flips the target qubit if the control qubit is in the state $|1\rangle$ and leaves the target qubit alone if the control qubit is $|0\rangle$. To put it cleanly, 

![](/37.png)

It leaves the control qubit alone regardless. In matrix representation 

![](/38.png)


Controlled-Operations can be performed on both single and multi-qubit states. The control or target could be a system of qubits. For example the CCNOT (controlled-controlled NOT) gate, also known as the Toffoli Gate -- a CNOT gate with *2* control qubits and *1* target qubit. That is, the target qubit gets inverted if and only if *both* control qubits are in the state $|1\rangle$. 

Now it is time to discuss how to generate multi-qubit states. We already learned how to generate single-qubit states using the `Statevector` class in the previous lesson. To generate a multi-qubit state we have to understand how to perform tensor products. 

---

### Tensor Products

Let's create the multi-qubit statevector $|01\rangle$ as a tensor product from $|0\rangle \otimes |1\rangle$. 

```python
zero, one = Statevector.from_label("0"), Statevector.from_label("1")
zero.tensor(one).draw("latex")
```

![](/40.png)


Let's create the vectors representing the states $|+\rangle$ and $\frac{1}{\sqrt{2}}(|0\rangle + i|1\rangle)$ states and combine them to form a new state vector $|\psi\rangle$. 

```python
plus = Statevector.from_label("+")
i_state = Statevector([1/sqrt(2), 1j/sqrt(2)])

psi = plus.tensor(i_state)
psi.draw("latex")
```

![](/42.png)

We can also take the tensor product of *operators*. The tensor product $C$ of the operators $C = X \otimes Y$ is an operator that can act on simultaneously on the 2 qubit system that is equivalent  to applying $X$ on the first qubit and $Y$ on the second and taking the tensor product after. 

To put it cleanly, the following circuit: 

```python
circuit = QuantumCircuit(2)

circuit.x(0)
circuit.y(1) 
display(circuit.draw())
```

![](/43.png)


is the same as applying the $C = X \otimes Y$ gate on the tensor product `q_0` $\otimes$ `q_1`.  

We can generate tensor products between *operators* in the same way as with statevectors: 

```python
X = Operator([[0, 1], [1, 0]])
Y = Operator([[0, -1j], [1j, 0]])

C = X.tensor(Y)
print(C)
```

![](/44.png)

Let's show that applying $X$ on qubit $|0\rangle$ and $Y$ on qubit $|1\rangle$ is the same as applying $C = X \otimes Y$ to $|01\rangle = |0\rangle \otimes |1\rangle$. 

```python
ket0 = Statevector([1, 0])
ket1 = Statevector([0, 1])
ket_combined = ket0.tensor(ket1)

# individually applying X and Y to |0> and |1> separately
ket0f = ket0.evolve(X)
ket1f = ket1.evolve(Y)
ket_combinedf = ket0f.tensor(ket1f) 

print("X|0> ⊗ Y|1> ")
display(ket_combinedf.draw("latex"))

# applying combined operator to both, 
# redefining ket_combinedf using ket_combined 
ket_combinedf = ket_combined.evolve(X ^ Y) # X ^ Y = X ⊗ Y = C

print("(X ⊗ Y)|01>")
display(ket_combinedf.draw("latex"))
```

![](/45.png)

They're the same! Let's go back to the $|\psi\rangle$ vector we defined earlier, 

```python
psi.draw("latex")
```

![](/47.png)


Let's create a CNOT operator and calculate CNOT $|\psi\rangle$, or $CX|\psi\rangle$

```python
CX = Operator(
    [
        [1, 0, 0, 0], 
        [0, 1, 0, 0], 
        [0, 0, 0, 1],
        [0, 0, 1, 0], 
    ]
)

psi.evolve(CX).draw("latex")
```

![](/49.png)

Compare the coefficients of the $|10\rangle$ and $|11\rangle$ states. 

Now that we have some understanding on how to implement operators on multi-qubit states, let's move to how to implement *partial measurements* on individual qubits of multi-qubit state.

---

### Partial Measurements

In the previous chapter, we used the `measure` method to simulate a measurement of a quantum statevector. This method returned the measured eigenvalue, and the resultant collapsed statevector post-measurement. 

By default, `measure` measures all qubits in the statevector, but we can provide a list of integers to *only* measure the qubits *at* those indices. To demonstrate, the cell below creates the state 

$$ W = \frac{1}{\sqrt{3}} ( |001\rangle + |010\rangle + |100\rangle). $$

```python
W = Statevector([0, 1, 1, 0, 1, 0, 0, 0] / sqrt(3))
W.draw("latex")
```
![](/50.png)

If you are confused how the above state was generated using `Statevector()` -- each parameter indicy of 0 or 1 indicates which of the possible 3-qubit states we define: 

- $|000\rangle$ (index 0)
- $|001\rangle$ (index 1)
- $|010\rangle$ (index 2)
- $|011\rangle$ (index 3)
- $|100\rangle$ (index 4)
- $\vdots$ $\vdots$

As you can see, where each of these indices have a 1, defines which 3-qubits state we have. The above statevector $W$ has a 1 in index 1, 2, and 4. 

Let's simulate a measurement on the **rightmost** qubit (which has index 0) -- the opposite of normal convention (I don't know why, but there's probably a reason). 

```python
eigenvalue, new_statevector = W.measure([0]) # measure qubit 0

print(f"Measured: {eigenvalue}\nState after measurement:")
new_statevector.draw("latex")
```

![](/51.png)

Run the above cell a few times to see different results. Notice that measuring a `1` means we know both the other qubits are $|0\rangle$, but measuring a `0` means the remaining two qubits are in the state $$ \frac{1}{\sqrt{2}}(|01\rangle + |10\rangle). $$

The next lesson -- on `QuantumCircuit()` -- will allow us to fully manipulate and work with any `n`-qubit state. Before moving on, attempt the following exercises to ensure you understand how to generate and measure multi-qubit states. 

---

## Exercises

> 1. Generate the tensor product $|+\rangle |-\rangle$ and implement a CNOT gate on the result. The CNOT gate should have the first, left-most qubit as the control. 

> 2. Generate the tensor product operator $U$ between the Pauli-$X$ and Pauli-$Y$ operators ($U = X \otimes Y$). Show that applying $U |+\rangle |-\rangle$ yields the same result as $X|+\rangle \otimes Y|-\rangle$.

. 

.

.

.

.

.

## Solutions 

#### Problem 1. 

Let's first generate the $|+\rangle |-\rangle$ statevector.

```python
from qiskit.quantum_info import Statevector, Operator

plus = Statevector.from_label("+")
minus = Statevector.from_label("-")

plusminus = plus.tensor(minus) # Generating |+>|->
plusminus.draw('latex')
```

![](/52.png)

Let's build the CNOT matrix and apply it on $|+\rangle |-\rangle$. 

```python
CNOT = Operator(
    [ 
        [1, 0, 0, 0], 
        [0, 1, 0, 0], 
        [0, 0, 0, 1], 
        [0, 0, 1, 0]
    ]
)

plusminus.evolve(CNOT).draw("latex")
```

![](/53.png)

We see that the coefficients in front of the $|10\rangle$ and $|11\rangle$ switched. (The $|11\rangle$ state became $|10\rangle$ and vice versa). 

I present a second method using `qiskit.QuantumCircuit()`. We have not fully discussed QuantumCircuit yet, so consider this a sneak peek. 

```python
from qiskit import QuantumCircuit # We have not done fully introduced QuantumCircuits yet
                                  # You can consider this a sneak-peek

circuit = QuantumCircuit(2)

circuit.cx(1, 0) # CNOT gate with the left-most (index 1) qubit as the control

display(circuit.draw())

plusminus = Statevector.from_label("+").tensor(Statevector.from_label("-")) # Generating |+>|->
plusminus.evolve(circuit).draw('latex')
```

![](/54.png)

#### Problem 2. 

Let's first create the Pauli-$X$ and Pauli-$Y$ operators as well as the operator $U = X\otimes Y.$

```python
from qiskit.quantum_info import Operator

X = Operator(
    [
        [0, 1], 
        [1, 0]
    ]
)

Y = Operator(
    [
        [0, -1j], 
        [1j, 0]
    ]
)

U = X.tensor(Y) 
U.draw("latex")
```

![](/55.png)

Now let's generate the $|+\rangle$ and $|-\rangle$ states, along with their tensor product $|+\rangle |-\rangle$ and get the results of each operation from the question. 

```python
plus = Statevector.from_label('+')
minus = Statevector.from_label('-')

plusminus = plus.tensor(minus)


#Implementing U|+>|-> 
print("U|+>|->")
display(plusminus.evolve(U).draw('latex'))

# Implementing X|+> ⊗ Y|->
print("X|+> ⊗ Y|->")
display(plus.evolve(X).tensor(minus.evolve(Y)).draw('latex'))
```

![](/56.png)


[Previous](https://dev-undergrad.dev/qiskit/01_single_systems/)  
[Next](https://dev-undergrad.dev/qiskit/03_quantum_circuits/)






















