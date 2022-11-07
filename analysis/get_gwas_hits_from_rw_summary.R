GWAS_DIR <- "~/GWAS/output/coma"
suffix <- "std_covariates__GBR__qc"
region_wise_summary <- file.path(GWAS_DIR, "{run_id}/{suffix}/summaries/GWAS__z*__{suffix}__regionwise_summary.tsv")
gwas_hits_summary <- file.path(GWAS_DIR, "{run_id}/{suffix}/summaries/GWAS_hits__{suffix}.csv")

extract_gwas_hits <- function(file_list) {
  df_rows <- list()
  for (file in file_list) {
    file_bn <- basename(file)
    latent_variable  <- strsplit(file_bn, split="__")[[1]][2]
    df <- read_csv(file)
    df <- df %>% filter(P < 1e-8)
    df$z <- latent_variable
    df_rows <- c(df_rows, list(df))  
  }
  bind_rows(df_rows)
}


all_summaries <- list()

for (i in seq_along(list.files(GWAS_DIR))) {
  
  print(i)
  run_id <- list.files(GWAS_DIR)[i]
  summary_files <- Sys.glob(glue::glue(region_wise_summary))
  if (length(summary_files) == 0)
    next
  
  gwas_hits_df <- extract_gwas_hits(summary_files)
  write.csv(gwas_hits_df, glue::glue(gwas_hits_summary), quote = FALSE, row.names = FALSE)
  gwas_hits_df$run_id <- run_id
  all_summaries <- c(all_summaries, list(gwas_hits_df))
  # print(summary_files)
}

write.csv(bind_rows(all_summaries), file.path(GWAS_DIR, "gwas_hits_summary_across_runs.csv"), quote = FALSE, row.names = FALSE)