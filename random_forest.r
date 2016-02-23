#load dependencies
library(randomForest)

#load data
train = read.csv("G:/UNM MS/Fall 2015/CS521 Data Mining/Project/train.csv", header = TRUE, stringsAsFactors = FALSE)
test = read.csv("G:/UNM MS/Fall 2015/CS521 Data Mining/Project/test.csv", header = TRUE, stringsAsFactors = FALSE)

# make target a factor
train$target = as.factor(train$target)

# Random Forest Classifier
rf = randomForest(target ~., data = train[,-1], ntree=500, do.trace=50, importance=TRUE)

#Random Forest Classifier after Tuning
# rf = randomForest(target ~., data = train[,-1], ntree=200, mtry=18 , do.trace=50, importance=TRUE)

print(rf)

#Confusion Matrix for trained model
table(predict(rf),train$target)
plot(rf)

# Feature Importance
rf_imp <- importance(rf)
varImpPlot(rf)

# Tuning RF and checking OOB for various Mtry values
# tune.rf <- tuneRF(train[,-ncol(train)],train[,ncol(train)], stepFactor=0.5)
# print(tune.rf)

# Predicting for the Test Dataset
predicted = predict(rf, test[,-1], type = "prob")
id<-test[,1]
submission<-cbind(id,predicted)
submission<- as.data.frame(submission)
sapply(submission,as.integer)
write.csv(submission, "G:/UNM MS/Fall 2015/CS521 Data Mining/Project/random_forest.csv", row.names = FALSE, quote = FALSE)

