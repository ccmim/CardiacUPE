get_best_phenotype_per_locus <- function(locus) {
  z_var <- gwas_across_runs_df %>% filter(region == locus) %>% top_n(n=1, wt=-P) %>% .$pheno %>% strsplit(., split = "_") %>% .[[1]] %>% .[3]
  run_id <- gwas_across_runs_df %>% filter(region == locus) %>% top_n(n=1, wt=-P) %>% .$run
  exp_id <- gwas_across_runs_df %>% filter(region == locus) %>% top_n(n=1, wt=-P) %>% .$pheno %>% strsplit(., split = "_") %>% .[[1]] %>% .[1]
  c(experiment=exp_id, run=run_id, z_var=z_var)
}

get_var_name <- function(x, n) substr(x, start = nchar(x)-3, stop = nchar(x))

get_manhattan_path <- function(phenotype) {
  
  exp_id <- phenotype['exp_id']
  run_id <- phenotype['run_id']
  z_var <- phenotype['z_var']
  
  filename <-glue::glue("GWAS__{z_var}__{exp_id}_{run_id}__manhattan.png")
  print(filename)
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
  }, server = TRUE)
  
  output$genetic_loci_dt <- renderDataTable({
    gwas_across_runs_df <- gwas_across_runs_df %>% filter(region == input$locus)
    gwas_across_runs_df <- gwas_across_runs_df %>% top_n(n=10, wt=-P)
    gwas_across_runs_df <- gwas_across_runs_df %>% select(-run, -CHR, -locus_name)
    gwas_across_runs_df
  }, selection = list(mode = 'single', selected=1))
  
  output$manhattan <- renderImage({
    
    #best_phenotype <- get_best_phenotype_per_locus(input$locus)
    
    s = as.integer(input$genetic_loci_dt_rows_selected[1])
    selected_run <- gwas_across_runs_df%>% filter(region == input$locus) %>% top_n(n=10, wt=-P) %>% select(-CHR, -locus_name) %>% .[s, ]
    exp_id <- "1"
    run_id <- selected_run[,'run']
    z_var <- selected_run[1,'pheno'] %>% get_var_name(4)
      
    selected_phenotype <- c("exp_id"=exp_id, "run_id"=run_id, "z_var"=z_var)
    
    list(
      src=get_manhattan_path(selected_phenotype),
      width="1000px"
    )}, deleteFile=FALSE
  )
  
  output$tt <- renderPrint({
    s = input$genetic_loci_dt_rows_selected
    s[1]
    # print(kk)
    #kk
  })
  
  output$meshes <- renderImage({
    
    s = as.integer(input$genetic_loci_dt_rows_selected[1])
    selected_run <- gwas_across_runs_df%>% filter(region == input$locus) %>% top_n(n=10, wt=-P) %>% select(-CHR, -locus_name) %>% .[s, ]
    print(selected_run)
    
    exp_id <- "1"
    run_id <- selected_run[,'run']
    z_var <- selected_run[1,'pheno'] %>% get_var_name(4)
    
    # region <- input$locus
    filename <- glue::glue("/home/rodrigo/01_repos/CardiacCOMA/mlruns/{exp_id}/{run_id}/artifacts/z_effect_on_shape/{z_var}.png")
    
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
