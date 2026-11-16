
run_logged_script <- function(script_path) {
  
  # 1. Start execution timer
  start_time <- Sys.time()
  
  # 2. Set default execution details
  execution_status <- "SUCCESS"
  error_message <- ""
  input_file <- ""
  input_rows <- NA_integer_
  output_rows <- NA_integer_
  
  # 3. Execute the selected script
  tryCatch({
    
    source(script_path, local = new.env(parent = globalenv()))
    
  }, error = function(e) {
    
    execution_status <<- "FAILED"
    error_message <<- conditionMessage(e)
    
  })
  
  # 4. Calculate execution duration
  execution_duration <- as.numeric(
    difftime(Sys.time(), start_time, units = "secs")
  )
  
  # 5. Create a log record
  log_entry <- data.frame(
    execution_time = as.character(start_time),
    script_name = basename(script_path),
    input_file = input_file,
    input_rows = input_rows,
    output_rows = output_rows,
    execution_status = execution_status,
    execution_duration_sec = execution_duration,
    error_message = error_message
  )
  
  # 6. Save the record
  log_file <- "logs/execution_log.csv"
  
  dir.create("logs", showWarnings = FALSE)
  
  write.table(
    log_entry,
    file = log_file,
    sep = ",",
    row.names = FALSE,
    col.names = !file.exists(log_file),
    append = file.exists(log_file),
    quote = TRUE
  )
  
  # 7. Display the result
  print(log_entry)
}

