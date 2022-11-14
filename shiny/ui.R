######################################################

side_panel <- function() {
 
  sidebarPanel(tabsetPanel(
     id = "controlPanel", selected = "loci",
     
     tabPanel(
       title = "Genetic loci",
       uiOutput("genetic_loci_ui"),
       value = "loci" # Linked to input.controlPanel's value to be used in conditionalPanel below
     ),
     
     tabPanel(
       title = "CoMA runs",
       uiOutput("coma_runs_ui"),
       value = "coma"
     )
     #,
     #tabPanel("Docs", htmlOutput("docsTab"))
  ))
}

# many_newlines <- function(n) ifelse(n > 0, { HTML(strrep("<br/>", n))}, {HTML(strrep("<nobr/>", -n)) } )

many_newlines <- function(n) {
 HTML(strrep("<br/>", n))
}
 
many_non_newlines <- function(n) {
 HTML(strrep("<nobr/>", n))
}
  
######################################################

main_panel <- function() {
  mainPanel(
    
   fluidRow(
     
     br(),
     
     conditionalPanel(
       condition = "input.controlPanel == \"loci\"",
       
       DT::dataTableOutput("genetic_loci_dt"),
       # verbatimTextOutput("tt"),
       
       imageOutput("manhattan", width="20px"),
       imageOutput("meshes", width="20px"),
       many_non_newlines(1000),
       
       imageOutput("locuszoom", width="20px"),
       many_newlines(20)
       
     ),
     
     conditionalPanel(
       condition = "input.controlPanel == \"coma\"",
       DT::dataTableOutput("coma_runs_dt")
       # plotOutput("plot_x_vs_y", brush = brushOpts(id = "plot1_brush"))
     ),
     
     br()
   )
 )  # end of mainPanel
}

######################################################

shinyUI(
  fluidPage(
    titlePanel("GWAS - results exploration"),
    side_panel(),
    main_panel()
))# 