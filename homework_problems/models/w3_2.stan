data {
  int<lower=0> N;
  vector<lower=0>[N] weight;
  vector[N] food;
  }

parameters {
  real<lower=0> alpha;
  real beta;
  real<lower=0> sigma;
  }
  
model {
  alpha ~ normal(3, 2);
  beta ~ normal(0, 1);
  sigma ~ exponential(1);
  
  weight ~ normal(alpha + (food - mean(food))*beta, sigma);
  }