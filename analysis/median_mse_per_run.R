source("utils.R")
source("constants.R")

runs <- basename(Sys.glob("data/coma_output/2020*"))

params_df <- read.delim(PARAMS_F)
kk <- inner_join(
  gather_perf(runs),
  params_df %>% select(all_of(relevant_cols)),
  by=c("run_id"="experiment")
)


median_mse_per_run <- kk %>% filter(subset=="test") %>% group_by(run_id) %>% summarise(median_mse=median(mse))
median_mse_per_run <- median_mse_per_run %>% rename(experiment=run_id)
median_mse_per_run <- inner_join(median_mse_per_run, params_df, by=c("experiment"))
median_mse_per_run <- median_mse_per_run %>% select(experiment, median_mse)
write_csv(median_mse_per_run, path = median_mse_filename)
