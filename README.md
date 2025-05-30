# TwinVibes

A mood-tracking app for teens to express their emotions and track mood patterns over time.

## Features

- **Welcome Screen**: Introduction to the app with options to join or sign in
- **Sign Up**: Create an account with email, birthday, and timezone
- **Mood Entry**: Record your mood on a scale from 0 to 10, select an emoji, and write a journal entry
- **Home Screen**: View your mood patterns with an interactive map visualization
- **Settings**: Manage your profile information and app preferences

## Implementation Details

TwinVibes is built with Flutter and follows a clean, modular architecture:

- **Screens**: Each screen is implemented as a separate widget class
- **Theme**: Consistent color scheme and styling across the app
- **Map Visualization**: Interactive map that displays user moods with color-coded avatars
- **Form Inputs**: Uses TextField, DropdownButtonFormField, and Slider for user input
- **Navigation**: Modern navigation with floating action button and modal screens

## Features

### Interactive Map
- Zoomable, pannable world map using flutter_map
- Color-coded user avatars (red for low mood, yellow for neutral, green for high mood)
- Tap on avatars to view detailed mood information
- Dynamic forecast that updates every 30 minutes

## Getting Started

1. Ensure Flutter is installed on your system
2. Clone this repository
3. Run `flutter pub get` to install dependencies
4. Run `flutter run` to launch the app

## Structure

```
lib/
├── main.dart
├── screens/
│   ├── welcome_screen.dart
│   ├── sign_up_screen.dart
│   ├── mood_entry_screen.dart
│   ├── home_screen.dart
│   └── settings_screen.dart
├── widgets/
│   └── twin_map_view.dart
├── theme/
│   └── app_theme.dart
└── utils/
    ├── constants.dart
    └── routes.dart
```

## Dependencies

- flutter_map: ^8.1.1
- latlong2: ^0.9.0
- http: ^1.4.0
