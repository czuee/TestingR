Functions in R 	

R has by default several builtin functions (mean, var, cor, plot, lm, ...).
And several more can be downloaded from http://www.r-project.org as packages.
But you might (will) need to write your own functions to carry out a repetitive task.
The basic concepts are very similar to those youve learned for any other programming
languages, such as c++, java or fortran. This practical should give a first brief
feel of function writing in R. 


General structure of a function:

    my.function<-function(x,y){
    instruction 1
    instruction 2
    .
    .
    .
    instruction n
    }

Once it has been typed in, it is used as:

my.function(a,b)

where a and b are the two arguments to pass to the function. 
An example will clarify things:

    my.mean<-function(a){
    return(sum(a)/length(a))
    }
 
    my.mean(1:10)
    
    my.var<-function(a){
    n<-length(a)
    m<-sum(a)/n
    va<-sum((a-m)^2)/n
    return(va)
    }

    my.var(1:10)
    
In this function, the return(va) on the last line allows returning va
(try writing this function without the return statement). You will notice that
this last function does not give the same results as the builtin var function.
Why?  Looking at the help for var will give it away: the builtin var produces
an unbiased variance, that is, the divider is (n-1) rather than n.
We could rewrite our function as:

    my.var.ub<-function(a){
    n<-length(a)
    m<-sum(a)/n
    va<-sum((a-m)^2)/n
    va<-n/(n-1)*va
    return(va)
    }

    my.var.ubb<-function(a){
    n<-length(a)
    va<-my.var(a)*n/(n-1)
    return(va)
    }
    

Ideally, our function should let us choose whether we want the variance 
with or without bias. We can use an if instruction in the body of the 
function to tell it what to return:

    my.var.n<-function(a,bias=TRUE)
    {
    n<-length(a)
    m<-sum(a)/n
    va<-sum((a-m)^2)/n 
    if (!bias) {
    va<-va*n/(n-1)
    }
    return(va)
    }
    
    my.var.n(1:10)
    my.var.n(1:10,bias=FALSE)
    var(1:10)
    
In this function, bias is a boolean.  By default, the biased variance is calculated,
then the if statement is evaluated, and the unbiased variance is calculated if
bias is false (! stands for negation). If we want the biased variance, we dont
need to tell it to R, the default for bias is FALSE.    

The control structures for R are:


    if (cond) expr      (If cond is true, do expr)

    if (cond) expr1 else expr2 (if cond is TRUE, do expr1 else do expr2)

    if (cond) {cons.expr1; cons.expr2} else {alt.expr1; alt.expr2} (same as before
    but with several expression for each situation. Note the curly brakets 
    around the expressions)

    for(i in seq) expr (do expr as many times as there are element in seq. 

    x<-1:10
    for (i in 1:10) x[i]<-i+1 #2:11

    while(cond) expr (do expr as long as cond is true)

    repeat { expr; if (cond) break } (do expr as long as cond is FALSE, therefore as
    long as we do not enter in the if statement. Beware, break is a necessity
    if you don t want to go in an infinite loop)

To print the square of the 20 first integers, we could write:

    for (i in 1:20) {
    cat(i,i^2,"\n")
    }
    #for details on cat, ?cat. "\n" is the "return" character.

to print sequentially the sum of the first 10 integers:

    i<-0;j<-0;
    repeat{
    i<-i+1; j<-j+i;
    cat(i,j)#,"\n");
    if (i>=10) {
    break}
    }

i<-0;j<-0;
while(i<10){
i<-i+1;j<-j+i;
}

Compare the result with cumsum(1:10).

Note: the ; allows to put several expressions on the same line. 


More information on writing functions can be found in several online tutorials:

http://cran.r-project.org/doc/manuals/R-intro.html#Writing-your-own-functions

http://zoonek2.free.fr/UNIX/48_R/02.html

http://cran.r-project.org/doc/contrib/Paradis-rdebuts_en.pdf

Integral division: % / %
Quotient  5% / %3=1 
Remainder 5 % % 3 = 2
_____________________________________________ 
Questions

   1. Obtain the mean, median, variance and mad of the following observations:
   50; 60; 10; 20; 10; 40; 30; 800; 30; 40; 10
   2. Redo the calculations without the outlier. Conclusions?
   3. Redo these calculations without using the R builtin functions
   [Reminder: the median is the value of the data that split them in 2 equal parts.
   If the number of data points is odd, the median is the value of the (nth+1)/2 largest datum,
   and it s the mean between the (nth/2 and (nth/2+1) if the number of data points
   is even; and MAD=med(abs(x(i)-med(x))]

   4. Load the file class05.xls from
   http://www.unil.ch/popgen/teaching/R11/class2005.xls
     
     How many non smoking students in this data set? 35 how many different hair color? 5
   5. Draw a histogram of sizes. Are the different size classes equifrequent?
   
   6. Plot the empirical cumulative distribution of sizes (use plot and sort).
   Using this plot, estimate the 30th and 70th percentile of the distribution of
   sizes.
   6b. use histogram and qqnorm (?qqnorm) and qqline to check whether sizes are 
   normally distributed. Which is better?  How would you test for normality?
val<-seq(0,0.98,0.02)
plot(val,sort(ppl$taille))
   7. Use quantile to validate your approximation for question 6

   8. What's the mean weight? estimate it in kg then in gr (you don't need to use R to estimate it in gr).
   9. What's the weight variance in kg^2? in gr^2? (you don't need to use R to estimate it in gr^2)
   
   10. rescale the variable weight so that it has mean 0 and sd 1. Why is this transformation useful?
       what is the 2.5th and 97.5th percentile of the rescaled weight?
mean(ppl$poids),na.rm=TRUE)
red.mean<-(ppl$poids-64.34694)
mean(red.mean, na.rm=TRUE)
sd(ppl$poids, na.rm=TRUE)
red.sd=(red.mean/10.28865)
sd(red.sd, na.rm=TRUE)
   
  
para.auto<-function(a){
  print("Mean:"mean(a),)
  }
  
my.mean<-function(a){
  m<-(sum(a)/length(a))
  return(m)
}

my.median<-function(a){
  l<-length(a)
  x<-sort(a) 
  s<-ceiling(length(a)*0.5) #2nd quantile
  return(x[s])
}

my.mad<-function(a){
  med<-my.median(a)
  p<-(1.4826*abs(a-med))
  md<-my.median(p)
  print(md)
}