data {
  int<lower=0> N;
  int<lower=0> N_SKUS;
  int<lower=0> N_ACCOUNTS;
  int<lower=0> account[N];
  int<lower=0> sku[N];
  real price[N];
  real competitor_price[N];
  real<lower=0> quantity[N];
}

parameters {
  real<lower=0> alpha;
  real<upper=0> beta;
  real<lower=0> gamma;
  real<lower=0> sigma;

  vector[N_SKUS] sku_intercept;
  vector[N_SKUS] sku_slope;
  vector[2] sku_sigma;
  vector[N_ACCOUNTS] account_intercept;
  vector[N_ACCOUNTS] account_slope;
  vector[2] account_sigma;
}

transformed parameters {
  vector[N] mu;

  for (i in 1:N) {
    mu[i] = alpha + sku_intercept[sku[i]] + account_intercept[account[i]]
      + (beta + sku_slope[sku[i]] + account_slope[account[i]])*price[i]
      + gamma*competitor_price[i];
  }
}

model {
  //priors
  alpha ~ normal(40, 30);
  beta ~ normal(-3, 5);
  gamma ~ normal(2, 10);
  sku_slope ~ normal(0, sku_sigma[2]);
  sku_intercept ~ normal(0, sku_sigma[1]); 
  account_slope ~ normal(0, account_sigma[2]);
  account_intercept ~ normal(0, account_sigma[1]);

  sigma ~ normal(0, 50);
  sku_sigma[1] ~ normal(0, 20);
  sku_sigma[2] ~ normal(0, 5);
  account_sigma[1] ~ normal(0, 20);
  account_sigma[2] ~ normal(0, 5);

  quantity ~ normal(mu, sigma);
}

generated quantities {
  real y_pred[N]; // posterior predictive distribution
  real y[N];
  real gap[N];
  real mae;

  y = quantity;
  y_pred = normal_rng(mu, sigma);

  for (i in 1:N) {
    gap[i] = abs(y_pred[i] - y[i]);
  }

  mae = mean(gap);

}

