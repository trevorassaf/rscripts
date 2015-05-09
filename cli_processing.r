#! /usr/bin/Rscript

get_filename <- function() {
  # Constants
  FILE_ARG_NAME <- "--file="
  PATH_SEPARATOR_DELIMITER <- "/"  
  
  # Parse file name from non-trailing cli param
  cli_args <- commandArgs(trailingOnly=FALSE)
  full_file_arg <- cli_args[grep(FILE_ARG_NAME, cli_args)]
  file_name <- basename(full_file_arg)
  file_name
}
