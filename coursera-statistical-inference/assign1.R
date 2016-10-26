lambda <- .2
n <- 40
nosim <- 1000
tmean <-1/lambda
tsd <- 1/lambda

#sample mean
sample <- rexp(n, lambda)
        mean(sample)
        sd(sample)

smean <- apply(matrix(rexp(n*nosim, lambda), nosim), 1, mean)
        mean(smean)
        hist(smean)

#sample variance
(1/lambda)/sqrt(n)
ssd <- sd(smean)

#distribution
hist(sample)
stdm <- (smean - mean(smean))/sd(smean)

hist(sample, breaks = 10, density = 20, prob = T,
      main = "Sample from Poisson Distribution",
      xlab ="", ylab = "", yaxt = "n")
curve(dnorm(x, mean = mean(sample), sd = sd(sample)), add= T, lwd = 2)
legend("topright", legend = c("Normal Curve"), lwd = 2)



hist(smean, breaks = 10, density = 20, prob = T,
     main = "Distribution of Sample Averages",
     xlab ="", ylab = "", yaxt = "n")
curve(dnorm(x, mean = mean(smean), sd = sd(smean)), add= T, lwd = 2)
legend("topright", legend = c("Normal Curve"), lwd = 2)
