# CircaPower
Github repository for circadian power calculation (AW-Fisher)


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

* Including a real data example using mouse metabolism data of three tissues
* Perform transcriptomic meta-analysis and differential expression pattern detection

http://htmlpreview.github.io/?https://github.com/Caleb-Huo/AWFisher/blob/master/vignettes/AWFisher.html


## Short tutorial (to be updated)

* This short tutorial is about how to perform meta-analysis combining p-values from multiple studies.
* Currently, only K=2, 3, ..., 100 (number of studies) are allowed in the R package.

```{R}
library(AWFisher)

K <- 50 ## combining K studies
G <- 10000 ## simulate G genes

set.seed(15213)
p.values = matrix(runif(K*G), ncol=K)
res = AWFisher_pvalue(p.values)

hist(res$pvalues, breaks=40)

ks<-ks.test(res$pvalues, "punif", min=0, max=1, alternative = "two.sided"); ## KS test to test if the AW p-values are uniformly distributed under the null
ks

```

