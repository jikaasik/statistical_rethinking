data {
  int<lower=0> N;
  vector[N] area;
  vector[N] food;
  }

parameters {
  real<lower=0> alpha;
  real beta;
  real<lower=0> sigma;
  }
  
model {
  alpha ~ normal(1, 0.2);
  beta ~ normal(0, .5);
  sigma ~ exponential(1);
  
  food ~ normal(alpha + (area - mean(area))*beta, sigma);
  }