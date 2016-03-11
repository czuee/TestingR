Questions

   1. Obtain the mean, median, variance and mad of the following observations:
   50; 60; 10; 20; 10; 40; 30; 800; 30; 40; 10
#   obs<-c(50,60,10,20,10,40,30,800,30,40,10)
#   mean(obs)
#   median(obs)
#   var(obs)
#   mad(obs)

   
   2. Redo the calculations without the outlier. Conclusions?
#   mean(obs[obs<800])
#   median(obs[obs<800])
#   var(obs[obs<800])
#   mad(obs[obs<800])
#mean and median much closer now; median did not move, but mean was strongly affected by the outlier

   3. Redo these calculations without using the R builtin functions
   [Reminder: the median is the value of the data that split them in 2 equal parts.
   If the number of data points is odd, the median is the value of the (nth+1)/2 largest datum,
   and it's the mean between the (nth/2 and (nth/2+1) if the number of data points
   is even; and MAD=med(abs(x(i)-med(x))]

#   m.mean<-function(x) return(sum(x)/length(x))
#   m.median<-function(x){
#   n<-length(x)
#   sx<-sort(x)
#   if ((n %% 2)==1) return(sx[(n+1)%/%2]) else return(sum(sx[n%/%2]+sx[n%/%2+1])/2)
#   }

#   m.mad<-function(x){return(m.median(abs(x-m.median(x))))}



   4. Load the file class05.xls from
   http://www.unil.ch/popgen/teaching/R11/class2005.xls

#     clean the data! save the excel file,
#     open it in excel, rename the columns with names without
#     space or special characters, replace empty cells with NA,
#     remove the ^ from châtain (chatain).
#     Then save it as text  (txt) and import
#     it in R using read.table


     
     How many non smoking students in this data set? how many different hair color?
#> table(dat$Fumeur)

# n  o
#35 16

#35 non smoking

#> table(dat$Cheveux.c)

#  Blond    brun chatain    noir    roux
#     10       6      26       5       2

#5 hair colors
     
   5. Draw a histogram of sizes. Are the different size classes equifrequent?

#      hist(dat$Taille,breaks=seq(150,200,5))

#   No they are not equifrequent, the most frequent are persons between 165 and 170 cm.
#   The distribution does not look very different from normal.


   
   6. Plot the empirical cumulative distribution of sizes (use plot and sort).
   Using this plot, estimate the 30th and 70th percentile of the distribution of
   sizes.

#   plot((1:(length(dat$Taille)-1))/(length(dat$Taille)-1),sort(dat$Taille))
#   abline(h=0.3)     #~167
#   abline(h=0.7)     #~178

   
   
   
   6b. use histogram and qqnorm (?qqnorm) to check whether sizes are normally distributed.
       which is better?  How would you test for normality?

#  hist(dat$Taille)
#  qqnorm(dat$Taille)
#   qqnorm better than hist because easier to assess normality from qqnorm
#   a shapiro test or a kolmogorov smirnov test or even a chi^2 test after creating approriate classes


   7. Use quantile to validate your approximation for question 6
#   quantile(dat$Taille,c(0.3,0.7),na.rm=T)

   8. What's the mean weight? estimate it in kg then in gr (you don't need to use R to estimate it in gr).
#   mean(dat$Poids,na.rm=T)
#   mean(dat$Poids,na.rm=T)*1000
#   mean(dat$Poids*1000,na.rm=T)

   9. What's the weight variance in kg^2? in gr^2? (you don't need to use R to estimate it in gr^2)

#   var(dat$Poids,na.rm=T);
#   var(dat$Poids,na.rm=T)*1000^2
#   var(dat$Poids*1000,na.rm=T)


   10. rescale the variable weight so that it has mean 0 and sd 1. Why is this transformation useful?
       what is the 2.5th and 97.5th percentile of the rescaled weight?

#   Cpoids<-(dat$Poids-mean(dat$Poids,na.rm=T))/sd(dat$Poids,na.rm=T)
#   mean(Cpoids,na.rm=T)
#   sd(Cpoids,na.rm=T)
#   quantile(Cpoids,c(0.025.0.975))
# or Cpoids<-scale(dat$Poids)
#   mean(Cpoids,na.rm=T)
#   sd(Cpoids,na.rm=T)


   
  
  
  