Questions

 

   1. generate 254 random numbers drawn from a uniform between 0 and 1000. Draw
   a histogram of these numbers. Does it look familiar? Go back to the lottery
   data set, and now think of a graphical way of verifying uniformity in the winning numbers
   (hint: have a look at qqplot).  Can you think of a way for testing this?
   
#   2 possibilities:
#   a<-sample(0:999,size=254)
#   or
#  b<-trunc(runif(254)*1000)
#   one intuitive way would be to compare the qqplot of the 2 distributions:
#   qqplot(a,dat$numero.loterie)
#   another would be to carry out a kolmogorov-smirnov test (?ks.test)
#   ks.test(a,dat$numero.loterie)

   
   
   2. Imagine that the size of the male population in Switzerland follows a
      normal with mean 1.72m and sd 0.3m.
         1. What is the probability that an individual from this population is 1.60 m or less?
#pnorm(1.6,mean=1.72,sd=0.3)

         2. 1.80 m or less?
#pnorm(1.8,mean=1.72,sd=0.3)

         3. 1.90 m or more?
#pnorm(1.90,mean=1.72,sd=0.3,lower=F) # 1-pnorm(1.90,mean=1.72,sd=0.3)

         4. 2.00 m or more?
#pnorm(2.0,mean=1.72,sd=0.3,lower=F) # 1-pnorm(2.0,mean=1.72,sd=0.3)

         5. What proportion of the male population should be between 1.5 and 1.80 tall? 
#pnorm(1.8,mean=1.72,sd=0.3)-pnorm(1.5,mean=1.72,sd=0.3)

         


   3. The greater white tooth shrew, Crocidura russula,
     is a small anthropophilic insectivore leaving around here, and studied by
     research group in Lausanne. The population size is stable, meaning that the mean
     number of surviving offspring per female is 2.
     Suppose that the number of surviving offspring follows a Poisson distribution.
     What is the probability that a female has no surviving offspring?
     one surviving offspring?  4 or more? (beware, there is a small trap here).

#dpois(0,lambda=2)
#dpois(1,lambda=2)
#1-ppois(3,lambda=2)  #because ppois(k, lambda) includes k in the estimate of the cdf



   4. In several species, the probability p of dying is independant of age.
   The distribution of mortality ages follows a geometric distribution
   P(X=x)=p(1-p)^x. We are interested in a population where the probability
   of dying during a year is 0.15. You can use the geom (e.g pgeom, rgeom, dgeom, qgeom)
   function to answer the following:
        1. In this population, what is the probability of dying at 20?
#dgeom(20,0.15)
        2. What is the probability of dying before 2?
#pgeom(1,0.15)
        3. What is the probability of attaining 30?
#1-pgeom(29,0.15) # also 0.85^30
        4. What is the mean age?    (hint: think about expected value)
        Brute force:

#mean(rgeom(1000000,0.15))

        better: use the definition of an expectation
        E[x]=\sum_{i=0}^inf p_i x_i  where p_i is the probability of observing x_i

        thus:

#m.geom<-sum(dgeom(0:1000,0.15)*0:1000) #(1/0.15-1)
#1000 is sufficiently large (dgeom(1000,0.15)<10^-71!
        5. What is the variance of age?
        we use the definition of the variance:

        \sum_{i=0}^inf sum(x_i^2p_i)-m.geom^2

#v.geom<-sum(dgeom(0:1000,0.15)*(0:1000)^2)-m.geom^2




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

x1<-sample(1:6,size=1000,replace=T)
x2<-sample(1:6,size=1000,replace=T)+sample(1:6,size=1000,replace=T)
mx5<-matrix(sample(1:6,size=5000,replace=T),ncol=5)
x5<-numeric(1000)
for (i in 1:1000) x5[i]<-sum(mx5[i,])
#or (have a look at ?apply)
x5<-apply(mx5,1,sum)
x20<-apply(matrix(sample(1:6,size=20000,replace=T),ncol=20),1,sum)
par(mfrow=c(4,2))
hist(x1);qqnorm(x1);qqline(x1)
hist(x2);qqnorm(x2);qqline(x2)
hist(x5);qqnorm(x5);qqline(x5)
hist(x20);qqnorm(x20);qqline(x20)
par(mfrow=c(1,1))

   [optional] You can do the same for other distributions, for instance,
   the geometric distribution we ve seen in the previous paragraph
#x1<-rgeom(1000,0.15)
#x2<-apply(matrix(rgeom(2000,0.15),ncol=2),1,sum)
#x5<-apply(matrix(rgeom(5000,0.15),ncol=5),1,sum)
#x50<-apply(matrix(rgeom(50000,0.15),ncol=50),1,sum)
#par(mfrow=c(2,2))
#qqnorm(x1);qqline(x1)
#qqnorm(x2);qqline(x2)
#qqnorm(x5);qqline(x5)
#qqnorm(x50);qqline(x50)
#par(mfrow=c(1,1))

#it takes many more variates to sum to approach normality with the geometric
#distribution


        
#the following two exercices will show you how to use R to do simulations.
#To solve them, start by thinking about what type of information you'd
#like the function to produce, and then think abut ways of generating it.
#You'll have to create vectors or matrices and use loops
        
   6. Write a function that simulates the evolution of the size of a finite
   population under demographic stochasticity.  We will suppose that fertility
   in this population is poisson. This function should take as arguments the
   initial population size, the female s fertility, the number of generations
   over which you want to follow population size, and the possibility of plotting
   the graph of the census size as a function of generation. It should output
   the population sizes throught time at the end.
   
   demog.stoch<-function(n0,lambda,gen,plotit=T){
   n<-numeric(gen)
   n[1]<-n0
   for (i in 2:gen)
   n[i]<-sum(rpois(n[i-1],lambda))

   if (plotit) plot(1:gen,n,type="b",col="red",xlab="Generations",ylab="Population size")
   return(n)
   }
demog.stoch(10,1,100)

   
   7. Write a function drift that simulates the effect of random genetic drift.
   It should take as parameter the population size (fixed), the number of generations,
   the initial allele frequency, a number of replicates.  It should produce at the end
   a graph of the changes throught time of allele frequencies in the different replicates.

      drift<-function(n0=100,ngen=100,p0=0.5,nrep=10){
      fre<-matrix(numeric(ngen*nrep),ncol=nrep)
      fre[1,]<-p0
      for (i in 1:nrep)
      {
        for (j in 2:ngen)
        {
        fre[j,i]<-sum(rbinom(n0,1,fre[j-1,i]))/n0
#another way to do it:
#fre[j,i]<-sum(sample(1:0,n0,replace=T,c(fre[j-1,i],1-fre[j-1,i])))/n0
#but not as efficient
        }

      }
      plot(1:ngen,fre[,1],xlim=c(1,ngen),ylim=c(0,1),xlab="Generations",ylab="p",type="l")
      for (i in 2:nrep)
      lines(1:ngen,fre[,i])

      return(fre)
      }
drift()
drift(1000,p0=0.3,nrep=20)


   
