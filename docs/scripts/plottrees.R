library("ape")
library("ggplot2")
library("ggtree")

args = commandArgs(trailingOnly=TRUE)

tree <- read.tree(args[1])
tree

ggtree(tree) + geom_tiplab() + geom_nodelab(size = 7, col= "grey")