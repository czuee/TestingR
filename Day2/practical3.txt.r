 Basic graphing functions, scatter plot and regression

 
We have already met some of the graphic functions in R (hist, boxplot...).
We will now see the plot function in more details. 

Before anything, you need to define a graphic windows. on windows, use windows(),
on mac, use quartz(), on unix/linux, use X11(); 

Plots can also be sent directly
to specific files, without being printed on screen. available devices are
pdf(), postscript(),png(),jpeg() among others. once you call such a device,
you need to close it, by using the function dev.off(). pdf & postscript 
can have multiple pages, but not the others. 



For drawing any function, use plot:

x<--10:10
plot(x,sin(x))

What is the difference between the previous and the following command?

plot(sin(x))


The plot instructions contains numerous options (?plot for more).
For instance, one can gives labels to the axes, a title, the printing color and symbols  etc..


x<-seq(-10,10,0.01) #more on seq soon
plot(x,(x^3+2*x^2-3*x+1)/(2*x^2+5*x-12),ylab="f(x)")

x<-seq(0,4,0.1)
plot(x,exp(-(x^3+2*x^2-3*x+1)),ylab="exp(f(x))")

x<-seq(0,4,0.01)
plot(x,exp(-(x^3+2*x^2-3*x+1)),ylab="exp(f(x))",col="red")

plot default is to use points. using the type option, we can specify whether we
want points and lines (type="b") or a line (type="l") or nothing (type="n"):


x<-seq(-10,10,0.01)
plot(x,(x^3+2*x^2-3*x+1)/(2*x^2+5*x-12),type="b")
plot(x,(x^3+2*x^2-3*x+1)/(2*x^2+5*x-12),type="l")
plot(x,(x^3+2*x^2-3*x+1)/(2*x^2+5*x-12),type="n") #Nothing plotted!

If you want to see the 2 graphs in one window, you can specify the numbers of panel
to show, using the par function (see ?par):

par(mfrow=c(2,1))
x<-seq(-10,10,0.01)
plot(x,(x^3+2*x^2-3*x+1)/(2*x^2+5*x-12))
plot(x,(x^3+2*x^2-3*x+1)/(2*x^2+5*x-12),type="l")
par(mfrow=c(1,1))#to go back to one panel

We can also add several functions to the same graph. After first using plot,
which will define the first things to be printed and axes length, labels etc,
you can use the functions lines, text or points:

x<-seq(0,2,0.05)
ymax<-10
plot(x,x,ylim=c(0,ymax),ylab="f(x)")
lines(x,x^0.5,col="blue")
points(x,x^2,col="red")
text(x,x^3,labels="3",col="green")
segments(1,1^0.5,1,3)
Note that several call to plot will erase each other in turn.

plot is of course useful for showing scatter plot of 2 variables,
but could also be used for a single vector:
a<-rnorm(100);
plot(a)
b<-which(abs(a)>1.96)
#now create a vector specifying a red color for values
#larger than 1.96
coul<-rep("black",1000);
coul[b]<-"red"
points(a,col=coul) #print these points in red
lines(a,type="h",col=coul) #type="h" draws a vertical bar from the x axis

Other useful plots are histograms, barplots and piecharts (for categorical data):

hist(a)head(ppl)

categ<-rep(c("white","black","red"),c(20,20,40))
#We first need to make a count of the number of each color, using table: table(categ) #orders titles alphabetically
tcateg<-table(categ)

barplot(tcateg,col=c("black","red","white"))
pie(tcateg,col=c("black","red","white"))

 colours() #All colour names

#For a tour of R graphics ability, type:
#### Check later ###
demo(graphics)



variance, covariance and correlations are obtained using var, cov and cor respectively.
It is possible to use these functions to obtain the correlation between 2 vectors,
or all variables (columns) of a data frame:

cor(x,y);
cor(d);

These functions dont like missing data.
If you have such data, you need to specify how to remove them.
You could either remove the whole line containing one missing observation,
(use="complete.obs"), or eliminate them only when they turn up in a calculation
(use="pairwise.complete.obs"). Compare the results of the following instructions:

x<-c(1,2,3,4,NA); y<-c(1,2,3,4,-100); z<-c(4,3,2,1,10)
d<-data.frame(cbind(x,y,z))
cor(d, use="complete.obs")
cor(d, use="pairwise.complete.obs")
cor(d) #See all correlations

mean(x,na.rm=TRUE)
 
