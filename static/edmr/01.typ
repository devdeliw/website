#set page(width: 8.5in, height: 16in)
#show link: set text(fill: rgb("#005ad9"))

== Simulating Electrically-Detected Magnetic Resonance
Deval Deliwala

Electrically Detected Magnetic Resonance
(#link("https://en.wikipedia.org/wiki/Electrically_detected_magnetic_resonance")[EDMR])
is a method for detecting magnetic fields by measuring changes in electrical current.

=== Spin Defects in Silicon Carbide

Silicon carbide is a crystalline semiconductor composed of silicon and carbon.
In practice, the crystal is never perfect.

#box(
  fill: luma(250),
  inset: 10pt,
  width: 100%,
  [
    #align(center)[
      #image("/nasa_edmr_sim/4h-sic.svg", width: 50%)
    ]
  ],
)

Missing atoms create defects in the lattice. A common example in 4H-Silicon
Carbide is the silicon vacancy. This defect hosts an unpaired electronic spin
with $S = 3/2$.

=== Energy Levels

Electrical current flows when electrons occupy the _conduction band_.
The valence band lies at lower energy and is normally filled. 
Defects introduce energy levels between these bands.
In 4H-SiC, the energy gap between the valence and conduction bands is
#link("https://arxiv.org/pdf/2410.06798")[$~ 3.3 "eV"$].
An electron $(S = 1/2)$ traveling through the conduction band can be captured by
a defect and occupy its lower-energy state.

=== Recombination

After capture, the electron may transition into the valence band by filling a
hole. The resulting state has total spin $S = 0$.

Angular momentum conservation requires spin to be conserved.
The combined defect–electron system must therefore also 
have total spin $S = 0$ _before recombination_ occurs.
For two spins (electron and defect), this configuration is the _singlet_ state $|00 chevron.r$, where
the spins are antiparallel. If the system is in a _triplet_ state $(S = 1)$,
recombination is forbidden and the electron returns to the conduction band.

This selective process is called spin-dependent recombination (SDR).

#box(
  fill: luma(250),
  inset: 10pt,
  width: 100%,
  [
    #align(center)[
      #image("/nasa_edmr_sim/sdr.svg", width: 50%)
    ]
  ],
)

=== Current

Each recombination event removes an electron from the conduction band.
As recombination increases, electrical current decreases.

#link("https://en.wikipedia.org/wiki/Zeeman_effect")[Magnetic fields affect spin alignment]
through Zeeman precession. By changing spin alignment, they change the fraction
of singlet and triplet states. This changes the recombination rate and therefore
the current. EDMR detects magnetic fields by monitoring these current changes.

Defects can also provide a secondary pathway. Electrons may tunnel through defect
states into lower-energy bands. This mechanism is called spin-dependent
trap-assisted tunneling (SDTAT) and is
#link("https://doi.org/10.1063/1.5057354")[observable with EDMR].
Tunneling is typically less frequent than recombination, which is often the
#link("https://www.nature.com/articles/s41598-024-64595-3")[dominant contribution].

=== The Goal

My work simulates these spin-dependent processes as efficiently as possible.
Given experimental parameters, the simulation produces an EDMR spectrum: current
as a function of magnetic field.

One proposed application is navigation. The Earth’s magnetic field varies with
location. If a conventional GPS signal is unavailable, a sensor could measure
the local magnetic field using EDMR and compare it to simulated spectra to infer
position. I don't think this is practical though. Regardless, the simulation allows direct comparison between theory and experiment and helps clarify the underlying
spin physics.

This post was abstracted and focused on intuition. The next posts will introduce the
mathematical model of spin-dependent recombination and then the software I wrote to
simulate it.

