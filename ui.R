library(shiny)
source('katex.r', encoding = 'utf-8')

shinyUI(fluidPage(
      titlePanel('Cálculo Erro tipo II'),
      includeCSS("estilo.css"),
      KaTeX(),
      sidebarLayout(
         sidebarPanel(
            radioButtons('h1', 'Hipótese alternativa \\(H_1:\\)', list(
               '\\(\\mu \\ne \\mu_0 \\)' = 'a',
               '\\(\\mu < \\mu_0 \\)' = 'b',
               '\\(\\mu > \\mu_0 \\)' = 'c'
            ), inline = F),
            splitLayout(
               numericInput('ureal', '\\(\\mu\\)', 10),
               numericInput('uzero', '\\(\\mu_0\\)', 15),
               numericInput('desv', '\\(\\sigma\\)', 2, 0)
            ),
            radioButtons('conf', 'Nível de significancia', list('1%' = 0.01, '5%' = 0.05, '10%' = 0.10), selected = 0.05, inline = T)
         ),
         mainPanel(
            verticalLayout(
               plotOutput('plot'),
               uiOutput('valor')
            )
         )
      ),
      hr(),
      flowLayout(id = "cabecario",
                 p(strong("Apoio:"), br(), img(src="NEPESTEEM.png")),
                 p(strong("Agradecimento:"), br(), img(src="FAPESC.png")),
                 p(strong("Desenvolvido por:"), br(), "César Eduardo Petersen")
      )
))
