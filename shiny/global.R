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

coma_runs_df <- read.csv("~/01_repos/CardiacGWAS/results/good_runs.csv")
gwas_across_runs_df <- read.csv("~/01_repos/CardiacGWAS/results/gwas_loci_summary_across_runs.csv")
previous_gwas_df <- read.csv("~/01_repos/CardiacGWAS/results/log10p_for_selected_snps_across_gwas.csv")

loci <- c(
  "GOSR2" = "chr17_27", 
  "TTN" = "chr2_108", 
  "PLN" = "chr6_78", 
  "TBX5"= "chr12_69",
  "CHTOP*" = "chr1_124",
  "CREBRF*" = "chr5_103"
)

# 
# gwas_across_runs_df %>% group_by(region) %>% summarise(min(P)) %>% arrange(`min(P)`) %>% filter(`min(P)` < 1.5e-10) %>% filter(!region %in% c("chr6_79", "chr6_25", "chr6_26"))

# runs_df <- fetch_mlflow() # $metrics