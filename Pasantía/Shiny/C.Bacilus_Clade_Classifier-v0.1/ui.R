library(shiny)
library(shinythemes)
library(markdown)

ui <- fluidPage(theme = shinytheme("cerulean"),
                navbarPage(
                  "B.Cereus Clade Test",
                  tabPanel("Test",
                           sidebarPanel(
                             textInput("Input_sequence","Test Sequence", ""), 
                             selectInput("format", "Sequence format", choices = list("FASTA" = "fasta", "GenBank" = "gen_bank"),  selected = "FASTA"),                             
                             fileInput('file', 'or upload file',accept=c('text/FASTA','FASTA','.fasta','.txt')), #incialmente estaba para que pueda solo aceptar archivos fasta
                             actionButton("submitbutton", "Submit", class = "btn btn-primary"),
                             actionButton("clear_signal","Clear"),

                           ), # sidebarPanel
                           
                           mainPanel(
                             h1("Results"),
                             verbatimTextOutput('result'),
                             
                           ) # Panel principal
                           
                  ), # Test, tabPanel
                  tabPanel("About", titlePanel("About"), align="justify"), #renderiza el archivo about.md en la p?gina About
                  tabPanel("Contact", titlePanel("Contact"), align="justify"),
                  tabPanel("Citing Us", titlePanel("Citing Us"), align="justify")
                  
                  #tabPanel("About", titlePanel("About"), div(includeMarkdown("C:\Users\Loren\Desktop\Pasant?a\Shiny\0.1\about.md"), align="justify")), #renderiza el archivo about.md en la p?gina About
                  #tabPanel("Contact", titlePanel("Contact"), div(includeMarkdown("C:\Users\Loren\Desktop\Pasant?a\Shiny\0.1\contact.md"), align="justify")),
                  #tabPanel("Citing Us", titlePanel("Citing Us"), div(includeMarkdown("C:\Users\Loren\Desktop\Pasant?a\Shiny\0.1\citing_us.md"), align="justify"))
                  
                  
                  # En algunas o todas de estas 3 lineas hay problemas 
                  
                ) # navbarPage
) # fluidPage

server <- function(input, output) {
    
  output$contents <- renderPrint({
    if (input$submitbutton>0) { 
      if(runif(1, 0, 1) > 0.5 ){
      return("0")
    } else {
      return("1")
    }}
  })
  
  
  observeEvent(input$clear_signal, {
    if (!is.null(input$file)) {
      file.remove(input$file)
    }
    updateSelectInput(session,'format',selected = "")
  })
  

}

shinyApp(ui = ui, server = server)

