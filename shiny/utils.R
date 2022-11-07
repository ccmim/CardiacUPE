get_best_phenotype_per_locus <- function(locus) {
  z_var <- gwas_across_runs_df %>% filter(locus_name == locus) %>% top_n(n=1, wt=-P) %>% .$pheno %>% strsplit(., split = "_") %>% .[[1]] %>% .[3]
  run_id <- gwas_across_runs_df %>% filter(locus_name == locus) %>% top_n(n=1, wt=-P) %>% .$run
  exp_id <- gwas_across_runs_df %>% filter(locus_name == locus) %>% top_n(n=1, wt=-P) %>% .$pheno %>% strsplit(., split = "_") %>% .[[1]] %>% .[1]
  c(experiment=exp_id, run=run_id, z_var=z_var)
}

get_manhattan_path <- function(phenotype) {
  
  exp_id <- phenotype['experiment']
  run_id <- phenotype['run']
  z_var <- phenotype['z_var']

  filename <-glue::glue("GWAS__{z_var}__{exp_id}_{run_id}__manhattan.png")
  glue::glue("{mlruns_dir}/{exp_id}/{run_id}/artifacts/GWAS_adj_10PCs/figures/{filename}")
  
}