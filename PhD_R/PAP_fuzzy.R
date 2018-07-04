#Initalization#
###############

library(readxl)
library(dplyr)
library(frbs)

init_data <- read_excel('~/Documents/PhD/PhD_R/PhD_podaci/PAP_svi_OMIS_podaci_sredjeni.xlsx')

# Provera strukture i sadrzaja df-a
str(init_data)
head(init_data)

# set.seed() da bi se obezbedila reproduktibilnost
set.seed(333)

# Izbacivanje nepotrebnih kolona
init_data <- init_data[-c(2,3)]
head(init_data)

# Prebacivanje prve kolone na kraj
init_data <- init_data %>% select(-CLASS, everything())
head(init_data)
head(init_data[ncol(init_data)])

# Proverimo strukturu podataka
init_data %>% group_by(CLASS) %>% summarise(n = n()) #broj uzoraka 4-te klase je prilicno mali - neuravnotezen skup podataka
data_shuffled <- init_data[sample(nrow(init_data)), ]
head(data_shuffled)
head(data_shuffled[ncol(data_shuffled)])

range_data_input <- apply(data_shuffled[, -ncol(data_shuffled)], 2, range)
range_data_input

# Formiranje trening i test skupa podataka
dim(data_shuffled)
train_data <- data_shuffled[1:421, ]
test_data <- data_shuffled[421:nrow(data_shuffled), -ncol(data_shuffled)]
head(test_data)
head(test_data[ncol(test_data)])

class_test_data <- matrix(as.integer(unlist(data_shuffled[421:nrow(data_shuffled), ncol(data_shuffled)])), ncol = 1)
head(class_test_data)

object_frbs_w <- frbs.learn(train_data, range_data_input,
                            method.type = 'FRBCS.W', control = list(
                            num.labels = 7,
                            type.mf = 'TRAPEZOID'))
summary(object_frbs_w)

pred <- predict(object_frbs_w, test_data)
acc <- 1 - sum(pred != class_test_data)/length(pred)
acc # 97.8022 sa num.labels = 7

plotMF(object_frbs_w)
