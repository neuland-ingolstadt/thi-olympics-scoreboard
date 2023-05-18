import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:scoreboard/models/models.dart';
import 'package:scoreboard/scores/main_provider.dart';
import 'package:scoreboard/services/auth.dart';
import 'package:scoreboard/services/firestore.dart';
import 'package:scoreboard/shared/appbar.dart';

class UserOverview extends StatefulWidget {
  const UserOverview({super.key});

  @override
  State<UserOverview> createState() => _UserOverviewState();
}

class _UserOverviewState extends State<UserOverview> {
  @override
  Widget build(BuildContext context) {
    var user = FirebaseAuth.instance.currentUser!;

    return SafeArea(
      child: Scaffold(
        appBar: getAppBar(context, 'Einstellungen'),
        body: FutureBuilder<Faculty>(
          future: FirestoreService().getFacultyFromUser(),
          builder: (context, snapshot) {
            var faculty = snapshot.data;

            if (snapshot.hasData) {
              return Center(
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(25),
                    ),
                    CircleAvatar(
                      radius: 75,
                      backgroundColor:
                          Theme.of(context).colorScheme.surfaceVariant,
                      child: const Icon(
                        Icons.person,
                        size: 60,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(10),
                    ),
                    Text(
                      user.email!,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(faculty?.name ?? 'Keine Fakultät'),
                    const Padding(
                      padding: EdgeInsets.all(20),
                    ),
                    ElevatedButton.icon(
                      onPressed: () {
                        AuthService().logoutUser();
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const MainProvider()),
                          (Route<dynamic> route) => false,
                        );
                      },
                      icon: const Icon(Icons.logout),
                      label: const Text('Logout'),
                    ),
                  ],
                ),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return const Center(
                child: Text('Error'),
              );
            }
          },
        ),
      ),
    );
  }
}
