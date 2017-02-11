install.packages("recommenderlab")
library(recommenderlab)
install.packages("reshape2")
library(reshape2)
install.packages("ggplot2")
library(tidyverse)
movie_train=read.csv("train_v2.csv")
str(movie_train)
movie_train %>% head() %>% View()
length(unique(movie_train$user))
length(unique(movie_train$movie))
head(movie_train)
movie_train %>% spread(movie,rating) %>% head() %>% View()

pvt_train<-spread(movie_train,movie,rating)

pvt_train<-acast(movie_train, user ~ movie)

ncol(pvt_train)
head(pvt_train,5)
pvt_train[1:5,1:5]

str(pvt_train)

View(head(pvt_train))#data frame needs to be used with view function

class(pvt_train) #check if matrix or data frame

as(pvt_train,"list")
as(pvt_train,"matrix")
#Ctrl+L for clearing console

pvt_train=as(pvt_train,"realRatingMatrix")
pvt_train
class(pvt_train)

pvt_train_n<-normalize(pvt_train)
class(pvt_train)

head(as(pvt_train,"data.frame"),20)

head(pvt_train)

image(pvt_train, main = "Raw Ratings")
image(pvt_train_n, main = "Normalized Ratings")

?image

rec=Recommender(pvt_train[1:nrow(pvt_train)],method="IBCF", param=list(normalize = "Z-score",method="Jaccard"))

recom <- predict(rec, pvt_train[1:nrow(pvt_train)], type="ratings")

pvt_train

as(recom, "data.frame") %>% dim()

sample=read.csv("Sample.csv")

str(sample)

sample=sample[,-c(1)]
str(sample)

cast=acast(sample,user~movie)
str(cast)
View(cast)

cast_r=as(cast,"realRatingMatrix")
image(cast, main = "Raw Ratings")       
image(cast_r, main = "Normalized Ratings")

rec1=Recommender(cast_r[1:nrow(cast_r)],method="IBCF", param=list(normalize = "Z-score",method="Jaccard"))

recom1 <- predict(rec1, cast_r[1:nrow(cast_r)], type="ratings")

as(recom1,"matrix")

