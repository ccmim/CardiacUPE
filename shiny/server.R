function(input, output, session) {
  
  rv <- reactiveValues()
  
  ### UI ###
  
  output$genetic_loci_ui <- renderUI({
    titlePanel("Genetic loci")
    fluidPage(
      selectInput(
        inputId = "locus", 
        label = "Select locus", 
        choices = names(loci)
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
    gwas_across_runs_df %>% 
      filter(locus_name %in% input$locus) %>% 
      top_n(n=10, wt=-P) %>%
      select(-run, -CHR, -locus_name)
  })
  
  output$manhattan <- renderImage({
    list(
      src=get_manhattan_path(get_best_phenotype_per_locus(input$locus)),
      width="1000px"
    )}, deleteFile=FALSE
  )
  
  output$meshes <- renderImage({
    region <- loci[input$locus]
    filename <- glue::glue("/home/rodrigo/01_repos/CardiacGWAS/{region}.png")
    list(
      src=filename,
      width="1000px"
    )}, deleteFile=FALSE
  )
  
}
