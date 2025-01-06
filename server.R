#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    https://shiny.posit.co/
#

library(shiny)
library(leaflet)
library(dplyr)
library(tidyr)
library(tibble)
library(leaflet.extras)
# Define server logic required to draw a histogram
function(input, output, session) {
  load("data/data.Rda")
  
  ColorBy <- reactive({input$Colors})
  Origin <- reactive({input$OrigenFilter})
  Activitats <- reactive({input$Activitat})
  Years <- reactive({input$Anys})
  Anys_prot <- reactive({input$An})
  Q <- cords %>% rename(c(`Grau de Perill` = "Grau_Perill"))
  
  output$map <- renderLeaflet({
    A <- c(Activitats())
    if (Activitats() == "Tots"){
      A <- c('Alpinisme','Altres','Desconegut','Esquí de muntanya',
             'Esquí de pista','Esquí fora pista','Excursionisme',
             'Moto de neu','Raquetes','Taula de muntanya',
             'Taula fora pista','Treballant')
    }
    
    # Procesant activitats
    Dr <- Q %>% filter((Origen %in% Origin()) & (Activitat %in% A) & 
                         (as.numeric(as.character(Any)) %in% seq(Anys_prot()[1], Anys_prot()[2])))
    print(Anys_prot())
    return(    
    leaflet() %>% setView(lat  = 40.416775, lng = -3.703790, zoom = 5) %>%
      addTiles() %>% addCircles(lng = Dr$long, lat = Dr$lat, color = 
                                  ifelse(Dr[[ColorBy()]] == 0, "blue",
                                         ifelse(Dr[[ColorBy()]] < 3,"orange",
                                                "red")),
                                popup = Dr$Lloc, fillOpacity = 0.2)
    )
  })
  
  
}
