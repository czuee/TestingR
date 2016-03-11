Data manipulation in R: vectors, matrices, list et data frames
 
You should be able to answer easily the questions at the bottom after having 
read and understood the text below. An advice: type the examples in R, 
it helps!
The basic objects in R are vectors, tables, lists and "data frames". 

Vectors 


R operates on structured data bearing a name. The simplest structure is a 
vector, which is a simple entity consisting of an ordered collection 
of numbers. For instance,

 
> x.vector<-c(5.1,6.3,7.8,9.3,10.5)

is a vector made up of five numbers. The order above uses the symbol of 
assignment '<-' and the function 'c' who combines the five values in a 
vector. Note that the assignment can also be made in the other direction:


> c(5.1,6.3,7.8,9.3,10.5)->x.vector


If an expression is used without being assigned to an object, 
it is printed to the
screen then is lost. For example the instruction


> 1/x.vector

prints the inverse of the fives values, but does not store them.

 

The vectors can be used in arithmetic expressions, the operations being 
then carried out on each element of the vector. For instance, 
look at the result of the 3 instructions below:

> x.vector-1

> 2*(x.vector-1)

> x.vector^2

where '^' stands for power

let's make a second vector:

> y.vector<-c(1.3,3.4,8.1,3.6,5.7)

with the same length as x.vector. Look at the results of the following 
instructions:

> x.vector+y.vector

> x.vector*y.vector

Note that vectors of different lengths can be used in an operation. 
In this case, the size of the shortest vector is adjusted by duplicating 
it until it reaches the size of the longest vector. If the longest 
vector is not a multiple of the short vector,
then a warning is emitted:


> x2<-c(1,1)

> y5<-c(1,2,3,4,5)

> x2+y5

[1] 2 3 4 5 6
Warning message:
longer object length
is not a multiple of shorter object length in: x2 + y5

In top of the common operations, you can also used the functions 
'log', 'log10', 'exp',
'sin', 'cos', 'tan', 'sqrt' etc... 'range' gives minima 
and maxima of teh vector or matrix:

> range(x.vector)

> c(min(x.vector),max(x.vector))

the number of items in a vector can be obtained using 'length':

> length(x.vector)

thus, the valid indices for the elements of this vector are 
1:length(vecteur.x)
(: between 2 numbers is an instruction to generate the sequence of integers 
between the 2 numbers).
Elements from a vector can be extracted by specifying the element 
number between square brackets '[]'.
For instance, item 3 of x.vector is:

> x.vector[3]

and the instruction

> x.vector[1:3]

extract the first 3 elements of the vector. 
Two useful functions are the sum and
product of the element of a vector:

> sum(x.vector)

> prod(x.vector)

Vectors can be made of logical elements:

> c(T,F,T,T,F,T)

where T stands for TRUE and F for FALSE. We can also have character strings

> c("This","is","my","first","R","course")

for a sequence of digits, use ':':

> 1:10

If you want it in steps of 2, type:

> 2*1:10

This works because ':' has higher precedence than "*". To obtain 
the reverse sequence:

> 10:1

A more general function to obtain a sequence is the function seq (try ?seq):


> seq(-2*pi,3*pi,pi/4)

And another useful function is rep:

> rep(1,10)

> rep(1:5,2)

Two other useful functions are 'sort' and 'order':

> y<-c(3.1,6.3,2.1,4.4,-1.9)

> sort(y)

> order(y)

> y[order(y)]

Matrices

Matrices are obtained through the instruction'matrix':

> m1<-matrix(1:12,nrow=3)

> m1

By default (see ?matrix), matrices are filled in columns. If you want 
to fill them by rows, use:

> m2<-matrix(1:12,nrow=3,byrow=T)

> m2

Matrix dimension are obtained using 'dim':

> dim(m1)

Note that a vector does not have a dimension (although it has a length):

> dim(x.vector)

You can constrain a vector to become a matrix:

> m.x.vector<-as.matrix(x.vector)

> dim(m.x.vector)

You can stick matrices together by rows or columns:

> rbind(m1,m2)

> cbind(m1,m2)

Elements from a matrix are extracted using square brackets:

> m1[3,2]

> m1[2,3]

We can access to a full line
> m1[2,]

or column:

> m1[,2]

We can also remove a line or a column from a matrix:

> m1[-2,]

> m1[,-2]

elementwise multiplication of a matrix can be carried out:
> m1*m2

And classic matrix product is otained using '%*%':

> m1 %*% t(m2)

> t(m1) %*% m2

where 't' stands for transpose (by the way, why don't we take the 
product m1 %*% m2?).

Lists
A list in R is an object containing an ordered list of objects, 
its components.
Objects in a list do not have to be of the same type. 
A new list is created using 'list'


> my.list<-list("first element"=T, "second element"="Coucou","third"=c(4,3),
"fourth"=9.99)

> my.list

