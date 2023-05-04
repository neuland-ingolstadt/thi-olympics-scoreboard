import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:scoreboard/models/models.dart';
import 'package:scoreboard/services/auth.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Stream<List<Faculty>> getFacultiesAsStream() {
    var ref = _db.collection('faculties').orderBy('name');
    return ref.snapshots().map((snapshot) => snapshot.docs
        .map((doc) => Faculty.fromJson(doc.id, doc.data()))
        .toList());
  }

  Stream<List<Team>> getTeamsAsStream() {
    var ref = _db.collection('teams');
    return ref.snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => Team.fromJson(doc.id, doc.data())).toList());
  }

  void createTeam(String facultyId, String teamName) async {
    var ref = _db.collection('faculties').doc(facultyId).collection('teams');
    ref.add(Team(name: teamName).toJson());
  }

  void deleteTeam(String facultyId, String teamId) async {
    var ref = _db
        .collection('faculties')
        .doc(facultyId)
        .collection('teams')
        .doc(teamId);
    ref.delete();
  }

  Future<void> updateTeamScore(Team team, Faculty faculty, int score) async {
    var ref = _db.collection('teams').doc(team.id);

    var scores = Map.of(team.scores);
    scores[faculty.id] = score;

    await ref.set({
      'scores': scores,
    }, SetOptions(merge: true));
  }

  Future<Faculty> getFacultyFromUser() async {
    var authUser = AuthService().user;

    var userRef = _db.collection('users').doc(authUser!.uid);
    var userSnapshot = await userRef.get();

    if (!userSnapshot.exists) {
      return Faculty(id: 'Error', name: 'Keine Fakultät');
    }

    var user = User.fromJson(userSnapshot.data()!);

    var facultyRef = _db.collection('faculties').doc(user.faculty);
    var facultySnapshot = await facultyRef.get();

    if (!facultySnapshot.exists) {
      return Faculty(id: 'Error', name: 'Keine Fakultät');
    }

    var faculty = Faculty.fromJson(facultySnapshot.id, facultySnapshot.data()!);

    return faculty;
  }
}
