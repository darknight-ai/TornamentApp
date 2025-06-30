import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';

class DatabaseService {
  final CollectionReference gamescollection =
      FirebaseFirestore.instance.collection("Games");
  final DatabaseReference databaseRef = FirebaseDatabase.instance.ref();
//adding games
  Future addgames(String eventname, String eventbannerimg) async {
    var date = DateTime.now().microsecondsSinceEpoch.toString();
    await gamescollection.doc(eventname).set({
      'GameImg': eventbannerimg,
      'GameName': eventname,
      // 'Time': time,
      // 'HostName': hostname,
      // 'EventDate': eventdate,
      // 'id': date,
    });
  }

  //getting games
  Stream<QuerySnapshot> getGamesStream() {
    return gamescollection.snapshots();
  }

  Stream<DatabaseEvent> getNodeStream(String nodeName) {
    return databaseRef.child(nodeName).onValue;
  }
}
