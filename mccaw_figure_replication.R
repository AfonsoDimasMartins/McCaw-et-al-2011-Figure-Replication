# Proportion of the mutant strain in the donor and in the recipient
mut_donor <- c(0, 8, 9, 12, 34.5, 60, 82, 95, 99) / 100
mut_recip <- c(0, 0, 20, 43, 68, 33, 63, 99, 94) / 100

# Function to obtain model curves (for fitting or plotting)
# Input should be one number
model_curve <- function(s) {
  curve <- mut_donor / (mut_donor + (1 - mut_donor) * exp(s))
  return(curve)
}

# Function that gives the mean squared errors for a certain s value
# Input should be a vector of length 9 to match the data
model_mse <- function(starting_curve) {
  error <- starting_curve - mut_recip
  mse <- mean(error)^2
  return(mse)
}

starting_curve <- model_curve(-0.5)
model_fit <- optim(par = starting_curve, fn = model_mse,
                   method = "L-BFGS-B", hessian = T)


# Plotting elements
x_lab <- "Proportion of mutant in donor"
y_lab <- "Proportion of mutant in recipient"


# Figure 1 and 2 reproduction
op <- par(mfrow = c(1, 2))

plot(NA, NA, xlim = c(0, 1.01), ylim = c(0, 1.01), xlab = x_lab, ylab = y_lab,
     xaxs = "i", yaxs = "i", fg = "white", col.axis = "white")
points(mut_donor, mut_recip, pch = 0)
axis(1); axis(2, las = 1)
text(0.1, 0.9, "a)")

plot(NA, NA, xlim = c(0, 1.01), ylim = c(0, 1.01), xlab = x_lab, ylab = y_lab,
     xaxs = "i", yaxs = "i", fg = "white", col.axis = "white")
lines(mut_donor, model_curve(-1.5), col = "gray80", lwd = 2, lty = 1)
lines(mut_donor, model_curve(0), col = "gray60", lwd = 2, lty = 2)
lines(mut_donor, model_curve(1.5), col = "gray40", lwd = 2, lty = 3)
legend("bottomright", legend = c("s = -1.5", "s = 0", "s = 1.5"),
       lty = 1:3, lwd = 2,
       col = c("gray80", "gray60", "gray40"),
       cex = 1, box.lty = 0, bty = "n", seg.len = 3)
axis(1); axis(2, las = 1)
text(0.1, 0.9, "b)")

par(op)


# Figure 4A reproduction
# Plotting the best model fitting plus interval curves provided in the article
plot(NA, NA, xlim = c(0, 1.01), ylim = c(0, 1.01), xlab = x_lab, ylab = y_lab,
     xaxs = "i", yaxs = "i", fg = "white", col.axis = "white")
axis(1); axis(2, las = 1)
lines(mut_donor, model_fit$par, col = "coral3", lwd = 2)
lines(mut_donor, model_curve(-log(0.44)), lwd = 2, lty = 2)
lines(mut_donor, model_curve(-log(3.9)), lwd = 2, lty = 2)
points(mut_donor, mut_recip, pch = 0, lwd = 1.5)
