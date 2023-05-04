import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scoreboard/models/models.dart';
import 'package:scoreboard/scores/main_provider.dart';
import 'package:scoreboard/services/firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'firebase_options.dart';
import 'services/config.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    themeNotifier.addListener(() {
      setState(() {});
    });

    loadThemePref();
  }

  void loadThemePref() async {
    final prefs = await SharedPreferences.getInstance();
    final theme = prefs.getBool('theme') ?? false;
    themeNotifier.setTheme(theme);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (_, snapshot) {
        return MaterialApp(
          title: 'Fachschaftsolympiade',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorSchemeSeed: const Color.fromARGB(255, 37, 89, 150),
            useMaterial3: true,
            brightness: themeNotifier.currentTheme(),
          ),
          home: MultiProvider(
            providers: [
              StreamProvider<List<Faculty>>(
                create: (_) => FirestoreService().getFacultiesAsStream(),
                initialData: [Faculty()],
                catchError: (_, __) => [Faculty()],
              ),
              StreamProvider<List<Team>>(
                create: (_) => FirestoreService().getTeamsAsStream(),
                initialData: [Team()],
                catchError: (_, __) => [Team()],
              ),
            ],
            child: const MainProvider(),
          ),
        );
      },
    );
  }
}
