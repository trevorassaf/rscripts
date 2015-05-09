#! /usr/bin/Rscript

source("cli_processing.r")
file_name <- get_filename()

### Constants
# Cli arg counts 
WITHOUT_ANNOTATIONS_CLI_ARG_COUNT <- 2
WITH_ANNOTATIONS_CLI_ARG_COUNT <- 5

# Cli arg indices
RDATA_FILE_NAME_CLI_ARG_IDX <- 1
DATA_SET_NAME_IDX <- 2
TITLE_CLI_ARG_IDX <- 3
Y_AXIS_LABEL_CLI_ARG_IDX <- 4
X_AXIS_LABEL_CLI_ARG_IDX <- 5

# File name sub/strings
HISTOGRAM_FILE_SUFFIX <- "-histogram.jpg"

### MAIN
# Process cli args
args = commandArgs(trailingOnly = TRUE)
cli_arg_count <- length(args)

# Validate cli arg count 
if (cli_arg_count != WITHOUT_ANNOTATIONS_CLI_ARG_COUNT
      && cli_arg_count != WITH_ANNOTATIONS_CLI_ARG_COUNT) {
  cat("ERROR: Incorrect number of cli args!\nUsage:", file_name, " <Rdata file path> <data set name> [<title> <y-axis label> <x-axis label>]") 
  quit()
}

# Obtain data set
data_file <- args[RDATA_FILE_NAME_CLI_ARG_IDX]
object <- load(data_file, environment <- new.env())[1] # todo make the object index a param

data_set_name <- args[DATA_SET_NAME_IDX]
data <- environment[[object]][data_set_name]
hist_data <- data[[1]]

# Assemble histogram
histogram <- hist(x=hist_data)
histogram_filename <- paste(data_set_name, HISTOGRAM_FILE_SUFFIX, sep='')
jpeg(histogram_filename)

if (cli_arg_count == WITH_ANNOTATIONS_CLI_ARG_COUNT) {
  plot(
       histogram,
       labels=TRUE,
       main=args[TITLE_CLI_ARG_IDX],
       ylab=args[Y_AXIS_LABEL_CLI_ARG_IDX],
       xlab=args[X_AXIS_LABEL_CLI_ARG_IDX])
} else {
  plot(histogram)
}

dev.off()
