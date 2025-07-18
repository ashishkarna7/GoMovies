# GoMovies
A native iOS application to search and manage favorite movies, built using **SwiftUI** and the **Observer Design Pattern**.

## Features
 - Search movies with pagination and pull-to-refresh
 - Toggle favorite option
 - View detailed movie information
 - Offline caching via NSCache and UserDefaults
 - Error handling for various scenarios
 - Simple and clean UI tailored for this assignment
 
## Requirements
 - Xcode: Version 16.4 or Later
 - Swift Language: 5
 - iOS deployment target: 17.6 or Later
 
 
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
* **NSCache** used for in-memory data caching.
* **UserDefaults** used to persist favorite movie IDs.

## Challenges

* Toggling favorite state from multiple views while keeping a single source of truth.
* Avoiding repeated network calls during active search.
* Managing data persistence under platform limitations.

## Solutions

* Injected a shared `MovieProvider` into the SwiftUI environment.
* Added a debounce mechanism during search input.
* Used NSCache to reduce API requests and speed up loading.
* UserDefaults used for lightweight, persistent storage of favorites.

## Limitations

* Limited data storage capacity with UserDefaults.
* No image caching solution implemented yet.

## Author

**Ashish Karna**
Senior iOS Engineer
[LinkedIn](https://www.linkedin.com/in/ashish-karna-177b7187/) | [GitHub](https://github.com/ashishkarna7)
