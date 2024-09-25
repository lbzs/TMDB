
# 🎬 TMDB iOS App

![Platform](https://img.shields.io/badge/platform-iOS-lightgrey)
![Swift](https://img.shields.io/badge/language-Swift-orange)

An iOS app built using Swift that integrates with [TheMovieDatabase API](https://www.themoviedb.org/documentation/api) to display information about movies, TV shows, and actors. Users can search for movies, view trending films, explore movie details, and much more.

## 📱 Features

- Browse trending movies, TV shows, and actors.
- Search movies, TV shows, or people by name.
- View detailed information such as cast, release date, and ratings.
- Mark favorites and browse them offline.
- Poster image gallery with high-resolution images fetched from TMDb.
- Pagination for improved performance with large datasets.

## 🛠️ Technologies

- **Swift**: The app is written in Swift.
- **SwiftUI**: For building responsive and smooth user interfaces.
- **URLSession**: To handle network requests.
- **TMDB API**: Fetching data about movies, TV shows, and actors.
- **Codable**: For JSON parsing.
- **SwiftData**: For storing user favorites locally.

## 📸 Screenshots

| Home Screen | Movie Details | Search |
|-------------|---------------|--------|
| ![Home Screen](assets/home.png) | ![Movie Details](assets/details.png) | ![Search](assets/search.png) |

## 🛠️ Requirements

- iOS 16.3+
- Xcode 15.3+
- Swift 5.7+
- [TheMovieDatabase API Key](https://www.themoviedb.org/signup)

## 🔑 API Setup

1. Go to [TheMovieDatabase](https://www.themoviedb.org/) and sign up for an account.
2. Create a new API key from your account settings.
3. Add your API key to the project:
   
   - Open the project in Xcode.
   - Locate `Config.swift` or the appropriate file where the API keys are stored.
   - Replace the placeholder with your actual API key:
     ```swift
     let apiKey = "YOUR_API_KEY_HERE"
     ```

## 🔨 Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/lbzs/TMDB.git
   ```
2. Navigate into the project directory:
   ```bash
   cd TMDB
   ```
3. Open the `.xcworkspace` file in Xcode:
   ```bash
   open TMDB.xcworkspace
   ```
4. Run the project on the simulator or your device by pressing `Cmd + R`.

## 🔧 Configuration

You can configure the following settings:

- **Image Quality**: The app loads high-resolution images from the TMDB API by default. You can adjust the resolution by changing the base image URL.

## 🧩 Architecture

The app follows the **MVVM (Model-View-ViewModel)** architecture pattern to ensure separation of concerns and testability.

- **Model**: Holds the data retrieved from TMDB API.
- **View**: The UI layer built using SwiftUI.
- **ViewModel**: Responsible for fetching data and business logic.

## 🗃️ API Usage

The app uses the following endpoints of TheMovieDatabase API:

- **Trending Movies**: `/trending/movie/week`
- **Search Movies**: `/search/movie`
- **Movie Details**: `/movie/{movie_id}`
- **Movie Images**: `/movie/{movie_id}/images`
- **Movie Cast**: `/movie/{movie_id}/credits`

## 👨‍💻 Author

- **Bálint Lakatos** - [GitHub](https://github.com/lbzs)
