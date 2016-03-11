Statistical distributions and functions in R
 
 

R has built in functions to calculate probability densities, cumulative distribution,
inverse of cumulative (quantile) for several standard probability distributions.
Furthermore, R can generate random values from  these distributions.
There are 4 functions for each distribution, starting with the following letters:

   1. d: for density, for instance 'dnorm' for the probability density of the normal distribution
   2. p: for probability, e.g. 'pnorm';
   3. q: for quantile, e.g 'qnorm';
   4. r: for random, e.g. 'rnorm'; 

The classical distributions are:

    * normal  (see ?pnorm ): central for all stats. take mean and variance as parameters.
    * binomial (?pbinom): takes 2 parameters, n the number of trials and p, the probability of a success.
    * poisson (?ppois): determined by a single parameter lambda. Mean=variance. e.g.colony counting
    * geometric (?pgeom) Rate of decay is constant
    * uniform (?punif) e.g.Roll of dice
    *chisquare (?pchisq)
    *F (?pf)
    *t  (?pt)
    ...
    
These are the most common, but several others are also available
?Distributions

and even more here:

http://cran.r-project.org/web/views/Distributions.html

Lets take 1000 random numbers from a normal with mean 0 and sd 1 (default parameters):
a<-rnorm(1000)

and plot a histogram of this vector:
hist(a)
qqnorm(a);qqline(a) #best way to verify normality!

do the same but with mean 4 and sd 5:
b<-rnorm(1000, mean=4, sd=5)
hist(b)
qqnorm(b);qqline(b)

pnorm give the probability that a normal deviate is less than a given number X,
for instance -1.96:

pnorm(-1.96)
pnorm(1.96) #why?

if a random variable follows a normal, then it has 2.5% chance to be
smaller than -1.96 (and since this distribution is symmetrical, it also has
a 2.5% chance of being larger than 1.96)

With qnorm, you do the reverse: what is the value of the normal deviate for
which I have a 2.5% chance of finding a lower deviate:

qnorm(0.025)

Now try:
mean(a)
sd(a)
b<-rnorm(1000,20,2)
mean(b)
sd(b)


 
some examples with other distributions:

rbinom(30,50,0.5) #30 random deviates from a binomial with n=50 and p=0.5
rpois(30,2.4) # 30 random deviates from a Poisson with lambda=2.4
dpois(0,2.4) # Probability to observe 0 if the underlying distribution is a poisson with param 2.4

plot(0:10,dpois(0:10,2.4), type="h") #plot poisson distribution

Another useful function, connected to the binomial distribution, is the function sample.
It allows sampling with or without replacement from a vector (see ?sample). This
function is at the heart of randomization and bootstrap tests

sample(1:10,replace=FALSE) #permutations of the elements
sample(0:99,size=200,replace=TRUE) #200 random draws of numbers between 0 & 99
sample(1:0,size=1000,replace=TRUE,prob=c(0.2,0.8)) 
#same as 
rbinom(1000,size=1,p=0.2)

________________________________________________
Questions

 
   1. generate 254 random numbers drawn from a uniform between 0 and 1000. Draw
   a histogram of these numbers. Does it look familiar? Go back to the lotery
   data set, and now think of a graphical way of verifying uniformity in the winning numbers
   (hint: have a look at qqplot).  Can you think of a way for testing this?

unidist<-runif(254, min=0, max=1000)
hist()
qqnorm(unidist)

qqnorm(lot$number)
qqline(lot$number)
qqplot(lot$number,unidist)
plot(sort(lot$number),sort(unidist))

   2. Imagine that the size of the male population in Switzerland follows a
      normal with mean 1.72m and sd 0.3m.
         1. What is the probability that an individual from this population is 1.60 m or less?          
         2. 1.80 m or less?
         3. 1.90 m or more?
         4. 2.00 m or more?
         5. What proportion of the male population should be between 1.5 and 1.80 meters tall? 

