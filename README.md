# THI Fachschaftsolympiade

This is a WebApp made for the [Student Council Olympics](https://studverthi.de/fakultaetsolympiade) which is organized annually at the THI by the Student Council.

🌐 https://studverthi.web.app/ 🌐

## Login and scoreboard

Faculties can get access by contacting [Philipp Opheys](mailto:philipp.opheys@neuland-ingolstadt.de). At this point, teams and games get added manually by neuland-ingolstadt.

Each Faculty can give each team as many game points for their own game, resulting in a ranking, used to calculate global points.


## Setup

### Firebase

- Request access to the Firebase project from [Philipp Opheys](mailto:philipp.opheys@neuland-ingolstadt.de).
- Install the [Firebase CLI](https://firebase.google.com/docs/cli).
- Login to your Firebase account.
    ```bash
    firebase login
    ```
- Install the [Flutter CLI](https://firebase.flutter.dev/docs/cli/) and activate it according to the documentation.
- Run the following command to create the `firebase_options.json` file. This file is used to connect to the Firebase project.
    ```bash
    flutterfire configure
    ```

### Flutter

- Install the [Flutter SDK](https://flutter.dev/docs/get-started/install).
- Check your Flutter installation
    ```bash
    flutter doctor
    ```
- Switch to the `stable` channel
    ```bash
    flutter channel stable
    flutter upgrade
    ```
- Install the dependencies
    ```bash
    flutter pub get
    ```	
- Run the app
    ```bash
    flutter run [-d Chrome]
    ```	

## Deployment

- Build the app using CanvasKit in release mode
    ```bash
    flutter build web --web-renderer canvaskit --release
    ```
- Deploy the app to Firebase
    ```bash
    firebase deploy
    ```
