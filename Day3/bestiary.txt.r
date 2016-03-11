TESTS in R

R has builtin functions for carrying out your typical statistical tests. We will 
go through them in this practical. 

#we'll use the following data set to illustrate some of these functions:

dat<-read.table("http://www.unil.ch/popgen/teaching/R11/class2005.txt",header=T)

______________________________________
Chisquare tests:

chisq.test performs chi-squared contingency table tests AND
goodness-of-fit tests.

Usage:

     chisq.test(x, y = NULL, correct = TRUE,
                p = rep(1/length(x), length(x)), rescale.p = FALSE,
                simulate.p.value = FALSE, B = 2000)

#############################################
Note: if you have 2 vectors, each containing the state of the observations 
(for instance, eye and hair colours), you can obtain the contingency tables 
using the table function (?table).  Another useful function is xtabs
##############################################

fisher.test

Fisher's Exact Test for Count Data


     Performs Fisher's exact test for testing the null of independence
     of rows and columns in a contingency table with fixed marginals.


     fisher.test(x, y = NULL, workspace = 200000, hybrid = FALSE,
                 control = list(), or = 1, alternative = "two.sided",
                 conf.int = TRUE, conf.level = 0.95,
                 simulate.p.value = FALSE, B = 2000)


______________________________________
For comparing two empirical distributions, or an empirical distribution 
to a theoretical one

kolmogorov smirnov tests:


     ks.test(x, y, ..., alternative = c("two.sided", "less", "greater"),
             exact = NULL)
             
shapiro.test : for testing normality


__________________________________
T.tests:

t.test(x, y = NULL,
       alternative = c("two.sided", "less", "greater"),
       mu = 0, paired = FALSE, var.equal = FALSE,
       conf.level = 0.95, ...)



t.test(x,mu=0)
t.test(x,y)
t.test(x,y,paired=T)

examples:

  x<-rnorm(30)
  y<-rnorm(30,mean=0.6)
  t.test(x)
  t.test(y)
  t.test(x,y)

Wilcoxon tests:  (non parametric equivalent of t-tests)

wilcox.test(x,y)
wilcox.test(x,y,paired=T)

______________________________________
simple bootstrap percentile confidence intervals:
several functions in package boot. But simple to program

for instance, for a confidence interval of the mean:

bootstrap<-function(x,perc=c(0.025,0.975),nboot=1000){
bm<-vector(length=nboot) #vector where bootstrap samples are stored
n<-length(x)
for (ib in 1:nboot){
dum<-sample(n,replace=T)  #sampling with replacement of the observed vector
bm[ib]<-mean(x[dum],na.rm=T)  #bootstrap sample i of the mean
}
return(list(ci=quantile(bm,probs=perc),bm=bm))
}

x<-runif(1000,min=500,max=1000)
bx<-bootstrap(x);
bx$ci;
par(mfrow=c(1,2))
hist(x)
hist(bx$bm)

_____________________________________
one way ANOVA:
oneway.test(y~A,var.equal=TRUE)
aov(y~A)


testing homogeneity of variance:  

bartlett.test  #strongly depends on the normality assumption
#Do Leven test to assure homogeneity.. if homogeneity cannot be achieved, do permutation

Levene test has to be programmed;
Simple idea:  if variance are heterogeneous, then this should show 
if one does an anova on the absolute values of the residuals: #residuals are deviation of observed value from estimated value
set.seed(12)    #to make sure that you obtain the same results as me
y1<-rnorm(30,mean=2,sd=2)
y2<-rnorm(30,mean=4,sd=10)
y3<-rnorm(30,mean=6,sd=2)
y<-c(y1,y2,y3)
a<-factor(rep(1:3,each=30))  #factor will be further explained below

par(mfrow=c(2,2))
boxplot(y~a)
res<-unlist(tapply(y,a,fun<-function(x) x-mean(x))) #tapply very useful, as is apply and lapply
#unlist is for transforming a list in a vector (providing elements of the list
#are of ths same type)
boxplot(res~a)
boxplot(abs(res)~a) #see the difference in mean/median among the groups ?
summary(aov(abs(res)~a))
#null hypothesis:mean of the group is equal; to test if it is not equal
the car library has a function for this, leveneTest (?leveneTest)

_____________________________________
permutation tests (distribution free ANOVA)

anova.perm<-function(y,x,nperm=100,var.equal=TRUE)
{
obs.f<-oneway.test(y~x,var.equal=var.equal)$statistic
bf<-numeric(length=nperm)
bf[nperm]<-obs.f
for (i in 1:(nperm-1)){
bf[i]<-oneway.test(y~sample(x),var.equal=var.equal)$statistic #sample(x) shuffling
}
return(list(p.val=sum(bf>=bf[nperm])/nperm, bf=bf))
}

