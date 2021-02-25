# Proportion of the mutant strain in the donor and in the recipient
# Data from McCaw et al (2011)
# https://journals.plos.org/ploscompbiol/article?id=10.1371/journal.pcbi.1002026
mut_donor <- c(0, 8, 9, 12, 34.5, 60, 82, 95, 99) / 100
mut_recip <- c(0, 0, 20, 43, 68, 33, 63, 99, 94) / 100

# Function for model fitting
# Equation also from McCaw et al (2011)
mean_squared_errors <- function(s) {
  model_attempt <- c(); error <- c()
  for(i in 1:9) {
    p <- mut_donor[i]
    model_attempt <- c(model_attempt, p / (p + (1 - p) * exp(s)))
    delta <- model_attempt[i] - mut_recip[i]
    error <- c(error, delta)
  }
  mse <- mean(error^2)
  return(mse)
}

theta.guess <- -0.5
model_fit <- optim(par = theta.guess, fn = mean_squared_errors,
                   method = "L-BFGS-B", hessian = T)


# Figure 4A reproduction
# Plotting the best model fitting plus interval curves provided in the article
plot(NA, NA, xlim = c(0, 1.01), ylim = c(0, 1.01),
     xlab = "Proportion of mutant in donor",
     ylab = "Proportion of mutant in recipient",
     xaxs = "i", yaxs = "i", fg = "white", col.axis = "white")
axis(1); axis(2, las = 1)
best_curve <- c()
s <- model_fit$par
for (i in 1:9) {
  p <- mut_donor[i]
  best_curve <- c(best_curve, p / (p + (1 - p) * exp(s)))
}
lines(mut_donor, best_curve, col = "coral3", lwd = 2)
P <- c()
s <- -log(0.44)
for (i in 1:100) {
  p <- seq(0, 1, length.out = 100)[i]
  P <- c(P, p / (p + (1 - p) * exp(s)))
}
lines(seq(0, 1, length.out = 100), P, lwd = 2, lty = 2)
P <- c()
s <- -log(3.9)
for (i in 1:100) {
  p <- seq(0, 1, length.out = 100)[i]
  P <- c(P, p / (p + (1 - p) * exp(s)))
}
lines(seq(0, 1, length.out = 100), P, lwd = 2, lty = 2)
points(mut_donor, mut_recip, pch = 0, lwd = 1.5)



# Figure 1 and 2 reproduction
op <- par(mfrow = c(1, 2))
plot(NA, NA, xlim = c(0, 1.01), ylim = c(0, 1.01),
     xlab = "Proportion of mutant in donor",
     ylab = "Proportion of mutant in recipient",
     xaxs = "i", yaxs = "i", fg = "white", col.axis = "white")
points(mut_donor, mut_recip, pch = 0)
axis(1); axis(2, las = 1)
text(0.1, 0.9, "a)")
plot(NA, NA, xlim = c(0, 1.01), ylim = c(0, 1.01),
     xlab = "Proportion of mutant in donor",
     ylab = "Proportion of mutant in recipient",
     xaxs = "i", yaxs = "i", fg = "white", col.axis = "white")
P <- c()
s <- -1.5
for (i in 1:9) {
  p <- mut_donor[i]
  P <- c(P, p / (p + (1 - p) * exp(s)))
}
lines(mut_donor, P, col = "gray80", lwd = 2, lty = 1)
P <- c()
s <- 0
for (i in 1:9) {
  p <- mut_donor[i]
  P <- c(P, p / (p + (1 - p) * exp(s)))
}
lines(mut_donor, P, col = "gray60", lwd = 2, lty = 2)
P <- c()
s <- 1.5
for (i in 1:9) {
  p <- mut_donor[i]
  P <- c(P, p / (p + (1 - p) * exp(s)))
}
lines(mut_donor, P, col = "gray40", lwd = 2, lty = 3)
legend("bottomright", legend = c("s = -1.5", "s = 0", "s = 1.5"),
       lty = 1:3, lwd = 2,
       col = c("gray80", "gray60", "gray40"),
       cex = 1, box.lty = 0, bty = "n", seg.len = 3)
axis(1); axis(2, las = 1)
text(0.1, 0.9, "b)")
par(op)