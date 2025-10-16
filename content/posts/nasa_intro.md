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
a method to detect small magnetic fields electrically. In principle it's very
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

Ideally, it's consistently full of silicon and carbon. However, what if 
somewhere there's a missing silicon atom (middle of figure)? This is a common defect, known as the
*Silicon Vacancy*. It's a spin $S=3/2$ defect; how we get 3/2 isn't important.  

## Energy Levels

When current flows through a semiconductor, the carrier electrons move through the
*conduction band*, a band of energy a bit higher than where
the valence electrons of silicon and carbon rest. The energy level of the defect 
lies somewhere in between. 

In 4H-SiC, the conduction band is
[$\sim$3.3eV](https://arxiv.org/pdf/2410.06798) higher than the valence band.
If an electron ($S=1/2$) in the conduction band passes over a defect, the
defect can trap it at its lower energy state. 

## Recombination 
Now the carrier electron is at the defect energy level, a bit below the
conduction band. When can it travel all the way down to the valence band? 

Electron spin is an angular momentum. If an electron were to travel to the
valence band then it would occupy a hole. This final state would have spin $S=0$. 
By angular momentum conservation, the defect-electron state before must have spin
$S=0$ too. 

For two particles (defect + electron), this is the *singlet state*, when
both spins are antiparallel. A carrier electron can only undergo *recombination*
if it forms a singlet state with the defect. If the carrier electron forms a *triplet state*, 
($S = 1$), it immediately returns back up to the conduction band. 

This is known as *Spin-Dependent Recombination* (SDR), illustrated below. 


<br>

<p align="center">
  <img src="/sdr.svg">
</p>

<br>

## Current

When an electron undergoes recombination, it fully leaves the conduction
band. Therefore, current decreases.  

And since [magnetic fields alter spin
alignment](https://en.wikipedia.org/wiki/Zeeman_effect) (Zeeman precession), 
they change the rate of recombination, so they change current.


If we detect changes in current, we detect changes in the magnetic field. This is EDMR. 

There are other mechanisms at play besides recombination though. Defects also provide a
intermediary path for electrons to "hop" through to lower energy levels. This also lets
them escape the conduction band, changing current. 
This is known as Spin-Dependent Trap-Assisted Tunneling
(SDTAT), and is [detectable by
EDMR](https://doi.org/10.1063/1.5057354).
However, an electron quantum tunneling 
is rarer than undergoing recombination, so 
recombination is the [primary mechanism](https://www.nature.com/articles/s41598-024-64595-3) 
for EDMR. 

## The Goal 

My [work at NASA](/nasa_ppt.pdf) will be simulating this entire process, as fast as possible. 
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


