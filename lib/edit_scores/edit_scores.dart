import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:scoreboard/services/firestore.dart';
import 'package:scoreboard/shared/appbar.dart';
import 'package:scoreboard/shared/list_title.dart';

import '../models/models.dart';

class EditScores extends StatefulWidget {
  final Faculty faculty;
  const EditScores({required this.faculty, Key? key}) : super(key: key);

  @override
  State<EditScores> createState() => _EditScoresState();
}

class _EditScoresState extends State<EditScores> {
  void updateScore(
      BuildContext context, Team team, String text, Faculty faculty) {
    var score = int.tryParse(text) ?? 0;

    FirestoreService().updateTeamScore(team, faculty, score);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    var teams = Provider.of<List<Team>>(context);
    var faculties = Provider.of<List<Faculty>>(context);

    if (widget.faculty.id == 'Error') {
      return Scaffold(
        appBar: getAppBar(context, 'Einstellungen', false),
        body: const Center(
          child: Text('Du bist kein Mitglied einer Fakultät!'),
        ),
      );
    }

    teams.sort((a, b) => a.name.compareTo(b.name));

    var facultyRef =
        faculties.where((element) => element.id == widget.faculty.id);
    var faculty = facultyRef.isNotEmpty ? facultyRef.first : Faculty();

    return Scaffold(
      appBar: getAppBar(context, faculty.name, false),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(8),
            ),
            const Text('Tippe auf ein Team um den Score zu ändern.'),
            const Padding(
              padding: EdgeInsets.all(8),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: teams.length,
                itemBuilder: (context, index) {
                  var team = teams[index];
                  var score = team.scores[faculty.id] ?? 0;

                  var teamFacultyRef =
                      faculties.where((element) => element.id == team.faculty);

                  var teamFaculty = teamFacultyRef.isNotEmpty
                      ? teamFacultyRef.first
                      : Faculty();

                  return Card(
                    child: ListTile(
                      title: ListTitle(
                        title: team.name,
                        faculty: teamFaculty,
                      ),
                      trailing: Text(score.toString()),
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            var controller = TextEditingController()
                              ..text = score.toString();

                            return AlertDialog(
                              title: const Text('Score bearbeiten'),
                              content: TextFormField(
                                autovalidateMode: AutovalidateMode.always,
                                autofocus: true,
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'[0-9]')),
                                ],
                                keyboardType: TextInputType.number,
                                controller: controller,
                                onFieldSubmitted: (value) =>
                                    updateScore(context, team, value, faculty),
                              ),
                              actions: [
                                TextButton(
                                  child: const Text('Abbrechen'),
                                  onPressed: () => Navigator.of(context).pop(),
                                ),
                                ElevatedButton.icon(
                                  icon: const Icon(Icons.save),
                                  label: const Text('Speichern'),
                                  onPressed: () => updateScore(
                                      context, team, controller.text, faculty),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      tileColor: Theme.of(context).colorScheme.surfaceVariant,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
