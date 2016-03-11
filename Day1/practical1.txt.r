INTRO:


For connection via your own laptop,  pick the guest-unil network,
connect to the internet and enter the following guestpass:

XXXXX


Moodle site

http://moodle2.unil.ch/enrol/instances.php?id=3333

Inscription key: IntroR14

Material available from:


################################################################################
This course:

The goal is not to learn statistics (I expect you to know your basic stats), but how 
to use R to do stats and other things.  Focus will be on loading and manipulating data,
writing function, plotting graphs, using packages, searching informations.

Way it's gonna be run: each half day, short intro (1/2 to 1 hour max) followed
by practical.  4 assistants will be here to help you  during the practicals.  
Use them!

Assessment:  A practical test Friday afternoon (2 hours).

Program 

Tuesday am  Introductory turorial  (practical1.R)
Tuesday pm   Data manipulation in R: vectors, matrices, list et data frames (p2.R)
Tuesday 17h00: Welcome apero 

Wednesday am  Basic graphing functions (p3.R)
Wednesday pm  Functions in R 	(p4.R)

Thursday am   Functions in R (cont)
Thursday pm   Stats functions / bootstrap & randomization

Friday am   Stats function bestiary
Friday pm   Some packages (ade4,  ...) + test

################################################################################

What is R:  http://stat.ethz.ch/CRAN/doc/FAQ/R-FAQ.html

R editors:

Why an editor?  syntax highliting, plus avoid re-typing commands...

For All systems: RStudio ( http://www.rstudio.com/ )

For windows:  Tinn-R, Notepad++ 

For linux: ess (emacs speaks statistics) distributed as an R package, Vim,...

For Mac: Textmate or the online editor

a more extensive list: http://www.sciviews.org/_rgui/projects/Editors.html

################################################################################
Installing R   : Binaries for windows, macOs X, several brends of linux and source code available from 

http://stat.ethz.ch/CRAN

extra packages to extend R: from the same URL. 
Currently (Monday August 25, 2014), the CRAN package repository features 5826 available packages

R Home page for further information etc... (bookmark this link!)

http://www.r-project.org/

Search Engine specific for R:

http://www.rseek.org/
############################################################
Much on CRAN in forms of tutorial, FAQ, etc...

Books:   a lot available from CRAN

http://www.r-project.org/doc/bib/R-books.html

################################################################################
################################################################################
################################################################################


One of the best ways to getting acquainted with R is to use it to help you to
understand a particular set of data. So let us consider data issued from a lottery, where
you might be motivated to perform data analysis. The readers are invited to work through
the following familiarization session and see what happens. First-time users may not yet
understand every detail, but the best plan is to type what you see and observe what
happens as a result.

This chapter is mainly based on Becker, Chambers and Wilks's book (1988, The New
S Language, Chapter 1).

The specific data we will look at concerns the New Jersey Pick-It Lottery. Our data is
for 254 drawings just after the lottery was started, from May, 1975 to March, 1976. Pick-
It is a parimutuel game, meaning that the winners share a fraction of the money taken
in for the particular drawing. Each ticket cost fifty cents and at the time of purchase the
player picks a three-digit number ranging from 000 to 999. The money bet during the
day is placed in a prize pool and anyone who picked the winning number shares equally
in the pool. The data is in the file lottery.txt 



It can be loaded in R using the following command:

> data<-read.table("http://www2.unil.ch/popgen/teaching/R11/lotery.txt",header=TRUE)

> data #print the dataset on screen

If you want to see only the first few lines:

>head(data)



The data available gives for each drawing the winning number and the payoff for a
winning ticket. The winning numbers and the corresponding payoffs are:

> data$number # print the winning numbers

> data$payoffs # print the payoffs

From these instructions we notice that, for the first drawing, the winning
number was 810 and it paid $190.00 to each winning ticket holder. In what follows we
will try to examine the data. Numerical summaries provide a statistical synopsis of the
data in a tabular format. Such a function is summary. The following displays a summary
of the lottery payoffs:

> summary(data$payoffs)

Min.	1st Qu.	Median	Mean	3rd Qu.	Max.
83	194.2	270.2	290.4	364	869.5

We read from this that the mean payoff was $290.4, that the payoffs ranged from $83 to
$869.5 and that 50% of all payoffs lay between $194.2 and $364. The quantiles for a set
of data x can also be computed by means of quantile(x, quantiles). For example,

> quantile(data$payoffs, c(.25, .75))

25%	75%
194	25 364

