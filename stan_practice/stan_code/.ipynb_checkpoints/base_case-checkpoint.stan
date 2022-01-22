data {
  int<lower=0> N;
//  int<lower=0> N_SKUS;
//  int<lower=0> N_ACCOUNTS;
//  int<lower=0> account[N];
//  int<lower=0> sku[N];
  real<lower=0> price[N];
  real<lower=0> competitor_price[N];
  real<lower=0> quantity[N];
}

parameters {
  real alpha;
  real beta;
  real gamma;
  real sigma;
}

model {
  vector[N] mu;

  for (i in 1:N) {
    mu[i] = alpha + beta*price[i] + gamma*competitor_price[i];
  }
  quantity ~ normal(mu, sigma);
}
