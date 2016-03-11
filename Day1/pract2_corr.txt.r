___________________________________________________________________________________-
Questions

Answer questions 1 to 10 below:

   0. Why should I avoid calling objects c, T or F? 
#because this will make the c function, or respectively the abbreviation of 
#TRUE and FALSE unavailable to the R session   
   1. clean your R environment by issuing the instruction rm(list=ls())
   2. For the following numbers
      7.3, 6.8, 0.005, 9, 12, 2.4, 18.9, 0.9
#        x<-c(7.3, 6.8, 0.005, 9, 12, 2.4, 18.9, 0.9)
         1. Find their means,
#mean(x) 
         2. substract it from all the numbers,
#x-mean(x)
         3. get their square root,
#x^0.5 or sqrt(x)
         4. print the numbers that are larger than their square root
#x[x>x^0.5]
         
   3. use seq and rep to generate the following vectors:
      (a) 1; 2; 3; 4; 1; 2; 3; 4; 1; 2; 3; 4; 1; 2; 3; 4;
#rep(1:4,4)      
      (b) 10; 10; 10; 9; 9; 9; 8; 8; 8; 7; 7; 7;
#rep(10:7,each=3)
      (c) 1; 2; 2; 3; 3; 3; 4; 4; 4; 4; 5; 5; 5; 5; 5;
#rep(1:5,1:5)
      (d) 1; 1; 3; 3; 5; 5; 7; 7; 9; 9;
#rep(2*(0:4),each=2)+1

   4. a) create the following matrix, as simply as possible:

      3 1 1 1
      1 3 1 1
      1 1 3 1
      1 1 1 3
#m<-matrix(c(3,rep(c(rep(1,4),3),3)),nrow=4) or diag(4)*2+1

     b) multiply this matrix elementwise. 
#m*m     
     Get its matrix product by itself
#m%*%m
   5. Solve the following system (have a look at solve)

      2x + 3y - z = 4
      5x - 10y + 2z = 0
      x + y - 4z = 5
      
#M1<-matrix(c(2,5,1,3,-10,1,-1,2,-4),nrow=3)
#v<-c(4,0,5)
#sol<-solve(M1,v)
#round(M1%*%sol,digits=4)
   6. create a list mylist with the following elements:
          * numbers 1 to 5. call it nb1
          * numbers 1 to 50 by 0.375 steps. call it nb3
          * the string "My mummy told me". call it char1
          * A vector made of the strings "apples", "bananas", "pears". call it char2
          * The booleans vector 
		  FALSE,FALSE,FALSE,TRUE,TRUE,TRUE,FALSE,FALSE,FALSE,TRUE,TRUE,TRUE 
		  call it bool 
# nb1<-1:5
# nb3<-seq(1,50,by=0.375)
# char1<-"My mummy told me"
# char2<-c("apples","bananas","pears")
# bool<-rep(c(FALSE,TRUE),each=3,2)
#mylist<-list(nb1=nb1,nb3=nb3,char1=char1,char2=char2,bool=bool)
         
   7. What's the list's length? calculate the mean of the first element; of the second; 
   of the first and second
#length(mylist)
#mean(mylist$nb1)
#mean(mylist$nb2)
#mean(c(mylist$nb1,mylist$nb2))
   
   8. paste the third and fourth element of the list (use paste);
      Which instruction would give  the sentence "My mummy told me: apples, bananas, pears"
     (be careful, punctuation is important!)
#paste(mylist$char1,paste(mylist$char2,collapse=", "),sep=": ")

   9. Create a data frame with the data contained in file parus1.txt,
      located at URL http://www.unil.ch/popgen/teaching/R11/parus1.txt
#dat<-read.table("http://www.unil.ch/popgen/teaching/R11/parus1.txt",header=TRUE)
      
  10. Create a vector data.fly containing the observations from alldat for which
  treat is mouche.
#data.fly<-dat$alldat[dat$treat=="mouche"]
      Add to data the element: "puce", 12.7300
#ndat<-rbind(dat,data.frame(treat="puce",alldat=12.7300))      
  11. Try loading the file alien.txt located at
      http://www.unil.ch/popgen/teaching/R11/alien.txt.
      What is wrong with this file?  Fix it.

  13. Load the Lotery data set again.  Calculate the mean payoff for numbers containing at least twice the same digit.    
#lot<-read.table("http://www.unil.ch/popgen/teaching/R11/lotery.txt",header=TRUE)
#d1<-lot$number %/% 100
#d23<-lot$number %% 100
#d2<-d23 %/% 10
#d3<-d23 %% 10
#cbind(lot$number, d1,d2,d3) # to check
#x<-which(d1==d2 | d1==d3 | d2==d3)
#lot$number[x]  # to check
#mean(lot$payoffs[x])
