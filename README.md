# FinFlutter Insights

**FinFlutter Insights** is a Flutter application that displays key e-commerce order metrics and a graphical representation of orders over time. Built with a clean architecture, it leverages local JSON data for insights, making the experience fast and reliable without any network calls.

## Features

- **Metrics Screen:**  
  - View total number of orders  
  - Average price of orders  
  - Count of returned orders

- **Graph Screen:**  
  - Visualize orders over time (Weeks, Months, and Quarters)  
  - Dynamic tabs to switch between different time groupings  
  - Identify periods with zero orders, offering a complete timeline view

- **Responsive & Cross-Platform:**  
  - Runs on iOS, Android, and Web

- **Clean Architecture:**  
  - Designed with scalability and maintainability in mind  
  - Clear separation of concerns

- **State Management with Cubit:**  
  - Efficient and predictable state management using `flutter_bloc` and Cubits

- **Dependency Injection:**  
  - Managed via `get_it` for loose coupling and easy testing

- **Functional Error Handling:**  
  - Utilizes `dartz` for robust, functional error handling patterns

- **Modern UI/UX:**  
  - Inspired by leading FinTech designs to ensure a polished and intuitive user experience

## Packages Used

- **flutter_bloc:** For state management using Cubits and the BLoC pattern.  
- **equatable:** Simplifies equality comparisons, crucial for clean BLoC states.  
- **get_it:** Simple and effective service locator for dependency injection.  
- **dartz:** Functional programming concepts in Dart, used for safer error handling.  
- **flutter_screenutil:** Responsive layout for different screen sizes and platforms.  
- **json_annotation & json_serializable:** To easily parse and generate model classes from JSON.  
- **flutter_svg:** To render SVG assets.  
- **fl_chart:** To create dynamic and interactive charts for data visualization.  
- **intl:** Internationalization and date formatting.

## Getting Started

### Prerequisites

- [Flutter SDK](https://flutter.dev/docs/get-started/install)  
- [Dart SDK](https://dart.dev/get-dart)  
- An IDE with Flutter support (e.g. VS Code, Android Studio)  
- Ensure you have a device/emulator/simulator set up (Android/iOS) or a modern browser for web.

## Preview (Screen Recording)

*Here you can add a link or embed a screen recording showing the app running on iOS, Android, and Web. Demonstrate navigating between the Metrics and Graph screens, changing tabs on the Graph screen, and highlighting the user-friendly design.*

## How to Use

This section provides detailed instructions on how to run and use the FinFlutter Insights app effectively.

1. **Open the App:** Start the application on your device or emulator.
2. **Navigate the Screens:** Use the bottom navigation bar or swipe to move between the Metrics and Graph screens.
3. **Interact with Data:** Tap on different tabs in the Graph screen to switch between Weeks, Months, and Quarters views.
4. **View Metrics:** Check the Metrics screen for a summary of total orders, average price, and number of returns.

## Support and Contributions

If you encounter any issues or have suggestions for improvements, please file an issue on the GitHub repository. Contributions to the project are welcome! Please feel free to fork the repository and submit pull requests.

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details.

## Acknowledgments

- Thank you to all the developers and contributors of the Flutter ecosystem.
- Special thanks to the open-source projects that made this app possible.