# TP2 - Flutter Image Puzzle Game

## Description
This Flutter project is a collection of interactive exercises focused on image manipulation, transformations, and an image-based sliding puzzle game (Jeu de Taquin). The application consists of multiple exercises showcasing various Flutter features such as animations, image processing, grid layouts, and game logic implementation.

## Features
- **Exercise 1:** Display a random image from the internet.
- **Exercise 2a:** Rotate and scale an image.
- **Exercise 2b:** Animated rotation and scaling of an image.
- **Exercise 4:** Display a single tile from an image.
- **Exercise 5a:** Grid of randomly colored tiles.
- **Exercise 5b:** Fixed grid of cropped images.
- **Exercise 5c:** Configurable Taquin board.
- **Exercise 6a:** Moving tiles animation.
- **Exercise 6b:** Moving tiles within a grid.
- **Exercise 7:** Implementation of the classic Taquin sliding puzzle game.
- **Final Project:** Complete playable Taquin Game with adjustable difficulty and image selection.

## Installation
- Install Flutter: [Flutter Installation Guide](https://flutter.dev/docs/get-started/install)
To run this project on your local machine:

1. Clone the repository:
 
   git clone https://github.com/Shiyun22/AMSE/tree/main/tp2
   cd tp2
   
2. Install dependencies:
   
   flutter pub get
  
3. Run the app:

   flutter run


## Usage
- Navigate through different exercises via the main menu.
- Explore image transformations and animations.
- Configure the Taquin puzzle by selecting an image, adjusting grid size, and setting difficulty.
- Play the Taquin game by sliding tiles to arrange them in the correct order.

## Project Structure
```
lib/
│-- main.dart             # Entry point of the application
│-- menu_page.dart        # Main menu UI
│-- exercise_1.dart       # Display an image
│-- exercise_2a.dart      # Rotate & Scale image
│-- exercise_2b.dart      # Animated transformations
│-- exercise_4.dart       # Display a tile
│-- exercise_5a.dart      # Grid of colored boxes
│-- exercise_5b.dart      # Cropped image grid
│-- exercise_5c.dart      # Configurable Taquin board
│-- exercise_6a.dart      # Moving tiles
│-- exercise_6b.dart      # Moving tiles in a grid
│-- taquin_game.dart      # Full Taquin game implementation
```

## Dependencies
- `flutter/material.dart`: UI framework
- `dart:math`: Random number generation for shuffling tiles
- `dart:async`: Timers for animations
- `image_picker`: Select images from device storage
- `dart:io`: File handling for image selection

## Future Improvements
- Add more difficulty levels and hints for Taquin game.
- Implement a score tracking system.
- Enhance animations and user experience.

## Contributors
- Developer: **[Shiyun GU _ Tianyi ZHANG]**

## License
This project is open-source and available under the MIT License.