This means that 25% of the values are less than 194, and 75% of the payoffs are less than
365.
A better way to understand the data is to look at it graphically. On windows, R will open
one automatically for you, but if you want a new one, just type:

> windows()

A separate window should appear on your screen. If you have a mac, type:

> quartz()

or Unix/linux:

> X11()

In our data, to detect long-term irregularities we will look at the winning numbers to
see if they appear to be chosen at random. To do so we could produce a histogram of the
lottery numbers:

> hist(data$number)

The histogram should show on your screen. Since there are 10 bars, the count should be
approximately 25.
It looks fairly flat, no need to inform a jury.
Of course, most of our attention will probably be directed at the payoffs. Elementary
probabilistic reasoning tells us that a single number we pick has a 1 in 1000 chance of
winning. If we play many times, we expect about 1 winning number per 1000 plays. Since
a ticket costs fifty cents, 1000 plays will cost $500, so we hope to win at least $500 each
time we win, otherwise we will lose money in the long run. So, let us make a histogram
of the payoffs.

> hist(data$payoffs)

The figure shows that payoffs range from less than $100 to more than $800, although the
bulk of the payoffs are between $100 and $400, i.e. there were a number of payoffs larger
than $500. Perhaps we have a chance. The widely varying payoffs are primarily due to
the parimutuel betting in the lottery: if you win when few others win, you will get a large
payoff. If you are unlucky enough to win along with others, the payoff may be relatively
small.

Let us see what the largest and the smallest payoffs and corresponding winning numbers
were:

> max(data$payoffs) # the largest payoff

[1] 869.5

> data$number[data$payoffs==max(data$payoffs)]

[1] 499

> min(data$payoffs) # the smallest payoff

[1] 83

> data$number[data$payoffs==min(data$payoffs)]

[1] 123

Winners who bet on `123' must have been disappointed; $83 is not a very large payoff.
On the other hand $869.50 is very nice. Since the winning numbers and the payoffs
come in pairs, a number and a payoff for each drawing, we can produce a scatterplot of
the data to see if there is any relationship between the payoff and the winning number.
R provides a generic plotting function, plot, which produces different kinds of plots
depending on the data passed to it. In its most common use, it produces a scatterplot of
two numeric objects:

> plot(data$number, data$payoffs)

What do you see in the graph? Does the payoff seem to depend on the position of
the winning number? Perhaps it would help to add a `middle' line that follows the overall
pattern of the data:

> lines(lowess(data$number, data$payoffs, f=.2))

This command superimposes a smooth curve on the winning number and payoff scatterplot.
Can you see the interesting characteristics now?
There are substantially higher payoffs for numbers with a leading zero, meaning fewer
people bet on these numbers. Perhaps that reflects people's reluctance to think of numbers
with leading zeros. After all, no one writes $010 on a ten dollar check! Also note
that, expect for the numbers with leading zeros, payoffs seem to increase as the winning
number increases. 
It would be interesting to see exactly what numbers correspond to the
large payoffs. Fortunately, with an interactive graphical input device, we can do that by
simply pointing at the `outliers':

> identify(data$number, data$payoffs, data$number) #might not work on all platforms

To identify a payoff with its corresponding winning number just click on a point using the
left mouse button. Once you have pointed out the `outliers' just click on the middle mouse
button. Can you see the pattern in the numbers with very high payoffs?

As a little help it is to say that the lottery has a mode of betting, called `combination
bets' where players win if the digits in their number appear in any order (Ticket 123
would win on 321, 231). The pattern in the numbers is that most of the numbers with
high payoffs have duplicate digits. This results from the fact that payoffs for the numbers
with duplicate digits are not shared with combination betters, and thus are higher.
Another method to look out for `outliers' is to make a boxplot of the data. We noticed
before that the payoffs seem to depend on the first digit of the winning number.
So it would be interesting to draw boxes for the ten subsets of payoffs in a single plot to
study this phenomenon graphically. Rather than extracting each set separately, we use
the R function split to create a list, where each element of the list gives all of the
payoffs that correspond to a particular first digit of the winning number. The boxplot
function will draw a box for each element in the list.

> digit<-trunc(data$number/100) # the first digits

> boxplot(split(data$payoffs, digit)) # boxplot of data split by groups

> title(xlab="First Digit of Winning Number", ylab="Payoff")

> abline(h=500) # horizontal line at 500

The box in a boxplot contains the middle half of the data; the whiskers extending from
the box reach to the most extreme non-outlier; outlying points are plotted individually.
Notice the high payoffs for the first box. The graphic shows us as well that
it is rare for a payoff to exceed $500. So, place your bet if you enjoy gambling. Do not
expect to win.