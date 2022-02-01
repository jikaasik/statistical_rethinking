data {
  int<lower=0> N;
  vector[N] weight;
  vector[N] age;
  int sex[N];
  real X_BAR;
}

parameters {
  real alpha[2];
  real beta[2];
  real sigma;
}

transformed parameters {
  real mu[N];
  for (i in 1:N) {
    mu[i] = alpha[sex[i]] + beta[sex[i]]*(age[i]-X_BAR);
  }
}

model {
  // priors
  alpha ~ normal(60,15);
  beta ~ normal(0, 5);
  sigma ~ uniform(0, 10);

  // likelihood
  weight ~ normal(mu, sigma);
}

generated quantities {
  real y_pred[N];

  y_pred = normal_rng(mu, sigma);
}

