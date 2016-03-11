#Swirl tutorial - 2. Regression

#1.Introduction
#Data is from John Verzani's website, http://wiener.math.csi.cuny.edu/UsingR/.

plot(child ~ parent, galton)
plot(jitter(child,3) ~ parent, galton) #by using R's function "jitter" on the children's heights, 
                    #we can spread out the data to simulate the measurement errors and make high frequency heights more visible.
plot(jitter(child,4) ~ parent, galton)
regrline <- lm(child ~ parent, galton)
abline(regrline, lwd=3, col='red')
summary(regrline)

#The slope of the line is the estimate of the coefficient, or muliplier, of "parent", the independent variable of our data
# (in this case, the parents' heights). From the output of "summary" what is the slope of the regression line? 
#What is the standard error of the slope?

#A coefficient will be within 2 standard errors of its estimate about 95% of the time. This means the slope of our
# regression is significantly different than either 0 or 1 since (.64629) +/- (2*.04114) is near neither 0 nor 1.

#The slope of a line shows how much of a change in the vertical direction is produced by a change in the horizontal
# direction. So, parents "1 inch" above the mean in height tend to have children who are only .65 inches above the mean. The
# green triangle illustrates this point. From the mean, moving a "1 inch distance" horizontally to the right (increasing the
                                                                                                              | parents' height) produces a ".65 inch" increase in the vertical direction (children's height).


   