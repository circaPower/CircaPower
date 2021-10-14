##' Analytical circadian power calculation based on a cosiner model.
##'
##' Exactly one of the parameters 'n','power', 'r' and 'alpha' must be passed as NULL, and that parameter is determined from the others.  Notice that alpha has non-NULL default so NULL must be explicitly passed if you want to compute it.
##' @title CircaPower
##' @param n Sample size.
##' @param power Statistical power.
##' @param r Intrinsic effect size. r=A/\eqn{\sigma}, where A is the amplitude of the sinusoidal curve: \eqn{y = A * sin(2\pi/period * (\phi + cts)) + M + \sigma}, and \eqn{\sigma} is the noise level of the independent Normal error term \eqn{N(0,\sigma^2)}.
##' @param phi Phase shift \eqn{\phi} of the sinusoidal curve. Default is 0.
##' @param period Period of the sinusoidal curve. Default is 24.
##' @param cts Circadian times of the putative samples. If cts is NULL, evenly-spaced circadian time design will be used. If cts is not NULL, see more options on ct_estimation.
##' @param ct_estimation If ct_estimation=='expected' (default), we will calculate the sampling design factor directly using the observed circadian time; if ct_estimation=='sampling', we will (1) perform kernel density estimation from the observed circadian time, (2) draw n circadian times from the kernel density estimation, (3) calculate the sampling design factor using these drawn samples.
##' @param alpha Type I error control. Default is 0.05.
##' @return A list of arguments (including the computed one) augmented.
##' @author Wei Zong, Zhiguang Huo
##' @export
##' @examples
##' CircaPower(n=NULL, power=0.8, r=1.5)
##' 
##' n = 48
##' cts = seq(0,24,length.out = n+1)[-1]
##' A = 1
##' sigma = 1
##' r = A/sigma
##' CircaPower(n, r=r, phi=0, period = 24, cts=cts, alpha = 0.001)


CircaPower = function(n=NULL, power=NULL, r=NULL, phi=0, period = 24, cts=NULL, ct_estimation="expected", alpha = 0.05){
  
  if (sum(sapply(list(n, r, power, alpha), is.null)) != 1){
    stop("exactly one of n, r, power, and alpha must be NULL")		
  } 
  
  w = 2*pi / period
  
  if(is.null(cts)){
    message("No circadian time is specified, evenly-spaced circadian time design will be used.")
    d = 0.5
    
  }else if(is.null(n)){
    message("The sample size n unspecified, expected sampling design factor is directly estimated from the circadian time points provided. ct_estimation argument is disabled.")
    d = sum(sin(w*(cts+phi))^2)/length(cts) #E[d]
    
  }else if(!is.null(n)){
    if(ct_estimation == "expected"){
      message("Since ct_estimation is 'expected' (default), the expected sampling design factor is directly estimated from the circadian time points provided.")
      d = sum(sin(w*(cts+phi))^2)/length(cts) #E[d]
    }else if(ct_estimation == "sampling"){
      message("Since ct_estimation is 'sampling', circadian time points of size n will be draw from the Kernel density estimated from the circadian time points provided. The sampling design factor using these drawn samples.")
      cts = cts %% period #fold cts into one cycle
      
      rep.cts = c(cts-period, cts, cts+period)#expand cts to 3 periods
      dens = density(rep.cts, n=3e+5, from = -period, to = 2*period)
      x.dens = dens$x[dens$x>0 & dens$x<period]
      y.dens = dens$y[dens$x>0 & dens$x<period]
      
      sample_cts = sample(x.dens, n, prob = y.dens)
      d = sum(sin(w*(sample_cts+phi))^2)/length(sample_cts)
    } else {
      stop("internal error 1, please report this bug at https://github.com/circaPower/CircaPower/issues")    	
    }
  }else {
    stop("internal error 2, please report this bug at https://github.com/circaPower/CircaPower/issues")
  }
  
  p.body = quote({
    df2 = n - k - 1
    ncp = r^2 * n * d
    Z = qf(1 - alpha, df1, df2, ncp = 0)
    1 - pf(Z, df1, df2, ncp = ncp)
  })
  
  k = 2
  df1 = k
  
  if(is.null(power)){
    power = eval(p.body)
  }else if(is.null(n)){
    n = round(uniroot(function(n) eval(p.body) - power, c(4,1e+9))$root)
  }else if(is.null(r)){
    r = uniroot(function(r) eval(p.body) - power, c(1e-10,1e+5))$root
  }else if (is.null(alpha))
    alpha = uniroot(function(alpha) eval(p.body) - power, c(1e-10, 1 - 1e-10))$root
  else stop("internal error 3, please report this bug at https://github.com/circaPower/CircaPower/issues")

  
  
  structure(list(n = n, r = r, power = power, alpha = alpha))
}

