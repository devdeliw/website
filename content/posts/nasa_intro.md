+++ 
title = "My project at NASA" 
description = "NASA Introduction" 
tags = ["NASA"]
date = "2025-06-02" 
categories = ["Software", "Physics"] 
menu = "main"
+++

{{< katex />}}

My work revolves around *Electrically Detected Magnetic Resonance*
([EDMR](https://en.wikipedia.org/wiki/Electrically_detected_magnetic_resonance)). It's
a method of detecting small magnetic fields electrically. In principle it's very
simple. 

Say we have a semiconductor, like silicon carbide. This semiconductor, made by
nature or in a lab, is never perfect. There may exist some missing atoms, or extra
atoms, deep in its molecular structure. These *defects* provide some extra
electrons, or extra holes, which can be used for quantum sensing. In EDMR, they
are used to measure magnetic fields electrically. I'll now walk through how this
is done in silicon carbide (4H-SiC) specifically.

## Defects in Silicon Carbide

Let's look at the molecular structure of 4H-SiC. 

<br>

<p align="center">
  <img src="/4h-sic.svg">
</p>


<br>

Ideally, it would be consistently full of silicon and carbon. However, what if 
somewhere there's a missing silicon atom (middle of figure)? This is a common defect, known as the
*Silicon Vacancy*. It's a spin $S=3/2$ defect; how we get 3/2 isn't important.  

## Spin Dependent Recombination

When current flows through a semiconductor, the electrons move through the
*conduction band*, a band of energy a bit higher than the *valence band*, where
the valence electrons of silicon and carbon rest.
The energy level of the defect lies somewhere in between. 

In 4H-SiC, the conduction band is
$\sim$[3.3eV](https://arxiv.org/pdf/2410.06798) higher than the valence band.
If an electron ($S=1/2$) passes over a defect, it can "couple" with it. If an
orbital of the defect and the carrier electron form a *singlet* state, then the
defect can "catch" the carrier electron and trap it at its lower
energy state. *Triplet* states are nearly forbidden; this is spin angular momentum
conservation at work. 

Now the carrier electron has been brought down from the conduction band, which
is the highway for current electrons, to the defect. From here, it can proceed
all the way down to the valence band by recombining with a hole. This process is
known as *Spin-dependent Recombination* (SDR) -- only carrier electrons whose spin
states form a singlet with the defect orbital can undergo recombination and
leave the conduction band. SDR process is illustrated below.

<br>

<p align="center">
  <img src="/sdr.svg">
</p>

<br>

And since magnetic fields modulate spin alignment, they change the rate of recombination,
which reduce the number of electrons in the conduction band -- the amount of
current. If we detect changes in current, we detect changes in the magnetic
field. There are other mechanisms at play besides SDR. Defects also provide a
path for electrons to "hop" through to lower energy levels, escaping
conduction band. This is known as Spin-Dependent Trap-Assisted Tunneling
(SDTAT), and is [detectable by
EDMR](https://doi.org/10.1063/1.5057354).
However, quantum tunneling is much rarer than recombination
events. SDR is considered the [primary mechanism](https://www.nature.com/articles/s41598-024-64595-3) 
for EDMR. 

## The Goal 

My work at NASA will be simulating this entire process, as fast as possible. The
end simulation will take in all experimental parameters, to be explained later,
and spit out an EDMR spectra. This spectra is a plot of magnetic field vs.
current. 

I am told the use-case of this simulation will be to develop an automatic GPS aboard
aircrafts that uses the Earth's magnetic fields. If a pilot's GPS fails, a
simulation could continuously predict EDMR spectra based on the surrounding 
environment. Different locations on Earth have different ambient magnetic
fields, so a makeshift GPS is possible. I don't think this idea is necessarily 
applicable in practice. There are better ways of error-handling a GPS failure. 
However, it's a fun project.

In any case, we may understand spin-physics a bit more. For the
next few posts, I plan to cover the core mechanics of spin-dependent
recombination and then start writing software.  


