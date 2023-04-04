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
- Run `firebase login` to login to your Firebase account.
- Install the [Flutter CLI](https://firebase.flutter.dev/docs/cli/) and activate it according to the documentation.
- Run `flutterfire configure` to create the `firebase_options.json` file. This file is used to connect to the Firebase project.

### Flutter

- Install the [Flutter SDK](https://flutter.dev/docs/get-started/install).
- Check your Flutter installation by running `flutter doctor`.
- Use the `stable` channel by running `flutter channel stable`.
- Run `flutter pub get` to install the dependencies.
- Run `flutter run [-d Chrome]` to start the app.
