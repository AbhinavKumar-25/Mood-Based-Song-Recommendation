# Mood-Based-Song-Recommendation
A system that recommends songs based on user-selected mood using Spotify audio features and cosine similarity.

# 🎵Mood-Based Song Recommendation System
This project recommends songs based on a user's selected mood (e.g., Happy, Sad, Energetic, Calm) by analyzing audio features from Spotify data.

## 💡Project Overview
- Built a recommendation system that maps user moods to predefined audio feature vectors.
- Uses cosine similarity to find and suggest the most relevant songs based on mood.
- Created using R and Shiny for interactive UI and real-time mood-based recommendations.

## 🔍Features
- User selects a mood (Happy, Sad, Energetic, Calm)
- Backend computes similarity between mood profile and songs
- Top N similar songs are recommended
- Interactive Shiny web app for clean interface

## ⚙️Tech Stack
- **Language**: R
- **Libraries**: `shiny`, `dplyr`, `ggplot2`
- **Method**: Cosine similarity for mood-song matching
- **Data**: Spotify Song Features dataset
