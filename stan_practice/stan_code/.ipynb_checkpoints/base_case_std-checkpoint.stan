data {
  int<lower=0> N;
//  int<lower=0> N_SKUS;
//  int<lower=0> N_ACCOUNTS;
//  int<lower=0> account[N];
//  int<lower=0> sku[N];
  real price[N];
  real competitor_price[N];
  real quantity[N];
}

parameters {
  real alpha;
  real beta;
  real gamma;
  real sigma;
}

transformed parameters {
  vector[N] mu;

  for (i in 1:N) {
    mu[i] = alpha + beta*price[i] + gamma*competitor_price[i];
  }
 
}
model {
 quantity ~ normal(mu, sigma);
}

generated quantities {
  real y_pred[N];

  y_pred = normal_rng(mu, sigma);
}

