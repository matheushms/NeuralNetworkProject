data = read.csv('Pima_indians_diabetes_dataset.csv')


### Divisão entre conjunto de treinamento e teste

library(caTools)

set.seed(2)
# = sample.split()

library(h2o)

h2o.init(nthreads=-1) ## para usar todos os nucleos disponiveis
file <- h2o.importFile('datasets/Breast_cancer_wisconsin_dataset.csv',header=TRUE, sep=',')
splits <- h2o.splitFrame(file, 0.75, seed=33) #divide em conjunto de treino e teste
splits[[1]][,9]<- as.factor(splits[[1]][,9]) 
splits[[2]][,9]<- as.factor(splits[[2]][,9])


classificador <- h2o.deeplearning(x=1:8,
                                  y=9,
                                  activation="RectifierWithDropout",
                                  training_frame = splits[[1]], 
                                  hidden=c(10), 
                                  nfolds = 5, keep_cross_validation_models = TRUE,
                                  seed = 25,learn_rate = .01,
                                  epochs=100,
                                  input_dropout_ratio=0.1 )


pred1=h2o.predict(classificador,splits[[2]])
h2o.confusionMatrix(classificador,splits[[2]])

plot(gbm, timestep = "duration", metric = "deviance")

