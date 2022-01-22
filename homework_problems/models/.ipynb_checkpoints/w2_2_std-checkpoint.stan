data {
  int<lower=0> N;
  vector[N] weight;
  vector[N] age;
}

transformed data {
  vector[N] x_std;
  vector[N] y_std;
  x_std = (age - mean(age)) / sd(age);
  y_std = (weight - mean(weight)) / sd(weight);
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
  y_std ~ normal(alpha + beta * x_std, sigma);
}

generated quantities {
  real y_pred[N];
  real y_pred_exp[N];

  y_pred = normal_rng(alpha + beta * x_std, sigma);
  for (n in 1:N){
    y_pred_exp[n] = (y_pred[n] * sd(weight)) + mean(weight);
  }
}

