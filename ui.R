library(shiny)
library(caret)
data("iris")
shinyUI(fluidPage(titlePanel("Predicting Species"),
                  sidebarLayout(sidebarPanel(
                      numericInput("sl","Sepal Length",min=4.2,max=8,value=6,step=0.1),
                      numericInput("sw","Sepal Width",min=2,max=4.5,value=3,step=0.1),
                      numericInput("pl","Petal Length",min=1,max=7,value=4,step=0.1),
                      numericInput("pw","Petal Width",min=0.1,max=2.6,value=1,step=0.1),
                      radioButtons("c1", "Select Model",choiceNames=list("Random Forest","LDA"),choiceValues=
                                        c("Random Forest","LDA"))
                      
                  ),
                  mainPanel(
                tabsetPanel(type="tabs",
                            tabPanel("About",h3("Description"),h5("This app takes the iris dataset in R."),
                       h5("Iris has five variables: Petal Width,Petal Length,Sepal Width,Sepal Length and Species."),
                           h5("The goal is to predict the Species by using other variables."),
                           h5("I have build two predictive models Random Forest and LDA for the purpose."),
                           h5("You have to enter the values for all the variables and choose a prediction model."),
                          h5("I have also computed the accuracy for the models and somegraphs for better understanding."),
                           strong("Note:"),h5("The app may take little time to run. Please be patient.")),
                  tabPanel("Exploratory Plot",strong("Note:"),h5("The orange point in both the plots is your current selected data point.") , plotOutput("p1")),
                   tabPanel("Predictive Models" ,h5("The plot talks about correctly and incorrectly predicted data from the test set."),h5("TRUE: correctly predicted"),
                            h5("FALSE: incorrectly predicted"),plotOutput("p2"), h5("Accuracy "),textOutput("t1"),
                     h5("Predicted Species") ,textOutput("t2")))
                      
                  ))))