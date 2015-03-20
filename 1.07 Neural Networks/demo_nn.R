library(nnet)
library(ggplot2)

hidden=10

x <- sort(2*runif(30000)-1)
y<-0.2 + 0.4*x^2 + 0.3*sin(15*x) + 0.05*cos(50*x);

nn <- nnet(x, y, size=hidden, maxit=1000, linout=TRUE)

ps <- predict(nn,  data.frame(x=x))

fx3<-data.frame(x,y,ps)

q<-ggplot(fx3, aes(x = x)) + 
    geom_line(aes(y = y), colour="blue") + 
    geom_line(aes(y = ps), colour = "red") + 
    ylab(label="Y") + 
    xlab("X")
print(q)