y<-rnorm(100)
x<-factor(rep(1:4,each=25))
oneway.test(y~x,var.equal=TRUE)
res<-anova.perm(y,x)

_____________________________________

Kruskal Wallis:
kruskal.test(y~A)
kruskal.test(list)
kruskal.test(y,A)

______________________________________________________________________
Correlation

cor.test
     Test for association between paired samples, using one of
     Pearson s product moment correlation coefficient, Kendall's tau or
     Spearman's rho.

Usage:

     cor.test(x, ...)

     ## Default S3 method:
     cor.test(x, y,
              alternative = c("two.sided", "less", "greater"),
              method = c("pearson", "kendall", "spearman"),
              exact = NULL, conf.level = 0.95, ...)

#pearson is classical correlation, spearman is the correlation on obs ranks
x<-rnorm(10)
y<-rnorm(10)+x
cor(x,y) #pearson
cor(x,y,method="spearman") #same as 
cor(rank(x),rank(y))
#kendall is more complicated, it's the difference in concordant vs discordant pairs of obs



######################################################################
_______________________________________________________________________
FORMULAE in R

The operator ~ is used to define a model formula in R.

It means: explain what's on the left of ~ by what's on teh roght of ~

Suppose y, x, x0, x1, x2, ... are numeric variables, X is a matrix and A, B, C, 
... are factors (?factor). 
The following formulae on the left side below specify 
statistical models as described on the right.

y ~ x
y ~ 1 + x
    Both imply the same simple linear regression model of y on x. The first has 
    an implicit intercept term, and the second an explicit one.
    
y ~ 0 + x 
y ~ -1 + x
y ~ x - 1
    Simple linear regression of y on x through the origin (that is, 'without an 
    intercept' term).
log(y) ~ x1 + x2
    Multiple regression of the transformed variable, log(y), on x1 and x2 
    (with an implicit intercept term).
y ~ 1 + x + I(x^2)
    Polynomial regression of y on x of degree 2. 
y ~ A
    Single classification analysis of variance model of y, with classes 
    determined by A.
y ~ A + x
    Single classification analysis of covariance model of y, with classes 
    determined by A, and with covariate x.
y ~ A*B
y ~ A + B + A:B
y ~ A+ B %in% A #Nesting
y ~ A/B
    Two factor non-additive model of y on A and B. The first two specify 
    the same crossed classification and the second three specify the same 
    nested classification. 
y ~ (A + B + C)^2
y ~ A*B*C - A:B:C
    Three factor experiment but with a model containing main effects and 
    two factor interactions only. Both formulae specify the same model.
y ~ A * x
y ~ A/x
y ~ A/(1 + x) - 1
    Separate simple linear regression models of y on x within the levels of A, 
    with different codings. The last form produces explicit estimates of as 
    many different intercepts and slopes as there are levels in A.
y ~ A*B + Error(C)
    An experiment with two treatment factors, A and B, and error strata 
    determined by factor C. For example a split plot experiment, with whole 
    plots (and hence also subplots), determined by factor C. 
    
cbind(y1,y2,y3) ~ A  

     formula for MANOVA    
__________________________________________________

Linear models (Regression, multiple regressions, ANOVAs, ANCOVAs)

The basic function for fitting ordinary multiple models is lm(), and a 
streamlined version of the call is as follows:

      fitted.model <- lm(formula, data = data.frame)

For instance

fm2 <- lm(y ~ x1 + x2, data = dat) 

would fit a multiple regression model of y on x1 and x2 (with implicit intercept term).

#careful, sequential fit
#if x1 & x2 correlated, lm(y~x1+x2) !=lm(y~x2+x1)



  x1<-rnorm(100,mean=10,sd=2)
  x2<-rnorm(100,mean=5,sd=3)
  y<-8*x1+rnorm(100,sd=5)
  dat<-data.frame(y=y,x1=x1,x2=x2)
  fm2 <- lm(y ~ x1 + x2, data = dat)
  summary(fm2)
  anova(fm2)      

  fm1<-lm(y~x1,data=dat)
  anova(fm2,fm1)

  par(mfrow=c(2,2)) #diagnostic plots, essential to check
  plot(fm1)
  par(mfrow=c(1,1))
  
#Scale-Location graph: Hetero-scalasticity; Residuals vs Leverage - for outliers
  

Generic functions for extracting model information

The value of lm() is a fitted model object; technically a list of results of class "lm". 
Information about the fitted model can then be displayed, extracted, plotted and 
so on by using generic functions that orient themselves to objects of class "lm". 
These include

     add1    deviance   formula      predict  step
     alias   drop1      kappa        print    summary
     anova   effects    labels       proj     vcov
     coef    family     plot         residuals

A brief description of the most commonly used ones is given below.

anova(object_1, object_2)
    Compare a submodel with an outer model and produce an analysis of variance table.



summary(object)
    Print a comprehensive summary of the results of the regression analysis.

coef(object)
    Extract the regression coefficient (matrix).

    Long form: coefficients(object).


plot(object)
    Produce four plots, showing residuals, fitted values and some diagnostics.


predict(object, newdata=data.frame)
    The data frame supplied must have variables specified with the same labels as 
    the original. The value is a vector or matrix of predicted values corresponding 
    to the determining variable values in data.frame.


residuals(object)
    Extract the (matrix of) residuals, weighted as appropriate.

    Short form: resid(object).


step(object)
    Select a suitable model by adding or dropping terms and preserving hierarchies. 
    The model with the largest value of AIC (Akaike s An Information Criterion) 
    discovered in the stepwise search is returned.

__________________________________________________________
Generelized linear models:

glm(formula, family=gaussian)

     family can be one of:
     binomial(link = "logit")
     gaussian(link = "identity")
     Gamma(link = "inverse")
     inverse.gaussian(link = "1/mu^2")
     poisson(link = "log")
     quasi(link = "identity", variance = "constant")
     quasibinomial(link = "logit")
     quasipoisson(link = "log")

__________________________________________________________
For mixed models (with a mixture of fixed and random effects), 
use package lme4:

library(lme4)
?lmer


_____________________________________________________
multivariate tests:

manova(cbind(y1,y2,y3)~A))

