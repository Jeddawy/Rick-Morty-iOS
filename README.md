# Rick & Morty Character Explorer

A clean, modern iOS application built with SwiftUI to explore characters from the Rick and Morty API.

## ✨ Features
-   **Character List**: Scrollable list of characters with infinite scrolling (pagination).
-   **Search**: Real-time search by character name with debouncing.
-   **Detail View**: Comprehensive character details including location, species, and status.
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

The application follows **Clean Architecture** with **MVVM** (Model-View-ViewModel). Data flows in one direction: **View → ViewModel → Use Case → Repository → Service**.

### Key Components
-   **Dependency Injection (DI)**: A centralized `DIContainer` wires `APIClient`, services, repositories, use cases, and view models. This keeps the app testable and loosely coupled.
-   **Use Cases**: Application rules live in the domain layer. The ViewModel depends on **use case protocols** (e.g. `FetchCharactersUseCase`), not on the repository. Use cases orchestrate domain operations and keep presentation independent of data details.
-   **Repository Pattern**: Repositories abstract the data source (API, cache, or DB). They are responsible for **mapping DTOs to domain entities** and exposing a single, domain-oriented API. The domain layer never sees DTOs or HTTP.
-   **Network Layer**: Protocol-based networking with `async/await`: generic requests, custom encoding, and structured error handling.
-   **SwiftUI & Combine**: UI is built with SwiftUI, binding to ViewModel `@Published` state. Combine is used for search debouncing and other reactive flows.

### Directory Structure
-   `App`: Entry point (`Rick_MortyApp`) and Dependency Injection (`DIContainer`).
-   `Feature`: Feature-specific UI (Views, ViewModels, protocols like `ListDisplayable` / `ListInteractable`).
-   `Domain`: Core business layer — entities (`CharacterEntity`), repository protocol (`CharacterRepository`), and **use cases** (`FetchCharactersUseCase`).
-   `Repository`: Repository implementations that call services and map DTOs → entities.
-   `Network`: Networking (`APIClient`, endpoints, DTOs, services).
-   `Common`: Shared utilities, constants (`AppConstants`), and reusable views (`NetworkImageView`).

### System Design
High-level flow: the View talks only to the ViewModel; the ViewModel talks only to Use Cases; Use Cases use Repositories; Repositories use Services and map DTOs to Entities.

<img width="1096" height="679" alt="Screenshot 2026-02-16 at 12 59 36 AM" src="https://github.com/user-attachments/assets/166831db-210d-4990-b5da-d4dfc90839c5" />

### Demo

![Demo](https://github.com/user-attachments/assets/2e8891d4-75b7-4474-8686-06c8a1b30895)

## Decisions & Assumptions

### Technical Decisions
-   **No 3rd Party Libraries**: The app uses native frameworks (URLSession, SwiftUI, Combine) to minimize dependencies and binary size.
-   **Async/Await**: Used for all asynchronous operations for cleaner, more readable code compared to closures/Combine.
-   **Enums for Constants**: Hardcoded strings and images are managed in `AppConstants.swift` for type safety and easy localization support in the future.

### Assumptions
-   **Pagination**: The API provides pagination info (`next` url). The app assumes standard pagination behavior and loads more data when the user scrolls near the end of the list.
-   **Error Handling**: The app handles standard network errors (offline, server error) and presents user-friendly messages with retry options.
-   **Image Caching**: Basic image caching is handled by OS conventions via `AsyncImage` and `URLCache`.
