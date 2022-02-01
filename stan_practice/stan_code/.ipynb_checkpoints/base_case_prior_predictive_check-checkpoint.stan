data {
  int<lower=0> N;
//  int<lower=0> N_SKUS;
//  int<lower=0> N_ACCOUNTS;
//  int<lower=0> account[N];
//  int<lower=0> sku[N];
  real<lower=0> price[N];
  real<lower=0> competitor_price[N];
//  real<lower=0> quantity[N];
}

transformed data { 
  real mean_price;
  real mean_comp_price;
  
  mean_price = mean(price);
  mean_comp_price = mean(competitor_price);
}

parameters {
  real<lower=0> alpha;
  real<upper=0> beta;
  real<lower=0> gamma;
  real<lower=0> sigma;
}

transformed parameters {
  vector[N] mu;

  for (i in 1:N) {
    mu[i] = alpha + beta*(price[i] - mean_price) + gamma*(competitor_price[i] - mean_comp_price);
  }
}

model {
  alpha ~ normal(50, 20);
  beta ~ normal(-2, 1);
  gamma ~ normal(2, 1);
  sigma ~ uniform(0, 10);
  
//  quantity ~ normal(mu, sigma);
}

generated quantities {
  real y_pred[N];
  
  y_pred = normal_rng(mu, sigma);
}