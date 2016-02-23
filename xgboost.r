# Loading Required Libraries
library(xgboost)
library(methods)
library(car)

# Loading the Input Data
train <- read.csv("G:/UNM MS/Fall 2015/CS521 Data Mining/Project/train.csv",header=TRUE,stringsAsFactors = F)
test <- read.csv("G:/UNM MS/Fall 2015/CS521 Data Mining/Project/test.csv",header=TRUE,stringsAsFactors = F)

# Removing the ID from Train and Test Dataset
train <- train[,-1]
test  <- test[,-1]

# Separating the Class Labels from Train dataset and transforming them.
labels <- train[,ncol(train)]
labels <- as.integer(gsub('Class_','',labels))-1
train <- train[,-ncol(train)]

# Converting the Train and Test data to matrices to pass for XGBoost classifier.
train_xg <- as.matrix(train)
test_xg <- as.matrix(test)
train_xg <- matrix(as.numeric(train_xg),nrow(train_xg),ncol(train_xg))
test_xg <- matrix(as.numeric(test_xg),nrow(test_xg),ncol(test_xg))

# Listing the XGBoost parameters.
param_xg <- list("objective" = "multi:softprob",
                 "eval_metric" = "mlogloss",
                 "num_class" = 9,
                 "max_depth" = 12,
                 "eta" = 0.03,
                 "min_child_weight" = 8,
                 "max_delta_step" = 0,
                 "subsample" = 0.9,
                 "colsample_bytree" = 0.8
)
# K fold cross validation of Train Data
cv.nround = 2
xgb_classifier.cv = xgb.cv(param=param_xg, data = train_xg, label = labels, nfold = 3, nrounds=cv.nround)

# Setting seed value and number of boosting iterations.
set.seed(131)
nround <-1000 

# Training the Classifier for Train Data
xgb_classifier <- xgboost(param=param_xg, data = train_xg, label = labels, nrounds=nround)

# Predicting Test Data
pred_xg <- predict(xgb_classifier,test_xg)
pred_xg <- matrix(pred_xg,9,length(pred_xg)/9)
pred_xg <- as.data.frame(t(pred_xg))
pred_xg <- format(pred_xg, digits=2, scientific=F) 

# Appending ID to predicted probabilities and saving to a file.
pred_xg <- cbind(1:nrow(pred_xg),pred_xg)
names(pred_xg) <- c('id',paste0('Class_',1:9))
write.csv(pred_xg,file="submission_xg.csv", quote=FALSE,row.names=FALSE)
