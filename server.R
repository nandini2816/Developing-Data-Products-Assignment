library(shiny)
library(caret)
data("iris")
shinyServer(function(input,output){
set.seed(123231)
    inTrain<-createDataPartition(iris$Species,p=.7,list=FALSE)
    training<-iris[inTrain,]
    testing<-iris[-inTrain,]
fit1<-train(Species~.,data=training,method="rf")
fit2<-train(Species~.,data=training,method="lda")
cm1<-confusionMatrix(predict(fit1,testing),testing$Species)
cm2<-confusionMatrix(predict(fit2,testing),testing$Species)
pred1<-reactive({
  
    sl<-input$sl
    sw<-input$sw
    pl<-input$pl
    pw<-input$pw
 as.character(predict(fit1,data.frame(Sepal.Length=sl,Sepal.Width=sw,Petal.Width=pl,Petal.Length=pl,Species=NA)))[1] 
    
})
pred2<-reactive({
    sl<-input$sl
    sw<-input$sw
    pl<-input$pl
    pw<-input$pw
  as.character(predict(fit2,data.frame(Sepal.Length=sl,Sepal.Width=sw,Petal.Width=pl,Petal.Length=pl)))[1]
    
    
})
output$p1<-renderPlot({
    plot(testing$Petal.Width,testing$Sepal.Width,col=testing$Species,xlab = "Petal Width",
         ylab="Sepal Width",cex=2,pch=16)
    legend("topright",legend=c("Setosa","Versicolor","Virginica"),col=c("black","pink","green"),cex=2,pch=16)
    pw<-input$pw
    sw<-input$sw
    points(pw,sw,col="orange",cex=2,pch=16)
})
output$t0<-renderText("This app takes")
output$p2<-renderPlot({ if(input$c1=="Random Forest"){
    predvals<-ifelse(predict(fit1,testing)==testing$Species,"blue","pink")
    plot(testing$Petal.Width,testing$Sepal.Width,col=predvals,xlab = "Petal Width",
         ylab="Sepal Width",main = "Random Forest",cex=2,pch=16)
    legend("topright",legend=c("TRUE","FALSE"),col=c("blue","pink"),cex=2,pch=16)
    pw<-input$pw
    sw<-input$sw
    points(pw,sw,col="orange",cex=2,pch=16)}
    if(input$c1=="LDA"){
        predvalss<-ifelse(predict(fit2,testing)==testing$Species,"blue","pink")
        plot(testing$Petal.Width,testing$Sepal.Width,col=predvalss,xlab = "Petal Width",
                      ylab="Sepal Width",main = "LDA",cex=2,pch=16)
        legend("topright",legend=c("TRUE","FALSE"),col=c("blue","pink"),cex=2,pch=16)
        pw<-input$pw
        sw<-input$sw
        points(pw,sw,col="orange",cex=2,pch=16)}
    else { "No model Selected"}})
       

output$t1<-renderText(if(input$c1=="Random Forest")cm1[["overall"]]["Accuracy"] 
                      else cm2[["overall"]]["Accuracy"])
 output$t2<-renderText({if(input$c1=="Random Forest") {pred1()} else{ pred2()}})

    
})