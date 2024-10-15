+++
title = 'Moving Universe Lab - Introduction'
date = 2024-03-21T23:36:41-07:00
draft = false
+++



Berkeley's Moving Universe Lab, led by Prof. Jessica Lu @ AC Berkeley focuses
on the study of stars and black holes in the *nearby* universe. 

My research primarily deals with determining the **extinction law** of the
Galactic Center, the region of stars in the center of the milky way near Sagittarius A*. 

## Extinction

Interstellar extinction occurs when light, during its transit between some
emitting astronomical object and earth, gets scattered by intermediary dust and
gas particles. 

As different wavelengths of light scatter differently when encountering the
same interstellar dust and gas, astronomers create *extinction laws* to predict
the amount of extinction as a function of wavelength. 

![](/extinction_law.png)

Shown above is the average extinction law for the MW, LMC2, LMC, and SMC Bar.
The curves are additionally plotted versus $1/\lambda$ to emphasize the UV.

### Red Clump (RC) Method

Of course, there are many ways to try and predict the extinction law of
a star cluster, each with their strengths and weaknesses. 

There is the color-difference (CD) method, where extinction curves are
determined in the form of ratios of color excesses $E_{\lambda - \lambda_1}
/ E_{\lambda_2 - \lambda_1}$ as a function of $\lambda^{-1}$. Here $E_{B-V}$ is
used as a standard normalization. The absolute extinction $A_{K_S}$ is then
derived from the ratios of color excesses. And afterwards we can predict
several other $A_{\lambda}$s via the equation 

$$ \frac{A_{\lambda}}{E_{B-V}} = \frac{E_{\lambda - V}}{E_{B-V}} + R_V $$

where $R_V = \frac{A_V}{E_{B-V}}$, the ratio of total to selective extinction. 

Afterwards the entire extinction curve is extrapolated via some cubic-spline
interpolation after knowing some $A_\lambda$'s. Unfortunately, this
extrapolation has uncertainty due to the contamination of dust emission, and
the possible existence of *neutral extinction* by grains much larger than the
wavelength of observation. 

My research utilizes **Red Clump (RC) stars** to determine the extinction law.
RC stars are the equivalent of horizontal-branch stars for a metal-rich
population. They have narrow distributions in luminosity and color with a weak
dependence on metallicity. They thus occupy a distinct 'bar' in the color-magnitude
diagram (CMD) and can be used as standard candles of equal distance. 

The best part -- the slope of the RC bar on the CMD equals the ratio of total
to selective extinction $R_{\lambda}$. I utilize this property of RC stars to
determine the entire extinction law. This is known as the ***RC Method***,
coined by [Nishiyama et al.(2006)](https://iopscience.iop.org/article/10.1086/499038/pdf). 

![](/NRCB1_NRCB4_CMDs.png)

Above I plot the CMDs of stars in the Galactic Center between the 1.15µm and
2.12µm wavelengths. The linear 'streak' of stars that is shown above the
main-sequence track is the RC bar. The slope of the RC bar is the
ratio of total to selective extinction. 


