data {
  int<lower=0> N;
  int<lower=0> MIDS;
  int<lower=0> mid[N];
  real happiness[N];
  real age[N];
}
  
parameters {
  real alpha[MIDS];
  real beta;
  real<lower=0> sigma;
}
  
transformed parameters {
  real mu[N];
  
  for (i in 1:N) {
    mu[i] = alpha[mid[i]] + beta*age[i];
  }
}

model {
  //priors
  alpha ~ normal(0, 1);
  beta ~ normal(0, 2);
  sigma ~ exponential(1);
  
  //likelihood
  happiness ~ normal(mu, sigma);
}

generated quantities {
    vector[N] log_lik;

    for(i in 1:N){

        log_lik[i] = normal_lpdf(happiness[i] | mu[i], sigma);

    }

}