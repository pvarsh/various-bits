#### Python presentation
#### Plots of n, nlogn, n^2, logn


bigOplots = function(nmax){
  
  if (nmax <= 40){
    nmin = 0
  }
  else {
    nmin = 1
  }
  
  
  n = seq(nmin, nmax, length.out = 30)
  ylin = n
  ylog = log(n)
  ysq = n^2
  ynlogn = n*log(n)
  
  plot(n, ylin, type = 'l',
       lwd = 2,
       main = paste("n on the order of", format(nmax, scientific = F)),
       xlim = c(nmin,nmax),
       ylim=c(nmin, nmax),
       xlab = 'n',
       ylab = "# operations")
  lines(n, ylog, col = 'orange2', lwd = 2)
  lines(n, ynlogn, col = 'cyan2', lwd = 2)
  lines(n, ysq, col = 'magenta2', lwd = 2)
  
  legendposition = "topright"
  
  legend(legendposition, c('O(n)', 'O(logn)', 'O(nlogn)', 'O(n^2)'), lty = c(1,1,1,1),
         col = c('black', 'orange2', 'cyan2', 'magenta2'),
         lwd = c(2,2,2,2),
         cex = 0.8)
}

bigOplots(5)
