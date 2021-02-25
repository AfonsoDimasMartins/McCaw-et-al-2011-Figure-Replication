# https://journals.plos.org/ploscompbiol/article?id=10.1371/journal.pcbi.1002026

data.x <- c(0, 8, 9, 12, 34.5, 60, 82, 95, 99)/100
data.y <- c(0, 0, 20, 43, 68, 33, 63, 99, 94)/100

shape_MSE <- function(s){
  P <- c(); error <- c()
  for(i in 1:9){
    p <- data.x[i]
    P <- c(P, p/(p+(1-p)*exp(s))) # equation 4 of McCaw's paper
    delta <- P[i] - data.y[i]
    error <- c(error, delta)
  }
  
  MSE <- mean(error^2)
  return(MSE)
}

theta.guess <- -0.5
fit <- optim(par=theta.guess, fn=shape_MSE, method="L-BFGS-B", hessian=T)


plot(NA, NA, xlim = c(0,1.01), ylim = c(0,1.01), xlab = "Proportion of mutant in donor", ylab = "Proportion of mutant in recipient",
     xaxs = 'i', yaxs = 'i', fg = 'white', col.axis = 'white')
axis(1); axis(2, las = 1)
P <- c()
s <- fit$par
for (i in 1:9){
  p <- data.x[i]
  P <- c(P, p/(p+(1-p)*exp(s)))
}
lines(data.x, P, col = 'coral3', lwd = 2)
P <- c()
s <- -log(0.44)
for (i in 1:100){
  p <- seq(0, 1, length.out = 100)[i]
  P <- c(P, p/(p+(1-p)*exp(s)))
}
lines(seq(0, 1, length.out = 100), P, lwd = 2, lty = 2)
P <- c()
s <- -log(3.9)
for (i in 1:100){
  p <- seq(0, 1, length.out = 100)[i]
  P <- c(P, p/(p+(1-p)*exp(s)))
}
lines(seq(0, 1, length.out = 100), P, lwd = 2, lty = 2)
points(data.x, data.y, pch = 0, lwd = 1.5)



op <- par(mfrow = c(1,2))
plot(NA, NA, xlim = c(0, 1.01), ylim = c(0, 1.01), xlab = "Proportion of mutant in donor", ylab = "Proportion of mutant in recipient",
     xaxs = 'i', yaxs = 'i', fg = 'white', col.axis = 'white')
points(data.x, data.y, pch = 0)
axis(1); axis(2, las = 1)
text(0.1, 0.9, 'a)')
plot(NA, NA, xlim = c(0, 1.01), ylim = c(0, 1.01), xlab = "Proportion of mutant in donor", ylab = "Proportion of mutant in recipient",
     xaxs = 'i', yaxs = 'i', fg = 'white', col.axis = 'white')
P <- c()
s <- -1.5
for (i in 1:9){
  p <- data.x[i]
  P <- c(P, p/(p+(1-p)*exp(s)))
}
lines(data.x, P, col = 'gray80', lwd = 2, lty = 1)
P <- c()
s <- 0
for (i in 1:9){
  p <- data.x[i]
  P <- c(P, p/(p+(1-p)*exp(s)))
}
lines(data.x, P, col = 'gray60', lwd = 2, lty = 2)
P <- c()
s <- 1.5
for (i in 1:9){
  p <- data.x[i]
  P <- c(P, p/(p+(1-p)*exp(s)))
}
lines(data.x, P, col = 'gray40', lwd = 2, lty = 3)
legend('bottomright', legend = c('s = -1.5', 's = 0', 's = 1.5'), lty = 1:3, lwd = 2, 
       col = c('gray80', 'gray60', 'gray40'), cex = 1, box.lty = 0, bty = "n", seg.len = 3)
axis(1); axis(2, las = 1)
text(0.1, 0.9, 'b)')
par(op)