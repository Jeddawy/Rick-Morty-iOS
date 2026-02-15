# Rick & Morty Character Explorer

A clean, modern iOS application built with SwiftUI to explore characters from the Rick and Morty API.

## ✨ Features
-   **Character List**: Scrollable list of characters with infinite scrolling (pagination).
-   **Search**: Real-time search by character name with debouncing.
-   **Detail View**: Comprehensive character details including location, species, and status.
-   **Offline Support**: Graceful error handling for network connectivity issues.
-   **Modern UI**: Clean interface using SwiftUI and MVVM architecture.

## 🚀 Getting Started

### Prerequisites
- Xcode 15.0+
- iOS 16.0+

### Installation & Run
1.  Clone the repository.
2.  Open `Rick&Morty.xcodeproj`.
3.  Ensure the "Rick&Morty" scheme is selected.
4.  Press `Cmd + R` or click the **Run** button to build and launch the app in the simulator.

### Testing
Run the unit test suite to verify the logic:
1.  Select the **Rick&Morty** scheme.
2.  Press `Cmd + U` to run all tests.
3.  Check the **Test Navigator** for results.

---

## 🏗 Architecture

The application follows a **Clean Architecture** pattern using **MVVM** (Model-View-ViewModel) and **Coordinator** principles.

### Key Components
-   **Dependency Injection (DI)**: A centralized `DIContainer` manages the creation and injection of dependencies (`APIClient`, `Services`, `Repositories`) into ViewModels and Views. This ensures testability and loose coupling.
-   **Repository Pattern**: `CharacterRepository` abstract the data source. The ViewModel depends on the protocol, not the implementation.
-   **Network Layer**: A protocol-oriented network layer using `async/await`. It supports generic requests, custom encoding, and error handling.
-   **SwiftUI & Combine**: The UI is built with SwiftUI, observing `@Published` properties in ViewModels. `Combine` is used for handling search text debouncing.

### Directory Structure
-   `App`: Entry point (`Rick_MortyApp`) and Dependency Injection (`DIContainer`).
-   `Feature`: Feature-specific code (Views, ViewModels).
-   `Domain`: Protocols and Models.
-   `Repository`: Implementations of data fetching logic.
-   `Network`: Core networking infrastructure (`APIClient`, `Endpoints`).
-   `Common`: Shared utilities, constants (`AppConstants`), and reusable views (`NetworkImageView`).

### System Design
Below is the high-level system design highlighting the separation of concerns between Presentation, Domain, and Data layers.

<img width="1503" height="1020" alt="Diagram" src="https://github.com/user-attachments/assets/c3d988a1-ed0b-4063-bc3c-c438b19015a7" />


### Demo
Below and GIF Demo for the App

![Demo](https://github.com/user-attachments/assets/a3dc0a09-c4ef-489b-93c2-2553edcc2611)


## 🧐 Decisions & Assumptions

### Technical Decisions
-   **No 3rd Party Libraries**: The app uses native frameworks (URLSession, SwiftUI, Combine) to minimize dependencies and binary size.
-   **Async/Await**: Used for all asynchronous operations for cleaner, more readable code compared to closures/Combine.
-   **Enums for Constants**: Hardcoded strings and images are managed in `AppConstants.swift` for type safety and easy localization support in the future.

### Assumptions
-   **Pagination**: The API provides pagination info (`next` url). The app assumes standard pagination behavior and loads more data when the user scrolls near the end of the list.
-   **Error Handling**: The app handles standard network errors (offline, server error) and presents user-friendly messages with retry options.
-   **Image Caching**: Basic image caching is handled by OS conventions via `AsyncImage` and `URLCache`.
