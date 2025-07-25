# GoMovies
A native iOS application to search and manage favorite movies, built using **SwiftUI** and the **Observer Design Pattern**.

## Features
 - Search movies with pagination and pull-to-refresh
 - Toggle favorite option
 - View detailed movie information
 - Offline caching via SwiftData and UserDefaults
 - In memory caching of image via NSCache
 - Error handling for various scenarios
 - Simple and clean UI tailored for this assignment
 
## Requirements
 - Xcode: Version 16.4 or Later
 - Swift Language: 5
 - iOS deployment target: 18 or Later
 
 
## Getting Started

### Build & Run
1. Open the project in Xcode.
2. Select the **`GoMovies`** scheme.
3. Run the app on a simulator or device.

### Unit Testing
* From the **Product** menu, select **Test**
  **or**
* Open `GoMoviesTests` file and run the tests manually.

### UI Testing
* Select the **`GoMoviesUITests`** target and run the tests.


## Architectural Decisions

* **SwiftUI** used for building the UI declaratively.
* **@Observable** state shared via `Environment` across all views.
* **Debounced** search to reduce unnecessary API calls.
* **SwiftData** used for persisting data
* **NSCache** used for in-memory data caching (especially image thumbnail).
* **UserDefaults** used to persist favorite movie IDs.
* **PreviewModifier** for previewing the sample swiftdata model

## Challenges

* Toggling favorite state from multiple views while keeping a single source of truth.
* Avoiding duplicate network calls for image thumnail loading in list while scrolling.
* Managing data persistence under platform limitations.

## Solutions

* Injected a shared **FavoritesManager** into the SwiftUI environment.
* Added a **debounce** mechanism during search input.
* Used **SwiftData** to persist the latest fetched search results
* Used **NSCache** for caching image
* Used **Task** to avoid duplicate network calls for image loading
* Used **UserDefaults** used for lightweight, persistent storage of favorite ids.

## Author

**Ashish Karna**
Senior iOS Engineer
[LinkedIn](https://www.linkedin.com/in/ashish-karna-177b7187/) | [GitHub](https://github.com/ashishkarna7)
