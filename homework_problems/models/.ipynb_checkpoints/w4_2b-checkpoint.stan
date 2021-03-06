data {
  int<lower=0> N;
  vector<lower=0>[N] weight;
  vector[N] food;
  vector[N] group_size;
  }

parameters {
  real<lower=0> alpha;
  real beta;
  real gamma;
  real<lower=0> sigma;
  }

transformed parameters {
  real mu[N];
  
  for (i in 1:N) {
  
    mu[i] = alpha + food[i]*beta + group_size[i]*gamma;
    
    }
  }
  
model {
  alpha ~ normal(3, 2);
  beta ~ normal(0, 1);
  sigma ~ exponential(1);
  gamma ~ normal(0, 1);
  
  weight ~ normal(mu, sigma);
  }

generated quantities {
    vector[N] log_lik;

    for(i in 1:N){

        log_lik[i] = normal_lpdf(weight[i] | mu[i], sigma);

    }

}