To get to a specific element of a liste, double square brackets are used'[[]]':

> my.list[[2]]

Note that to obtain several elements, we use simple square brackets:

> my.list[1:3]

Last, it is convenient to call an element in a list by its name rather than 
its position:, using '$' followed by the fist discriminatory characters of the 
element's name:
> my.list$fir

(here, the first 2 letters would have been sufficient)

> my.list$s #second element

the names of the elements in a list can be obtained with 'names':
> names(my.list)

Data frames

Data frames can be considered as list of data vectors of the same length, 
but not
necessarily of the same type (contrary to matrices).  
The main idea behind data frames
is to group data corresponding to an entity of observation in a single 
structure.
It's similar in concept to your familiar excel spreadsheet. 
Elements from a data frame can be accessed in the same way as those 
of a list or of a matrix:

> a<-1:12
> b<-12:1
> cc<-letters[1:12] #why cc rather than c?
> d<-rep(c(TRUE,FALSE),each=6) #careful, T & F are dangerous, use TRUE and FALSE instead
> dataf<-data.frame(a,b,cc,d)
> dataf
> dataf[,2]
> dataf$b

square brackets allow selecting part of a data frame.  
The double equal sign '==' allows
to select elements equal to a criterion . 
For instance in data frame dataf to select the
element of d equal to TRUE:

> dataf$d[dataf$d==TRUE]

To select the element of a for which d is equal to TRUE::

> dataf$a[dataf$d==TRUE]

And to select all the columns of the data frame for which d is TRUE:

> dataf[dataf$d==TRUE,] #why the comma? 

A extremely useful command is read.table, allowing to load a text file 
in the environment, and to associate it with a data frame. 

If for instance, you want to read the the content
of file 'monfichier.txt' in R, you just need to type the command:


> my.data<-read.table("monfichier.txt",header=T)
my.data

For the command to work of course, the file needs to be in the working 
directory.
To set the working directory use the 
command 'setwd("d:/mydir")" (note the /, not \),
and to locate the current working directory use 'getwd()'. 

If the file is on the internet, you can just enter the URL. For instance, 
if your file is at URL:

http://www.unil.ch/popgen/teaching/R11

You can load it with read.table using the full URL of the file:

> my.data<-read.table("http://www.unil.ch/popgen/teaching/R11/monfichier.txt",
header=T)

> my.data

Last, saving a data frame as a text file:

write.table(my.data,"mydata.txt",row.names=FALSE,quote=FALSE,sep="\t")


___________________________________________________________________________________-
Questions

Answer questions 1 to 10 below:

   0. Why should I avoid calling objects c, T or F? 
   1. clean your R environment by issuing the instruction rm(list=ls())
   2. For the following numbers
      7.3, 6.8, 0.005, 9, 12, 2.4, 18.9, 0.9
         1. Find their mean,
         2. substract it from all the numbers,
         3. get their square root,
         4. print the numbers that are larger than their square root
         
   3. use seq and rep to generate the following vectors:
      (a) 1; 2; 3; 4; 1; 2; 3; 4; 1; 2; 3; 4; 1; 2; 3; 4;
      (b) 10; 10; 10; 9; 9; 9; 8; 8; 8; 7; 7; 7;
      (c) 1; 2; 2; 3; 3; 3; 4; 4; 4; 4; 5; 5; 5; 5; 5;
      (d) 1; 1; 3; 3; 5; 5; 7; 7; 9; 9;

   4. a) create the following matrix, as simply as possible:***

      3 1 1 1
      1 3 1 1
      1 1 3 1
      1 1 1 3
      b) multiply this matrix elementwise with itself. Get its matrix product by itself
   5. Solve the following system (have a look at solve)***

      2x + 3y - z = 4
      5x - 10y + 2z = 0
      x + y - 4z = 5
   6. create a list mylist with the following elements:
          * numbers 1 to 5. call it nb1
          * numbers 1 to 50 by 0.375 steps. call it nb3
          * the string "My mummy told me". call it char1
          * A vector made of the strings "apples", "bananas", "pears". call it char2
          * The booleans vector FALSE,FALSE,FALSE,TRUE,TRUE,TRUE,FALSE,FALSE,FALSE,TRUE,TRUE,TRUE 
		  call it bool 
          
   7. What's the list's length? calculate the mean of the first element; of the second; of the first and second
   8. paste the third and fourth element of the list (use paste);
      Which instruction would give  the sentence "My mummy told me: apples, bananas, pears"
     (be careful, punctuation is important!)
   9. Create a data frame with the data contained in file parus1.txt located at 
   http://www2.unil.ch/popgen/teaching/R11
  10. Create a vector data.fly containing the observations from alldat for which treat is mouche.
      Add to data the element: "puce", 12.7300
  11. Try loading the file alien.txt.
      What is wrong with this file?  Fix it.
  12. Try loading the file class2005.xls
      What needs to be done before you can load it into R?
      
      