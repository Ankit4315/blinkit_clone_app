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
3. Implement functionality to filter products
4. Add animations for page transitions
5. Make product data come from a mock API
6. Improve responsiveness across different screen sizes

   - [4](https://github.com/user-attachments/assets/d5ce6881-2025-494d-9702-2ae1afbff323)
![1](https://github.com/user-attachments/assets/4986d90b-3812-456c-b499-aa5cff0c8af3)
![2](https://github.com/user-attachments/assets/ad519a37-3388-436e-98d9-7720a3616aa1)
![3](https://github.com/user-attachments/assets/2008cbe4-4ee2-4969-bcbf-d9f1f2cd0d63)

