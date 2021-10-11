# CircaPower
Github repository for circadian power calculation (CircaPower)


## Install This Package from github
* In R console

```{R}
library(devtools)
install_github("https://github.com/circaPower/CircaPower") 
```

## Citation

* Wei Zong, Marianne L. Seney, Kyle D. Ketchesin, Michael T. Gorczyca, Andrew C. Liu, Karyn A. Esser, George C. Tseng*, Colleen A. McClung* and Zhiguang Huo*. Experimental Design and Power Calculation in Omics Circadian Rhythmicity Detection. (Submitted, *: co-coresponding authors)

* The manuscript can be found here: (to be updated)

## Full tutorial (to be updated)

* Circadian power calculation (active design) when the circadian time are evenly spaced.
* A case study how to perform circadian power calculation using mouse skeletal muscle pilot data
* Circadian power calculation given irregular circadian time distribuiton.

http://htmlpreview.github.io/?https://github.com/Caleb-Huo/AWFisher/blob/master/vignettes/AWFisher.html


## Short tutorial 

* Sinusoid assumption: 
  * ![formula](https://render.githubusercontent.com/render/math?math=\color{white}\large\y=A\sin(w(t%2B\phi))%2B\M%2B\varepsilon)
  * ![formula](https://render.githubusercontent.com/render/math?math=\color{white}\large\varepsilon\sim\N(0,\sigma^2))
  * ![formula](https://render.githubusercontent.com/render/math?math=\color{white}\large\A): Amplitude
  * ![formula](https://render.githubusercontent.com/render/math?math=\color{white}\large\varepsilon): Noise level
  * ![formula](https://render.githubusercontent.com/render/math?math=\color{white}\large\r=\A/\varepsilon): Intrinsic effect size
* Assuming the circadian time are evenly spaced (i.e., every 4 hours per cycle).

```{R}
library(CircaPower)

## Calculate power given (1) sample size n, (2) intrinsic effect size r, and (3) alpha level
CircaPower(n=12, r=1.5, alpha = 0.05)

## Calculate sample size given (1) pre-specified power, (2) intrinsic effect size r, and (3) alpha level
CircaPower(power=0.8, r=1.5, alpha = 0.05)

```

