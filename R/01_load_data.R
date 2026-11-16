
# ==================================================
# Project : Vehicle Loan Analytics Using R
# Script  : 01_load_data.R
# Purpose : Load raw data and maintain execution logs
# ==================================================

# STEP 1: Define file paths
input_file <- "data/raw/credit_card_raw.csv"
log_file <- "logs/pipeline_log.csv"

# STEP 2: Create logs directory
dir.create(
  "logs",
  recursive = TRUE,
  showWarnings = FALSE
)

# STEP 3: Capture execution start time
start_time <- Sys.time()

# STEP 4: Initialize execution details
execution_status <- "SUCCESS"
error_message <- ""
input_rows <- 0
output_rows <- 0

# STEP 5: Load data with error handling
tryCatch({
  
  # Check whether input file exists
  if (!file.exists(input_file)) {
    stop("Input CSV file not found")
  }
  
  # Read CSV file
  applications <- read.csv(
    input_file,
    stringsAsFactors = FALSE
  )
  
  # Count records
  input_rows <- nrow(applications)
  output_rows <- nrow(applications)
  
  # Display execution information
  cat("\nDataset loaded successfully!\n")
  
  cat("Total Rows:", input_rows, "\n")
  cat("Total Columns:", ncol(applications), "\n")
  
  # Display sample records
  cat("\nFirst 6 Records:\n")
  print(head(applications))
  
  # Inspect dataset structure
  cat("\nDataset Structure:\n")
  str(applications)
  
}, error = function(e) {
  
  # Capture failure information
  execution_status <<- "FAILED"
  error_message <<- conditionMessage(e)
  
  cat("\nError:", error_message, "\n")
  
})

# STEP 6: Capture execution end time
end_time <- Sys.time()

# Calculate execution duration in seconds
execution_duration <- as.numeric(
  difftime(end_time, start_time, units = "secs")
)

# STEP 7: Create execution log record
log_entry <- data.frame(
  execution_time = as.character(start_time),
  script_name = "01_load_data.R",
  input_file = input_file,
  input_rows = input_rows,
  output_rows = output_rows,
  execution_status = execution_status,
  execution_duration_sec = execution_duration,
  error_message = error_message
)

# STEP 8: Check whether log already exists
log_exists <- file.exists(log_file)

# STEP 9: Write execution log
write.table(
  log_entry,
  file = log_file,
  sep = ",",
  row.names = FALSE,
  col.names = !log_exists,
  append = log_exists,
  quote = TRUE
)

cat("\nExecution log saved to:", log_file, "\n")
cat("Execution Status:", execution_status, "\n")
