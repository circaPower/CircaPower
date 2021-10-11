# CircaPower
Github repository for circadian power calculation (CircaPower)


## Install This Package from github
* In R console

```{R}
library(devtools)
install_github("https://github.com/circaPower/CircaPower") 
```

## Citation

* Wei Zong, Marianne L. Seney, Kyle D. Ketchesin, Michael T. Gorczyca, Andrew C. Liu, Karyn A. Esser, George C. Tseng^*, Colleen A. McClung^* and Zhiguang Huo^*. Experimental Design and Power Calculation in Omics Circadian Rhythmicity Detection. (Submitted)

* The manuscript can be found here: (to be updated)

## Full tutorial (to be updated)

* Circadian power calculation (active design) when the circadian time are evenly spaced.
* A case study how to perform circadian power calculation using mouse skeletal muscle pilot data
* Circadian power calculation given irregular circadian time distribuiton.

http://htmlpreview.github.io/?https://github.com/Caleb-Huo/AWFisher/blob/master/vignettes/AWFisher.html


## Short tutorial 

* Assuming the circadian time are evenly spaced (i.e., every 4 hours per cycle).

```{R}
library(CircaPower)

## Calculate power given (1) sample size n, (2) effect size r, and (3) alpha level
CircaPower(n=12, r=1.5, alpha = 0.05)

## Calculate sample size given (1) pre-specified power, (2) effect size r, and (3) alpha level
CircaPower(power=0.8, r=1.5, alpha = 0.05)

```

