data {
  int<lower=0> N;
  vector[N] weight;
  vector[N] height;
  real X_BAR;
}

parameters {
  real alpha;
  real beta;
  real sigma;
}

model {
  // priors
  alpha ~ normal(160, 20);
  beta ~ lognormal(0, 1);
  sigma ~ uniform(0, 20);

  // likelihood
  weight ~ normal(alpha + beta * (height-X_BAR), sigma);
}

generated quantities {
  real y_pred[N];

  y_pred = normal_rng(alpha + beta * (height-X_BAR), sigma);
}