prcomp() for PCA, but better to use package ade4:

library(ade4)
?dudi.pca

_______________________________________________________

Questions

Answer these questions using the file class2005.txt at URL:

http://www2.unil.ch/popgen/teaching/R11/


1. average size of the class? for males? for females?
> ppl<-read.table("http://www2.unil.ch/popgen/teaching/R11/class2005.txt", header=TRUE)
> mean(ppl$size, na.rm=T)
[1] 172.68

2. are the size normally distributed? qqplot
Not sure

3. confidence interval for the average size
> bx<-bootstrap(ppl$size)
> bx$ci
2.5%    97.5% 
  170.0400 175.1411 
hist(bx$bm)
> qqnorm(bx$bm)
> qqline(bx$bm)
hist(ppl$size)

4. correlation between weight and size?
> cor.test(ppl$size,ppl$weight)

Pearsons product-moment correlation

data:  ppl$size and ppl$weight
t = 7.1766, df = 46, p-value = 4.954e-09
alternative hypothesis: true correlation is not equal to 0
95 percent confidence interval:
0.5578563 0.8378944
sample estimates:
cor 
0.7267901 

5. can one predict the size of somebody based on his shoe size?

> cor(ppl$size,ppl$shoesize,use="complete.obs")
[1] 0.8432263
plot(ppl$size~ppl$shoesize)
fit<-lm(ppl$size~ppl$shoesize)
abline(fit, col=2)

6. Are eye and hair colors independant? NO


7. Are smokers heavier than non-smokers?
t.test(weight~smoker,data=ppl)
anova(lm(weight~smoker, data=ppl))
Analysis of Variance Table

Response: weight
Df Sum Sq Mean Sq F value Pr(>F)
smoker     1   79.7  79.669  0.7487 0.3913
Residuals 47 5001.4 106.413  

8. does answer to 7 depend on sex?
boxplot(weight~smoker*sex, data=ppl)

anova(lm(weight~smoker*sex, data=ppl))
Analysis of Variance Table

Response: weight
Df  Sum Sq Mean Sq F value    Pr(>F)    
smoker      1   79.67   79.67  1.9447    0.1700    
sex         1 3142.31 3142.31 76.7014 2.793e-11 ***
  smoker:sex  1   15.56   15.56  0.3798    0.5408    
Residuals  45 1843.56   40.97     

9. Does size differ according to hair colour? 
boxplot(size~haircol, data=ppl)

anova(lm(size~haircol, data=ppl))
Analysis of Variance Table

Response: size
Df Sum Sq Mean Sq F value Pr(>F)
haircol    4  250.2  62.540  0.8178 0.5208
Residuals 44 3364.8  76.473 

10. Does the weight of boys and girls differ? does this depends on their respective size?

weigth & size are highly correlated
weight & sex are highly correlated
size & sex are higly correlated
weight~sex*size is not very strongly correlated

Analysis of Variance Table

Response: weight
Df  Sum Sq Mean Sq F value    Pr(>F)    
sex        1 3111.13 3111.13 83.2913 1.036e-11 ***
  size       1  186.31  186.31  4.9880   0.03066 *  
  sex:size   1    1.54    1.54  0.0412   0.84014    
Residuals 44 1643.50   37.35

11. Does the smoking status depends on sex?

smok.sex<-table(ppl$smoker,ppl$sex)
> chi.test(smok.sex)
