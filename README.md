# Blinkit Clone - Flutter UI

A Flutter UI clone of the Blinkit grocery app home screen.

## Screenshots

[Screenshots will be placed here]

## Features

- Top App Bar with location, profile, and search bar
- Horizontal scrollable categories
- Offer banners carousel
- Featured sections for special categories
- Product grids with items (name, image, price, add button)
- Bottom Navigation Bar
- Animations for search bar and bottom navigation when scrolling

## Project Structure

The project follows the recommended structure:

```
/lib
  /screens
    home_screen.dart
  /widgets
    custom_app_bar.dart
    product_layout.dart
  /models
    product_categories.dart
  /assets
    [images, etc]
  main.dart
```

## How to Run

1. Clone this repository
2. Ensure Flutter is installed on your machine
3. Run `flutter pub get` to install dependencies
4. Run `flutter run` to start the application

## Dependencies

- flutter: ^3.x
- geolocator: for location services
- permission_handler: for handling permissions
- geocoding: for reverse geocoding

## What I Would Improve With More Time

1. Implement a proper state management solution (Provider/Bloc)
2. Add a dark mode toggle
3. Implement search functionality to filter products
4. Add animations for page transitions
5. Make product data come from a mock API
6. Improve responsiveness across different screen sizes
