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

- Circadian power calculation (active design) when the circadian times are evenly spaced.
- Circadian power calculation (passive design) given irregular circadian time distribuiton.
- A case study how to perform circadian power calculation using mouse skeletal muscle pilot data.
- Intrinsic effect size from public databases.


http://htmlpreview.github.io/?https://github.com/circaPower/CircaPower/blob/main/vignettes/CircaPower.html

## Short tutorial 

* Model assumption: 
  + y<sub>i</sub> = A cos(&omega;(t<sub>i</sub> - &phi;)) + M + &varepsilon;<sub>i</sub>
  + &varepsilon;<sub>i</sub> ~ N(0, &sigma;<sup>2</sup>)
  + A: Amplitude
  + &sigma;: Noise level
  + r = A/&sigma;: Intrinsic effect size. Usually r could be estimated from your pilot data. If there is no pilot data, please refers to the full tutorial, where we documented the intrinsic effect sizes from public databases for varies tissues in human and mouse.
  
* Example 1 (active design): assuming the evenly spaced circadian time distribution (i.e., every 4 hours per cycle).

```{R}
library(CircaPower)

## Calculate power given (1) sample size n, (2) intrinsic effect size r, and (3) alpha level
CircaPower(n=12, r=1.5, alpha = 0.05)

## Calculate sample size given (1) pre-specified power, (2) intrinsic effect size r, and (3) alpha level
CircaPower(power=0.8, r=1.5, alpha = 0.05)

```

* Example 2 (passive design): assuming the irregular circadian time distribution (i.e., in human postmortem brain studies).

```{R}
library(CircaPower)

## Use observed time of death from the human post-mortem brain transcriptomic study on Brodmann's area 11 and 47 in the prefrontal cortex as an example.
data(cts_Chen)

## Calculate power given (1) sample size n, (2) intrinsic effect size r, (3) irregular circadian times and (3) alpha level
CircaPower(n=100, r=0.4, cts=cts_Chen, alpha = 0.05)

## Calculate sample size given (1) pre-specified power, (2) intrinsic effect size r, (3) irregular circadian times and (3) alpha level
CircaPower(power=0.75, r=0.4, cts=cts_Chen, alpha = 0.05)

```
  


