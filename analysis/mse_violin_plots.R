source("utils.R")

runs <- basename(Sys.glob("data/coma_output/2020*"))

kk <- inner_join(
  gather_perf(runs),
  params_df %>% select(all_of(relevant_cols)),
  by=c("run_id"="experiment")
)


median_mse_per_run <- kk %>% filter(subset=="test") %>% group_by(run_id) %>% summarise(median_mse=median(mse))
median_mse_per_run <- inner_join(median_mse_per_run, params_df %>% select(all_of(relevant_cols)),   by=c("run_id"="experiment"))

ss <- median_mse_per_run %>% group_by(z, kld_weight) %>% summarise(best_median_mse=min(median))

best_median_mse_per_run <- inner_join(ss, median_mse_per_run, by=c("best_median_mse"="median", "kld_weight", "z"))
best_runs <- best_median_mse_per_run$run_id

best_kk <- kk %>% filter(run_id %in% best_runs) %>% filter(subset=="test")
best_kk <- best_kk %>% select(-ID, -learning_rate, -seed)
best_kk <- best_kk %>% filter(kld_weight != 0.1 & kld_weight != 1e-3)

pca_perf_df <- read.csv("data/coma_output/PCA__LV__scaled__5000_samples/performance.csv") %>% rename(z=n) %>% mutate(z=n+1, run_id="PCA") %>% select(-ID, -subject_id, -mse_shuffled)
pca_perf_df$kld_weight <- -1

best_kk <- rbind(pca_perf_df, best_kk)
pp <- ggplot(best_kk, aes(as.factor(z), mse, fill=as.factor(kld_weight)))
pp <- pp + geom_boxplot()#  + geom_boxplot(width=0.1)
pp <- pp + stat_summary(fun.y=mean, geom="point", shape=23, size=2, fill=as.factor(kld_weight))
pp <- pp + theme_bw(base_size = 20) + theme(panel.grid.minor = element_blank())
pp <- pp + ylim(c(0,1.5))
pp <- pp + xlab(expression(n[z])) + ylab("Average MSE")
pp <- pp + scale_fill_manual(
  values=c("#999999", "#E6EF00", "#E90000", "#0000E9"), name="Algorithm",
  # labels=c("PCA", expression(w[KL]"=0"), expression(w[KL]"=0.0001"), expression(w[KL]"=0.01"))
  labels=c("PCA", expression(paste("AE, ", w[KL] == 0)), expression(paste("VAE, ", w[KL] == 10^{-4})), expression(paste("VAE, ", w[KL] == 10^{-2})))) +
  theme(legend.text.align = 0
)

#, legend.justification=c(0.9,0.9), legend.position=c(0.9,0.9), legend.background = element_rect(fill="gray90", size=.5, linetype="dotted"))
# labels=c("PCA", "wKL=0", "wKL=0.0001", "wKL=0.01"))
# ggplot(best_kk, aes(as.factor(z), mse, color=as.factor(kld_weight))) + geom_violin() + theme_bw(base_size = 20) + ylim(c(0,1))