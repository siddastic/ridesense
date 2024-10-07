# Ridesense

<img src="https://github.com/user-attachments/assets/bd88d643-1ef4-467c-9c54-048a0f466996" alt="Image 1" width="200"/>

<img src="https://github.com/user-attachments/assets/2d965beb-6474-4fe6-ae1b-34bd97645d81" alt="Image 2" width="200"/>

<img src="https://github.com/user-attachments/assets/b4849142-d1ef-4431-aced-77504eb0e688" alt="Image 3" width="200"/>

<img src="https://github.com/user-attachments/assets/dc370b10-d3c3-4762-b9a1-329a76ea561c" alt="Image 4" width="200"/>

## Overview
This is a simple Flutter app that allows users to input a location (city name, address, or coordinates) and displays it on a Google Map. The app also includes functionality to fetch the user's current location, showing it on the map, and storing recent searches using shared preferences.

## Features
- **Location Input Screen**: Users can enter a location and validate the input.
- **Map Display**: Displays the entered location on a Google Map with a marker.
- **Current Location**: A floating action button fetches the user's current location and displays it as a blue dot on the map.
- **Map Type Selection**: Users can switch between Normal, Hybrid, and Satellite map types.
- **Recent Searches**: Stores the last five search queries and displays them as recent searches.
- **Clear Recent Searches**: Option to clear the recent searches.

## Technologies Used
- Flutter
- Google Maps API
- Geolocation Services
- Shared Preferences
- Dart

## Setup Instructions

### Prerequisites
- Flutter SDK installed on your machine.
- An active Google Maps API key.

### Steps to Run the App

1. **Clone the repository**:
   ```bash
   git clone <repository_url>
   cd ridesense
    ```

2. **Install the dependencies**:
   ```bash
   flutter pub get
   ```

3. **Add your Google Maps API key**:

- Open the `android/app/src/main/AndroidManifest.xml` file.
- Add your Google Maps API key in the `meta-data` tag:
    ```xml
    <meta-data
        android:name="com.google.android.geo.API_KEY"
        android:value="YOUR_API_KEY"/>
    ```

- Create a .env file in the root of the project and add your Google Maps API key:

    ```bash
    GOOGLE_API_KEY=YOUR_API_KEY
    ```

4. **Run the app**:
    ```bash
    flutter run
    ```
