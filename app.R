library(shiny)
library(shinythemes)

# Mood dictionary
mood_dict <- list(
  happy = list(valence = 0.9, energy = 0.8, tempo = 120),
  sad = list(valence = 0.2, energy = 0.3, tempo = 70),
  energetic = list(valence = 0.6, energy = 0.9, tempo = 150),
  calm = list(valence = 0.4, energy = 0.2, tempo = 60)
)

# Cosine similarity function
cosine_similarity <- function(x, y) {
  sum(x * y) / (sqrt(sum(x^2)) * sqrt(sum(y^2)))
}

# Recommendation function
recommend_songs <- function(user_features, dataset, user_genre) {
  genre_filtered <- dataset[grepl(user_genre, tolower(dataset$genre)), ]
  genre_filtered <- unique(genre_filtered)
  if (nrow(genre_filtered) == 0) return(NULL)
  
  similarities <- apply(genre_filtered[, c("valence", "energy", "tempo")], 1, function(song_vector) {
    cosine_similarity(unlist(user_features), as.numeric(song_vector))
  })
  
  genre_filtered$similarity <- similarities
  genre_filtered[order(-genre_filtered$similarity), ]
}

# UI
ui <- fluidPage(
  theme = shinytheme("flatly"),
  
  fluidRow(
    column(12, align = "center",
           h2("🎵 Mood-Based Song Recommender")
    )
  ),  
  # Centered input panel
  fluidRow(
    column(width = 3),
    column(
      width = 6,
      wellPanel(
        fileInput("file", "Upload Your Spotify Dataset (CSV)", accept = ".csv"),
        selectInput("mood", "Choose Your Mood 🎧",
                    choices = c("Happy 😊", "Sad 😢", "Energetic 💪", "Calm 🌙")),
        selectInput("genre", "Choose Your Preferred Genre 🎶",
                    choices = c("pop", "rock", "country", "metal", "hip hop", "r&b", 
                                "dance/electronic", "folk/acoustic", "easy listening", 
                                "latin", "blues", "world/traditional", "jazz", "classical")),
        actionButton("go", "Get Recommendations 🎯"),
        textOutput("errorMsg")
      )
    ),
    column(width = 3)
  ),
  
  fluidRow(
    column(12, align = "center",
           h4("🎵 Your Curated Song List")
    )
  ),
  
  # Table output
  fluidRow(
    column(12, align = "center",
           tableOutput("songTable")
    )
  )
)

# Server
server <- function(input, output) {
  
  dataset <- reactive({
    req(input$file)
    tryCatch({
      df <- read.csv(input$file$datapath)
      na.omit(df)
    }, error = function(e) {
      output$errorMsg <- renderText("❌ Failed to read the dataset. Please upload a valid CSV.")
      return(NULL)
    })
  })
  
  recommendations <- eventReactive(input$go, {
    req(dataset())
    req(input$genre != "")
    
    mood_input <- tolower(gsub(" .*$", "", input$mood))
    genre_input <- tolower(input$genre)
    
    if (!mood_input %in% names(mood_dict)) {
      output$errorMsg <- renderText("❌ Invalid mood selected.")
      return(NULL)
    }
    
    user_features <- mood_dict[[mood_input]]
    result <- recommend_songs(user_features, dataset(), genre_input)
    
    if (is.null(result) || nrow(result) == 0) {
      output$errorMsg <- renderText("❌ No matching songs found. Try another genre.")
      return(NULL)
    }
    
    output$errorMsg <- renderText("")
    return(result)
  })
  
  output$songTable <- renderTable({
    top_songs <- head(recommendations(), 10)
    if (!is.null(top_songs)) {
      top_songs[, c("song", "artist", "genre")]
    }
  })
}

# Run the app
shinyApp(ui = ui, server = server)