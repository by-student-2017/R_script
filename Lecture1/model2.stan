data{
  int N;    // Experiment participants
  int Y[N]; // Number of correct answers out of T trials
  int T;    // Number of trials for each participant
}

parameters{
  real beta; // Logistic partial regression coefficient common to all animals
  real a[N]; // Individual difference
  real<lower=0> sigma; // Variation due to individual differences
}

transformed parameters{
  real theta[N]; // Correct answer rate of each participant
  // Convert individual difference to accuracy rate using sigmoid function
  for(i in 1:N){
    theta[i] = inv_logit(beta+a[i]);
  }
}

model{
  for(i in 1:N){
    Y[i] ~ binominal(T,theta[i]); // Follow the binomial distribution
  }
  for(i in 1:N){
    a[i] ~ normal(0,sigma); // Hierarchical prior distribution of individual differences
  }
  beta ~ normal(0,100); // Uninformative prior distribution of partial regression coefficients
  sigma ~ cauchy(0,5);  // Variation due to individual differences
}

