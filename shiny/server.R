get_best_phenotype_per_locus <- function(locus) {
  z_var <- gwas_across_runs_df %>% filter(region == locus) %>% top_n(n=1, wt=-P) %>% .$pheno %>% strsplit(., split = "_") %>% .[[1]] %>% .[3]
  run_id <- gwas_across_runs_df %>% filter(region == locus) %>% top_n(n=1, wt=-P) %>% .$run
  exp_id <- gwas_across_runs_df %>% filter(region == locus) %>% top_n(n=1, wt=-P) %>% .$pheno %>% strsplit(., split = "_") %>% .[[1]] %>% .[1]
  c(experiment=exp_id, run=run_id, z_var=z_var)
}

get_manhattan_path <- function(phenotype) {
  
  exp_id <- phenotype['experiment']
  run_id <- phenotype['run']
  z_var <- phenotype['z_var']
  
  filename <-glue::glue("GWAS__{z_var}__{exp_id}_{run_id}__manhattan.png")
  glue::glue("{mlruns_dir}/{exp_id}/{run_id}/artifacts/GWAS_adj_10PCs/figures/{filename}")
  
}


function(input, output, session) {
  
  rv <- reactiveValues()
  
  ### UI ###
  
  output$genetic_loci_ui <- renderUI({
    titlePanel("Genetic loci")
    fluidPage(
      selectInput(
        inputId = "locus", 
        label = "Select locus", 
        choices = loci
      )
    )
  })
  
  output$coma_runs_ui <- renderUI({
    titlePanel("CoMA runs")
  })
  
  output$coma_runs_dt <- renderDataTable({
    coma_runs_df
  })
  
  output$genetic_loci_dt <- renderDataTable({
    gwas_across_runs_df <- gwas_across_runs_df %>% filter(region == input$locus)
    gwas_across_runs_df <- gwas_across_runs_df %>% top_n(n=10, wt=-P)
    gwas_across_runs_df <- gwas_across_runs_df %>% select(-run, -CHR, -locus_name)
    gwas_across_runs_df
  })
  
  output$manhattan <- renderImage({
    list(
      src=get_manhattan_path(get_best_phenotype_per_locus(input$locus)),
      width="1000px"
    )}, deleteFile=FALSE
  )
  
  output$meshes <- renderImage({
    region <- input$locus
    filename <- glue::glue("/home/rodrigo/01_repos/CardiacGWAS/results/figs/{region}.png")
    list(
      src=filename,
      width="1000px"
    )}, deleteFile=FALSE
  )
  
  output$locuszoom <- renderImage({
    region <- input$locus
    filename <- glue::glue("/home/rodrigo/tmp/locuszoom_by_region/{region}__500kb*.png")
    filename <-  Sys.glob(filename)[1]
    list(
      src=filename,
      width="1000px"
    )}, deleteFile=FALSE
  )
  
}
