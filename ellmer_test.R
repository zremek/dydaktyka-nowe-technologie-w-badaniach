library(ellmer)
library(tidyverse)

# llama3.1:8b is downloaded

# run `ollama serve` in terminal

chat <- chat_ollama(model = "llama3.1:8b")
chat$chat("Tell me three jokes about statisticians")

plot_gen <- chat$chat("Give me code for a ggplot data viz. 
                      data name is diagnoza, gp3 is dependent categorical var, 
                      plec is independent categorical var")

print(plot_gen)

filter_gen <- chat$chat("Give me code for data filtering, 
                        I need only women, 'kobieta' in Polish, 
                        data is diagnoza, var plec")


# yt comments coding test #### 
library(purrr)

# Example data
comments_df <- tibble(
  id = 1:5,
  comment = c(
    "This video changed my life, so inspiring!",
    "The audio quality is terrible, can't hear anything",
    "First! Great content as always",
    "I disagree with point 3, here's why...",
    "Where can I buy the thing mentioned at 4:32?"
  )
)

# Define your prompt template
classify_comment <- function(comment_text) {
  chat <- chat_ollama(model = "llama3.1:8b")  # fresh chat per comment
  
  prompt <- paste0(
    "Classify the following YouTube comment into exactly one topic from this list:\n",
    "PRAISE, CRITICISM, QUESTION, DISCUSSION, SPAM\n\n",
    "Reply with only the topic label, nothing else.\n\n",
    "Comment: ", comment_text
  )
  
  chat$chat(prompt)
}

# Apply to dataframe
comments_df <- comments_df |>
  mutate(topic = map_chr(comment, classify_comment))


# pdf summary test ##### 

library(pdftools)

# Download and read the PDF directly
pdf_text <- pdf_text("https://arxiv.org/pdf/2603.16900")

# Collapse all pages into one string
pdf_combined <- paste(pdf_text, collapse = "\n\n")

chat300 <- chat_ollama(
  model = "llama3.1:8b",
  api_args = list(timeout = 300)  # 5 minutes
)

# Try first 1 page only
pdf_1 <- paste(pdf_combined[1:1], collapse = "\n\n")

prompt <- paste0(
  "Here is a research paper:\n\n",
  pdf_1,
  "\n\nSummarise the main research question, methods, and findings."
)


# --- timed call with spinner ---
library(cli)
cli_progress_step("Sending paper to model... (this may take a while)")
start_time <- proc.time()

arxiv_sum <- chat300$chat(prompt)

elapsed <- proc.time() - start_time
cli_progress_done()

cli_alert_success("Done in {round(elapsed['elapsed'], 1)} seconds")
cat("\n--- SUMMARY ---\n", arxiv_sum, "\n")

summarise_in_chunks <- function(pages, chat, chunk_size = 3) {
  chunks <- split(pages, ceiling(seq_along(pages) / chunk_size))
  
  summaries <- vector("character", length(chunks))
  for (i in seq_along(chunks)) {
    cli::cli_alert_info("Summarising chunk {i} of {length(chunks)}...")
    text <- paste(chunks[[i]], collapse = "\n\n")
    chat_i <- chat_ollama(model = "llama3.1:8b")
    summaries[[i]] <- chat_i$chat(paste0(
      "Summarise this section of a research paper briefly:\n\n", text
    ))
  }
  
  # Final pass: summarise the summaries
  cli::cli_alert_info("Creating final summary...")
  final_chat <- chat_ollama(model = "llama3.1:8b")
  final_chat$chat(paste0(
    "Here are summaries of sections of a research paper:\n\n",
    paste(summaries, collapse = "\n\n"),
    "\n\nWrite a single coherent summary covering the research question, methods, and findings."
  ))
}

arxiv_sum_chunks <- summarise_in_chunks(pdf_text, chat300)

# save.image()

# yt coding comparision #### 

test_comment <- "tbh ten film był mega boring ale ten git moment na końcu to był 🔥🔥"

for (m in c("qwen2.5:14b", "mistral-small", "gemma3:12b")) {
  chat <- chat_ollama(model = m)
  start <- proc.time()
  response <- chat$chat(paste0(
    "You are assisting academic social media research. ",
    "Classify this Polish/English mixed social media comment into one of: ",
    "POSITIVE, NEGATIVE, NEUTRAL, MIXED\n\n",
    "Reply with the label only.\n\n",
    "Comment: ", test_comment
  ))
  elapsed <- round((proc.time() - start)["elapsed"], 1)
  cat(m, "->", response, "(", elapsed, "s)\n")
}




for (m in c("qwen2.5:14b", "mistral-small", "gemma3:12b")) {
  chat <- chat_ollama(model = m)
  start <- proc.time()
  response <- chat$chat(paste0(
    "Here is a research paper:\n\n",
    pdf_combined,
    "\n\nSummarise the main research question, methods, and findings."
  ))
  elapsed <- round((proc.time() - start)["elapsed"], 1)
  cat(m, "->", response, "(", elapsed, "s)\n")
} # error!

for (m in c("llama3.1:8b", "qwen2.5:14b", "mistral-small", "gemma3:12b")) {
  chat <- chat_ollama(model = m)
  start <- proc.time()
  response <- chat$chat(
    "Tell me three jokes about sociologists"
  )
  elapsed <- round((proc.time() - start)["elapsed"], 1)
  cat(m, " (", elapsed, "s)\n")
} 

