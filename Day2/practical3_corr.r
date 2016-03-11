---------------------------------------------------------------------------------------------------
Questions

   1a. Load the file http://www.unil.ch/popgen/teaching/R11/data_etudiants_biol_0506.txt
   
#dat<-read.table("http://www.unil.ch/popgen/teaching/R11/data_etudiants_biol_0506.txt",header=TRUE)   
   
   1a1. Rename columns with more meaningful names (e.g. sex, height, weight, shoesize etc...)
#names(dat)<-c("sex","height","weight","shoesize","eyecol","haircol","hairlength","smoker")
   
   1b1. Produce a bar chart of the proportion of each sex and the proportion of the different
       hair colors; produce a bar chart of the proportion of smoking men, non smoking men,
       smoking women, non-smoking women (use barplot; hint: you might need to use the table function)
#    barplot(table(dat$sex),col=c("pink","blue"))
#	 barplot(table(dat$haircol))
#    sex.smok<-paste(dat$sex,dat$smoker,sep=":")
#    barplot(table(sex.smok))
#or, using latice:	
#histogram(~sex,data=dat)
#histogram(~haircol,data=dat)
#histogram(~smoker:sex,data=dat)       
       
   1b2. Produce a piechart of the  proportion of eye colors
#pie(table(dat$eyecol))
#pie(table(dat$eyecol),col=c("blue","brown","black","green"))
   
   1b3. Produce a boxplot of sizes as a function of sex
#boxplot(height~sex,data=dat)
       
   1c. Plot the scatterplot of weigths  against height , using the sex
   of individuals as label, and labelling your axes. Use a different color for each sex.
   Explore the different arguments of the plot function: add a title, play with the
   size of characters.  Try adding the regression line for males and that of females to the graph, using different colors for each
   sex.   From this graph, would you say that the relation between weight and size differ between the two sexes? Which statistical test would be appropriate to test this hypothesis?
   

#plot(weight~height,data=dat,type="n");text(weight~height,labels=sex,col=as.integer(sex),cex=0.8,data=dat)
# lmf<-lm(weight~height,data=dat[dat$sex=="F",])
# lmm<-lm(weight~height,data=dat[dat$sex=="M",])
# abline(lmf$coeff,col=1)
# abline(lmm$coeff,col=2)
 
   [optional]. produce a similar graph using xyplot from the lattice package, and adding
       a separate regression line for men and women.
	   
#xyplot(weight~height,group=sex,type=c("p","r"),col=c("red","blue"),pch=c("F","M"),data=dat)       
       
   1e. Produce a box plot of weight as a function of the smoking status and sex 
	   
#boxplot(weight~sex.smok,data=dat)	   

 [optional] produce a similar plot (bwplot) using lattice, with sex as the grouping factor

#bwplot(weight~smoker|sex,data=dat)   

   1f.  Produce a two panels graph (a panel for males and the other for females)
   of the scatterplot of weight versus height. Differentiate smokers from non smokers using a color argument
   
#par(mfrow=c(1,2))
#plot(weight~height,col=smoker,data=dat[dat$sex=="M",],main="Males")
#plot(weight~height,col=smoker,data=dat[dat$sex=="F",],main="Females")
   
   
   [optional] Produce a two panels graph (a panel for males and the other for females)
   of the scatterplot of weight versus size using xyplot from the lattice package.
   Differentiate smokers from non smokers using the group argument,  and change
   the default layout of xyplot by putting the panels on top of each other (use the option layout).

#xyplot(weight~height|sex,group=smoker,data=dat,col=c("black","green"),pch=c("o","n"),layout=c(1,2) )
   
   2. What is the correlation between weight and size in men? women? And the covariance?
#with(dat[dat$sex=="M",],cor(weight,height,use="complete.obs"))
#with(dat[dat$sex=="F",],cor(weight,height,use="complete.obs"))
#with(dat[dat$sex=="M",],cor(weight,height,use="complete.obs"))
#with(dat[dat$sex=="F",],cor(weight,height,use="complete.obs"))
   3. load the file 
   http://www.unil.ch/popgen/teaching/R11/scatt.txt
#d2<-read.table("http://www.unil.ch/popgen/teaching/R11/scatt.txt",header=T)
   
   in a four panels windows (2 times 2) draw the scatterplot of y1,y2,y3 and y4
   as a function of x. what relation between the ys and x do they show?
#par(mfrow=c(2,2));plot(d2$x,d2$y1);plot(d2$x,d2$y2);plot(d2$x,d2$y3);plot(d2$x,d2$y4)   
   
   What is the correlation between x and y1, y2, y3 and y4?
#cor(d2)[,1]
   
   4. Use abline to add a line that best predict the different y as a function
   of x (you ll have to redraw the preceding graphs). Use the lsfit or the lm function , and its element coeff to obtain the least square/linear model  best fit. 
#par(mfrow=c(2,2))
#plot(d2$x,d2$y1);abline(lsfit(d2$x,d2$y1)$coeff)
#plot(d2$x,d2$y2);abline(lsfit(d2$x,d2$y2)$coeff)
#plot(d2$x,d2$y3);abline(lsfit(d2$x,d2$y3)$coeff)
#plot(d2$x,d2$y4);abline(lsfit(d2$x,d2$y4)$coeff)   
   
   
   5. what are the 10th and 90th percentile of y5?  plot the scatter diagram of
   y5 versus x.  What type of relation exists between the 2? use lsfit and
   abline to produce the best linear fit line. 
#quantile(d2$y5,c(0.1,0.9))
#par(mfrow=c(1,1));plot(d2$x,d2$y5);abline(lsfit(d2$x,d2$y5)$coef)  
  ??? Why is lsfit and lm different??
   
   6. Store the predicted value of y5 in a vector y5.pred.
   what are the residuals of the regression of y5 on x? store this in y5.res

#fit.y5<-lsfit(d2$x,d2$y5)
#y5.pred<-fit.y5$pred
#y5.res<-fit.y5$res   
   
   7. plot the residuals as a function of x, and comment the graph.

   #plot(d2$x,y5.res) #clear pattern in residuals 

   8. do questions 6 & 7 for variable y4.
   Is showing residuals as a function of x useful? Why?

#fit.y4<-lsfit(d2$x,d2$y4)
#y4.pred<-fit.y4$pred
#y4.res<-fit.y4$res   
#plot(d2$x,y4.res) 
   
   