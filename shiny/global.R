library(tidyverse)
library(mlflow)
library(DT)

source("utils.R")

mlruns_dir = "/home/rodrigo/01_repos/CardiacCOMA/mlruns"
client <- mlflow::mlflow_client(tracking_uri=mlruns_dir)
exp_info <- mlflow::mlflow_search_experiments(client=client)


fetch_mlflow <- function(experiment_id="1") {
  runs = mlflow::mlflow_search_runs(
    client=client,
    experiment_ids=experiment_id,
    filter="metrics.test_recon_loss < 1"
  )  
}

g <- glue::glue
results_dir <- "~/01_repos/CardiacGWAS/results"
coma_runs_df <- "{results_dir}/good_runs.csv" %>% glue::glue() %>% read.csv()
gwas_across_runs_df <- "{results_dir}/gwas_loci_summary_across_runs.csv" %>% glue::glue() %>% read.csv()
previous_gwas_df <- read.csv(g("{results_dir}/log10p_for_selected_snps_across_gwas.csv"))

loci <- c(
  "GOSR2 (chr. 17)" = "chr17_27", 
  "TTN (chr. 2)" = "chr2_108", 
  "PLN (chr. 6)" = "chr6_78", 
  "TBX5 (chr. 12)"= "chr12_69",
  "CHTOP* (chr. 1)" = "chr1_124",
  "CREBRF* (chr. 5)" = "chr5_103",
  "EN1* (chr. 2)" = "chr2_69",
  "STRN (chr. 2)" = "chr2_23",
  "BAG3 (chr. 10)" = "chr10_74",
  "LMO7 (chr. 13)" = "chr13_37",
  "RBM20 (chr. 10)" = "chr10_69",
  "CCDC91* (chr. 12)" = "chr12_19",
  "OR9Q1 (chr. 11)" = "chr11_32",  
  "ATXN2* (chr. 12)" = "chr12_67",
  "chr6 -region 84)" = "chr6_84",
  "chr3 - region 63" = "chr3_63",
  "WAC (chr. 10)" = "chr10_20"
)

# gwas_across_runs_df %>% group_by(region) %>% summarise(min(P)) %>% arrange(`min(P)`) %>% filter(`min(P)` < 1.5e-10) %>% filter(!region %in% c("chr6_79", "chr6_25", "chr6_26"))
# runs_df <- fetch_mlflow() # $metrics