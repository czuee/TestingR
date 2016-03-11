
Questions

Answer these questions using the file class2005.txt

1. average size of the class? for males? for females?
#mean(dat$size,na.rm=T);mean(dat$size[dat$sex=="M"],na.rm=T);mean(dat$size[dat$sex=="F"],na.rm=T)
#tapply(dat$size,dat$sex,mean,na.rm=T)
2. are the size normally distributed?
#qqnorm(dat$size);qqline(dat$size);
#shapiro.test(dat$size)
3. confidence interval for the average size
#bootstrap(dat$size) #see function bootstrap above
4. correlation between weight and size?
#cor(dat$weight,dat$size,use="complete")
5. can one predict the size of somebody based on his shoe size?
#plot(size~shoesize,data=dat); #strong relation
#summary(m1<-lm(size~shoesize,data=dat));
#plot(m1) #to verify that linear regression is ok
#anova(m1)
#plot(size~shoesize,data=dat); #strong relation
#abline(m1$coeff)
6. Are eye and hair colors independant?
#chisq.test(dat$eyecol,dat$haircol,simulate=T)
#fisher.test(dat$eyecol,dat$haircol)
7. Are smokers heavier than non-smokers?
#t.test(weight~smoker,data=dat)
8. does answer to 7 depend on sex?
#anova(m2<-lm(weight~smoker*sex,data=dat)) #no effect of smoking status, nor interaction
9. Does size differ according to hair colour? 
#oneway.test(size~haircol,data=dat)
10. Does the weight of boys and girls differ? does this depends on their respective size?
#anova(m3<-lm(weight~sex,data=dat))  #strong effect of sex
#anova(m3f<-lm(weight~sex*size,data=dat)) #interaction ns, can simplify model<-ANCOVA
#anova(m3s<-lm(weight~sex+size,data=dat)) #at same size, there is still a sex effect
11. Does the smoking status depends on sex?
#chisq.test(dat$sex,dat$smoker)         #NS