#! /usr/bin/Rscript

args = commandArgs(trailingOnly = TRUE)
data_file = args[1]
load(data_file, data <- new.env())
ls.str(data)
