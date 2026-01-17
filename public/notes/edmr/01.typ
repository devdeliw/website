= Simulating EDMR

My work revolves around *Electrically Detected Magnetic Resonance*
(#link("https://en.wikipedia.org/wiki/Electrically_detected_magnetic_resonance")[EDMR]), 
which is a method to detect small magnetic fields electrically. 

A semiconductor, made by
nature or in a lab, is never perfect. There may exist some missing atoms, or extra
atoms, deep in its molecular structure. These *defects* provide some extra
electrons, or extra holes, which can be used for quantum sensing. In EDMR, they
are used to measure magnetic fields electrically. 


== Defects in Silicon Carbide

Let's look at the molecular structure of 4H-Silicon Carbide.

#align(center)[
  #image("/nasa_edmr_sim/4h-sic.svg")
]

Ideally, it's consistently full of silicon and carbon. However, 
sometimes there are missing silicon atoms (middle of figure). This is a common defect, known as the
*Silicon Vacancy*. It's a spin $S = 3/2$ defect.

== Energy Levels

When current flows through a semiconductor, the carrier electrons move through the
*conduction band*, a band of energy a bit higher than where
the valence electrons of silicon and carbon rest. The energy level of the defect
lies in between.

In 4H-SiC, the conduction band is
[#link("https://arxiv.org/pdf/2410.06798")[[$~ 3.3 "eV"$]]] higher than the valence band.
If an electron ($S = 1/2$) in the conduction band passes over a defect, the
defect _can trap it_ at its lower energy state.

== Recombination

Now the carrier electron is at the defect energy level, below the
conduction band. It's possible for it to travel further below to the valence band. 

Electron spin is an angular momentum. If an electron were to travel to the
valence band then it would occupy a hole. This final state would have spin $S = 0$.
By angular momentum conservation, the defect-electron state before must have spin
$S = 0$ too.

For two particles (defect + electron), this is the *singlet state*, when
both spins are antiparallel. A carrier electron can only undergo *recombination*
if it forms a singlet state with the defect. If the carrier electron forms a *triplet state*,
($S = 1$), it immediately returns back up to the conduction band.

This is known as *Spin-Dependent Recombination* (SDR), illustrated below.

#align(center)[
  #image("/nasa_edmr_sim/sdr.svg")
]

== Current

When an electron undergoes recombination, it fully leaves the conduction
band. Therefore, current decreases.

And since #link("https://en.wikipedia.org/wiki/Zeeman_effect")[magnetic fields alter spin
alignment] (Zeeman precession),
they change the rate of recombination, so they change current.

If we detect changes in current, we detect changes in the magnetic field. This is EDMR.

There are other mechanisms at play besides recombination though. Defects also provide a
intermediary path for electrons to "hop" through to lower energy levels. This also lets
them escape the conduction band, changing current.
This is known as Spin-Dependent Trap-Assisted Tunneling
(SDTAT), and is #link("https://doi.org/10.1063/1.5057354")[detectable by
EDMR].
However, an electron quantum tunneling
is rarer than undergoing recombination, so
recombination is the #link("https://www.nature.com/articles/s41598-024-64595-3")[primary mechanism]
for EDMR.

== The Goal

My work will be simulating this entire process, as fast as possible.
The final simulation will take in all experimental parameters, to be explained later,
and spit out an EDMR spectra. This spectra is a plot of magnetic field vs.
current.

I am told the use-case of this simulation will be to develop an automatic GPS aboard
aircrafts that uses the Earth's magnetic field. If a pilot's GPS fails, a
simulation could continuously predict EDMR spectra based on the surrounding
environment. Different locations on Earth have different ambient magnetic
fields, so a makeshift GPS is possible. I don't think this idea is necessarily
applicable in practice. There are better ways of error-handling a GPS failure.
However, it's a fun project.

In any case, we may understand spin-physics a bit more. This post was
a bit abstracted. For the next few posts, I plan to cover the core physics
of spin-dependent recombination and then start writing software to simulate it.