pop<-rnorm(1000,mean=1.72,sd=0.3)
pnorm(1.72,mean=1.72,sd=0.3) = 0.5
pnorm(1.6,mean=1.72,sd=0.3)
? pnorm(1.9,mean=1.72,sd=0.3, lower.tail=FALSE) or 1-pnorm()
? pnorm(1.8,mean=1.72,sd=0.3)-pnorm(1.5,mean=1.72,sd=0.3)

   3. The greater white tooth shrew, Crocidura russula,
     is a small anthropophilic insectivore leaving around here, and is studied by
     research groups in Lausanne. The population size is stable, meaning that the mean
     number of surviving offspring per female is 2.
     Suppose that the number of surviving offspring follows a Poisson distribution.
     What is the probability that a female has no surviving offspring?
     one surviving offspring?  4 or more? (beware, there is a small trap here).

rpois(0:10,2)
plot(0:10, dpois(0:10,2), type ="h") 
ppois(0,2)
ppois(1,2)-ppois(0,2) or dpois(1,2) #dpois is the discrete probab
*** ppois(3,2, lower.tail=FALSE)

   4. In several species, the probability p of dying is independant of age.
   The distribution of mortality ages follows a geometric distribution
   P(X=x)=p(1-p)^x. We are interested in a population where the probability
   of dying during a year is 0.15. You can use the geom (e.g pgeom, rgeom, dgeom, qgeom)
   function to answer the following:
        1. In this population, what is the probability of dying at 20?
        2. What is the probability of dying before 2?
        3. What is the probability of attaining 30?
        4. What is the mean age?    (hint: think about expected value)
        5. What is the variance of age? 

plot(0:100, dgeom(0:100,0.15), type="h") #discrete dist
pgeom(21, 0.15)-pgeom(20, 0.15) #dying at 20
pgeom(1, 0.15) #dying before 2
1-pgeom(29,0.15) #probability of attaining 30
1/p=6.666667 #mean age
(1-p)/p^2=37.77778
#the following exercice is a good way of demonstrating the
#central limit theorem

   5. Imagine that we are rolling a dice.  Using the function sample,
   generate 1000 dice rolls and store them in a vector x1. How are these
   data distributed?
   Now, roll two dices simultaneously a 1000 times, and store the sum
   of the 2 displayed numbers in a vector x2. How are these data distributed?
   Do the same for 5 dices (in vector x5) and 20 dices (in vector x20).  Plot
   on the same figure the normal quantile quantile plots (qqnorm) obtained
   from these 4 experiments.  Conclusions?
   [optional] You can do the same for other distributions, for instance,
   the geometric distribution we ve seen in the previous paragraph

x1<-sample(1:6, size=1000, replace=TRUE)
hist(x1, breaks=100)
Uniformly distributed
x2<-sample(2:12, size=1000, replace=TRUE)
x5<-sample(5:30, size=1000, replace=TRUE)
x20<-sample(20:120, size=1000, replace=TRUE)
> qqnorm(x20,col=6);qqline(x20,col=6)
> qqline(x5,col=4)
> qqline(x1,col=2)
> qqline(x2,col=3)

#the following two exercices will show you how to use R to do simulations.
#To solve them, start by thinking about what type of information you'd
#like the function to produce, and then think about ways of generating it.
#You'll have to create vectors or matrices and use loops
        
****   6. Write a function that simulates the evolution of the size of a finite
   population under demographic stochasticity.  We will suppose that fertility
   in this population is poisson. This function should take as arguments the
   initial population size, the female s fertility, the number of generations
   over which you want to follow population size, and the possibility of plotting
   the graph of the census size as a function of generation. It should output
   the population sizes throught time at the end.
  
pop.census<-function(p,n,f){
 pop<-rep(0,n)
  for(i in 1:n){
    fi<-rpois(1,f)
    p<- p + p^(fi)
#    print(n); print(p)
    pop[i]<-p
  }
  print(paste(1:n, pop))
}

   7. Write a function drift that simulates the effect of random genetic drift.
   It should take as parameter the population size (fixed), the number of generations,
   the initial allele frequency, a number of replicates.  It should produce at the end
   a graph of the changes throught time of allele frequencies in the different replicates.
? How to plot a graph on top of a previous graph

drift<-function(pop,gen,f,r){
  vec<-rep(0,gen)
  p<-f
#  x<-1:gen;y<-1:gen
  plot(1, 1, xlim = c(1,gen), ylim =c(0,1), type="n")
  for(j in 1:r){
    f<-p
  for(i in 1:gen){
    f<-sum(rbinom(pop,1,f))/pop
 #   print(paste(i, f))
    vec[i]<-(f)
  }
  lines(1:gen,vec,col=j)
  }
}