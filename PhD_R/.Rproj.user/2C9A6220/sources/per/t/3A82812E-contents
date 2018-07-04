library(frbs)
library(dplyr)

data('iris', package = 'datasets')
iris_shuffled <- iris[sample(nrow(iris)), ]
head(iris_shuffled)
iris_shuffled$Species <- unclass(iris_shuffled$Species)
head(iris_shuffled)
range_data_input <- apply(iris[, -ncol(iris)], 2, range)
head(range_data_input)
tra_iris <- iris_shuffled[1:140, ]
tst_iris <- iris_shuffled[141:nrow(iris_shuffled), -5]
head(tst_iris)
real_iris <- matrix(iris_shuffled[141:nrow(iris_shuffled), 5], ncol = 1)
head(real_iris)

object_frbs_w <- frbs.learn(tra_iris, range_data_input,
                              method.type = 'FRBCS.W', control = list(
                                num.labels = 3,
                                type.mf = 'TRAPEZOID'))
summary(object_frbs_w)

pred <- predict(object_frbs_w, tst_iris)
err <- 100 * sum(pred != real_iris)/length(pred)
err

plotMF(object_frbs_w)
