data {
  int<lower=0> N;
  vector[N] weight;
  vector[N] age;
  real X_BAR;
}

parameters {
  real alpha;
  real beta;
  real sigma;
}

model {
  // priors
  alpha ~ normal(60,15);
  beta ~ normal(0, 5);
  sigma ~ uniform(0, 10);

  // likelihood
  weight ~ normal(alpha + beta * (age-X_BAR), sigma);
}

generated quantities {
  real y_pred[N];

  y_pred = normal_rng(alpha + beta * (age-X_BAR), sigma);
}

