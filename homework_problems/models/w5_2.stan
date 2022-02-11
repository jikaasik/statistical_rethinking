data {
  int<lower=0> N;
  int<lower=0> N_GENDERS;
  int<lower=0> N_DISCIPLINES;
  int<lower=0> discipline[N];
  int<lower=0> gender[N];
  int<lower=0> awards[N];
  int<lower=0> applications[N];
}

parameters {
  real a_discipline[N_DISCIPLINES];
  real a_gender[N_GENDERS];
}

transformed parameters {
  vector[N] p;

  for (i in 1:N) {
    p[i] = inv_logit(a_gender[gender[i]] + a_discipline[discipline[i]]);
  }
}

model {
  a_gender ~ normal(0, 1);
  a_discipline ~ normal(0, 1);

  for (i in 1:N) {
    awards[i] ~ binomial(applications[i], p[i]);
  }
}

