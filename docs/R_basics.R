---
title: "R Basics"
author: "Rob Harbert"
date: "9/10/2018"
output: html_document
---
  
  ```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
```

# R Basics


## Interactive R

R is very handy for it's interactive command line interface. Later we will also explore how to make R reusable with scripts, but for now we will focus on typing at the command prompt to get comfortable. 

To get started type: 'R' at your command line.

What version of R do you have?


```{r fig.width=7, fig.align='center', echo=FALSE}
library(png)
library(grid)
img <- readPNG("./docs/Rprompt.png")
grid.raster(img)
```
Or
```{r}
version
```

We can easily get started with the R command promp open.

```{r}
x=2
print(x) ##Print method
class(x)

x=seq(1:10) # Create a vector
class(x)
print(x)
print(x[1]) # First index of vector
print(x[1:5])

y = matrix(nrow=5, ncol=5) # create a 5x5 matrix
print(y)
class(y)
y[1,1] = 5
print(y)
y[,1]  = x[1:5]
print(y)
class(y[,1])

y = cbind(seq(1:5), 
seq(1:5),
seq(1:5),
seq(1:5),
seq(1:5))

class(y)


```

## Data input/output

### Read table/tab/csv/txt text files:
read.table()
read.csv()
read.delim()

```{r}
cars = read.table('../data/mtcars.csv', header=T, sep = ',') # Read a comma separated values file
head(cars)

cars = read.csv('../data/mtcars.csv')
cars = read.csv2('../data/mtcars.csv') ## Interesting behavior here, will be somewhat faster

cars = read.delim('../data/mtcars.csv', sep=',')


```

fread - Faster read

```{r, eval=FALSE}
library(data.table)
ebd = fread('../data/ebd_trim.csv', sep = '\t')
```

## Loops

Repeating tasks using for loops


```{r}
for(i in 1:10) {
print(i)
}

```
Catch loop output
```{r}
li = vector()
for(i in 1:10){
li[[i]]=log(i)
}
```

## apply family functions

The Apply functions in R provide efficient repetition that usually out-performs for loops.

```{r}

print(y) #our matrix from earlier
y = as.data.frame(y)
li1 = apply(y, 1, sum) # row-wise
li2 = apply(y, 2, sum) # column-wise

li2 = lapply(y[,1], log) #returns list
li2 = sapply(y[,1], log) #returns vector

#replicate an operation, a wrapper for sapply
rep = replicate(10, log(y[,1]), simplify='array')


```

## Writing Functions

The syntax for R functions:

```{r}
square = function(x){
return(x**2)
}
square(64)
```

Can take as many arguments as you want
```{r}
sumit = function(x,y){
return(x+y)
}
sumit(3,5)
```
And you can give the function default variable values:
```{r}
logbase=function(x, base=10){
l = log(x, base)
return(l)
}

logbase(2) #log10
logbase(2, base=exp(1)) #natural log


```

## ggplot

the ggplot library is part of the 'tidyverse'. We will not use tidy protocols exclusively in this course, but the tools for making high quality figures in ggplot are worth touching on here.

```{r}
# install.packages("tidyverse") # if not yet installed

library(tidyverse)

#import data as before:
## **The following code and data are shamelessly stolen from Chase Nelson's (cnelson@amnh.org) SICG workshop at the AMNH on ggplot from February 2018.**
  
  virus_data <- read.delim("../data/R_workshop_data.txt") # import SNP data
  
  # examine
  head(virus_data) # view the first 6 rows
  head(virus_data, n = 10) # view the first n rows
  str(virus_data) # describe the STRucture of the data.frame
  
  # add a new column
  virus_data$frequency <- virus_data$count / virus_data$coverage # add col with SNP frequencies
  virus_data$frequency <- with(virus_data, count / coverage) # same thing a different way
  
  head(virus_data) # view again to check that it worked
  
  # generate summary statistics
  summary(virus_data$coverage)
  
  # SCATTERPLOTS
  # view SNP frequencies
  ggplot(data = virus_data) +
    geom_point(mapping = aes(x = position, y = frequency))
  
  # change x and y axis titles
  ggplot(data = virus_data) +
    geom_point(mapping = aes(x = position, y = frequency)) +
    xlab("Genome Position") + ylab("SNP Frequency")
  
  # use transparency to better visualize clusters of points
  ggplot(data = virus_data) +
    geom_point(mapping = aes(x = position, y = frequency), alpha = 0.5) +
    xlab("Genome Position") + ylab("SNP Frequency")
  
  # Facetting -- multiple plots
  
  ggplot(data = filter(virus_data, host_type == 'host')) +
    geom_point(mapping = aes(x = position, y = frequency)) +
    xlab("Genome Position") + ylab("SNP Frequency") +
    facet_wrap(~ host)
  
  
  ```
  
  ### ggmaps
  
  Also in the tidyverse is a great packages for easy generation of maps.
  
  ```{r}
  
  library(tidyverse)
  library(mapdata)
  library(maps)
  library(ggmap)
  library(magrittr)
  
  
  ```
  
  If any of these fail try and install packages.
  
  One of the best parts of these tools is the built in access to Google maps aerial imagery.
  
  ```{r} 
  
  loc = cbind(-73.973917, 40.781799)
  loc = as.data.frame(loc)
  colnames(loc) = c('lon', 'lat')
  bkmap <- get_map(location = loc, maptype = "satellite", source = "google", zoom =14)
  ggmap(bkmap) + 
    geom_point(data = loc, 
               color = "red",
               size =4)
  
  
  
  bkmap3 <- get_map(location = loc ,  maptype = "terrain", source = "google", zoom = 12)
  
  
  ggmap(bkmap3) + 
    geom_point(data = loc, 
               color = "red",
               size =4)
  
  
  bkmap4 <- get_map(location = loc ,  maptype = "toner-lite", source = "google", zoom = 10)
  
  
  ggmap(bkmap4) + 
    geom_point(data = loc, 
               color = "red",
               size =4)
  
  
  
  
  
  
  ```
  
  
  
  
  