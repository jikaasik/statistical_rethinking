data {
  int<lower=0> N;
  vector[N] height;
  vector[N] weight;
}

parameters {
  real alpha;
  real beta;
  real sigma;
}

model {
  // Priors
  alpha ~ normal(178, 20);
  beta ~ lognormal(0, 1);
  sigma ~ uniform(0, 50);
  
  // Likelihood
  height ~ normal(alpha + beta * weight, sigma);
}
