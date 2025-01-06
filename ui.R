## ui.R ##
library(shiny)
library(leaflet)
library(leaflet.extras)
library(shinydashboard)

dashboardPage(
  dashboardHeader(title = 'Accidentes de Alud'),
  dashboardSidebar(
    # First load data
    # Inputs
    selectizeInput(label = 'Origen', inputId = 'OrigenFilter', choices = c('Accidental', 
                                                         'Desconegut', 
                                                         'Natural'),
                   selected = c('Accidental', 'Desconegut', 'Natural'), 
                   multiple = TRUE,
                   options = list(
                     plugins = list("remove_button")
                   )
                   ),
    
    selectizeInput(label = 'Activitat', inputId = 'Activitat', choices = 
                     c('Tots','Alpinisme','Altres','Desconegut','Esquí de muntanya',
                       'Esquí de pista','Esquí fora pista','Excursionisme',
                       'Moto de neu','Raquetes','Taula de muntanya',
                       'Taula fora pista','Treballant'), multiple = FALSE),
    
    # selectizeInput(label = 'Anys', inputId = 'Anys',choices = 
    #                                               c('2024','2023','2022',
    #                                                 '2021','2020','2019','2018',
    #                                                 '2017','2016','2015','2014',
    #                                                 '2013','2012','2011','2010',
    #                                                 '2009','2008','2007'), 
    #                multiple = TRUE, selected = c('2024','2023','2022',
    #                                              '2021','2020','2019','2018',
    #                                              '2017','2016','2015','2014',
    #                                              '2013','2012','2011','2010',
    #                                              '2009','2008','2007'),
    #                options = list(
    #                  plugins = list("remove_button")
    #                  )
    # 
    #           ),
    sliderInput(inputId = "An", label = "Anys", min = 2007, max = 2024, step = 1, 
                value = c(2007,2024))
  ),
  dashboardBody(
    selectizeInput(inputId = "Colors", label="Coloreja per:",
                   # choices = c('Perill', 
                   #            'Arrosegats', 
                   #            'Ferits', 
                   #            'Morts'),
                   choices = c('Grau de Perill',
                              'Arrossegats', 
                              'Ferits', 
                              'Morts'), multiple = FALSE, selected = 'Grau de Perill'),
    # actionButton(inputId = "Grau_Perill", label = "Perill"),
    # # actionButton(inputId = "Membres", label = "Membres"),
    # actionButton(inputId = "Arrossegats", label = "Arrosegats"),
    # actionButton(inputId = "Ferits", label = "Ferits"),
    # actionButton(inputId = "Morts", label = "Morts"),
    br(), br(),
    fluidRow(leafletOutput('map'))
    
    )
)