these functions return one element only (a number or a matrix. More complex functions,
for instance lsfit (?lsfit) or lm (?lm), return a list of elements. To access each element individually use $.
For instance:

fit<-lsfit(x,y)
fit$coef

lm(y~x)$coef

To get the names of all the elements of an object, use names().

A word on lsfit.  It allows to estimate, using least square,
 the slope and intercept
of a a regression line Y=a+X*b  
The intercept a is the value of Y for which X=0.
The slope express how many units will Y varies when X changes one unit.  
We will see lm in more details later


Also note that the package lattice :

library(lattice)

?lattice

has yet more options and capabilities:

demo(lattice)
Although its syntax is a bit cumbersome, it is extremely powerful for visualising
your data.

last, 2 books specifically about R graphics:

Murrell Paul (2006) R Graphics:
http://www.stat.auckland.ac.nz/~paul/RGraphics/rgraphics.html

Sarkar Deepayan (2008) lattice: Multivariate data visualization with R
http://books.google.com/books/about/Lattice.html?id=gXxKFWkE9h0C


---------------------------------------------------------------------------------------------------
Questions

   1a. Load the file http://www.unil.ch/popgen/teaching/R11/data_etudiants_biol_0506.txt
  1a1. Rename columns with more meaningful names (e.g. sex, height, weight, shoesize etc...)
   1b1. Produce a bar chart of the proportion of each sex and the proportion of the different
       hair colors; produce a bar chart of the proportion of smoking men, non smoking men,
       smoking women, non-smoking women (use barplot; hint: you might need to use the table function)
   1b2. Produce a piechart of the  proportion of eye colors
   1b3. Produce a boxplot of sizes as a function of sex
   1c. Plot the scatterplot of weigths  against height , using the sex
   of individuals as label, and labelling your axes. Use a different color for each sex.
   Explore the different arguments of the plot function: add a title, play with the
   size of characters.  Try adding the regression line for males and that of females to the graph, using different colors for each
   sex '????'.   From this graph, would you say that the relation between weight and size differ been the two sexes? Which statistical test would be appropriate to test this hypothesis?
   [optional]. 

male.wt<-c(ppl$poids)[ppl$sex=="M"]
male.ht<-c(ppl$taille)[ppl$sex=="M"]


produce a similar graph using xyplot from the lattice package, and adding
       a separate regression line for men and women.
xyplot(ppl$taille ~ ppl$poids, groups=ppl$sexe)

   1e. Produce a box plot of weight as a function of the smoking status and sex
sex.smok<-paste(ppl$sex,ppl$smoker,sep=":")
boxplot(weight~sex.smok,data=ppl)

 [optional] produce a similar plot (bwplot) using lattice, with ex as the grouping factor

   1f.  Produce a two panels graph (a panel for males and the other for females)
   of the scatterplot of weight versus height. Differentiate smokers from non smokers using a color argument

par(mfrow=c(1,2))
plot(weight~height, col=smoker, data=ppl[ppl$sex=="M",],main="Males")
plot(weight~height, col=smoker, data=ppl[ppl$sex=="F",],main="Females")

[optional] Produce a two panels graph (a panel for males and the other for females)
   of the scatterplot of weight versus size using xyplot from the lattice package.
   Differentiate smokrs from non smokers using the group argument,  and change
   the default layout of xyplot by putting the panels on top of each other (use the option layout).

   2. What is the correlation between weight and size in men? women? And the covariance?

   3. load the file 
   http://www.unil.ch/popgen/teaching/R11/scatt.txt
   in a four panels windows (2 times 2) draw the scatterplot of y1,y2,y3 and y4
   as a function of x. what relation between the ys and x do they show?
   What is the correlation between x and y1, y2, y3 and y4?

cor(scatt$x,scatt$y1);cor(scatt$x,scatt$y2);cor(scatt$x,scatt$y3);cor(scatt$x,scatt$y4)

4. Use abline to add a line that best predict the different y as a function
   of x (you ll have to redraw the preceding graphs). Use the lsfit or the lm function , and its element coeff to obtain the least square/linear model  best fit. 
plot(scatt$x,scatt$y1)
abline((lsfit(scatt$x,scatt$y1)$coeff),col=2)   

5. what are the 10th and 90th percentile of y5?  plot the scatter diagram of
   y5 versus x.  What type of relation exists between the 2? use lsfit and
   abline to produce the best linear fit line. 
quantile(sc$y5,c(0.1,0.9))
abline(lsfit(sc$x,sc$y5)$coeff,col=2)

   6. Store the predicted value of y5 in a vector y5.pred.
   what are the residuals of the regression of y5 on x? store this in y5.res
   7. plot the residuals as a function of x, and comment the graph.
   8. do questions 6 & 7 for variable y4.
   Is showing residuals as a function of x useful? Why?
