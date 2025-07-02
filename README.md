# 🎵Mood-Based Song Recommendation System
This project recommends songs based on a user's selected mood (e.g., Happy, Sad, Energetic, Calm) by analyzing audio features from Spotify data.

## 💡Project Overview
- Built a recommendation system that maps user moods to predefined audio feature vectors.
- You upload a CSV file containing songs with features: `valence`, `energy`, `tempo`, `song`, `artist`, and `genre`.
- Select your current mood (Happy, Sad, Energetic, Calm) and a preferred genre.
- Uses cosine similarity to find and suggest the most relevant songs based on mood.
- Created using R and Shiny for interactive UI and real-time mood-based recommendations.

## ⚙️Tech Stack
- **Language**: R
- **Libraries**: shiny, shinythemes
- **Method**: Cosine similarity for mood-song matching
- **UI Desing**: Flaty Theme from shinythmes
- **Data**: Spotify Song Features dataset

## ✨Future Ideas
- Integrate with Spotify API to fetch real-time tracks
- Add more moods and emotion mapping
- Improve UI with themes and animations

## 📁Project Structure
- mood-based-song-recommender/
  ├── app.R                  # Main Shiny app file
  ├── sample_dataset.csv     # Sample Spotify data for testing
  └── README.md              # Project description and usage
