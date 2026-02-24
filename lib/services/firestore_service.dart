import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/note_model.dart';

class FirestoreService {
  final CollectionReference notes =
      FirebaseFirestore.instance.collection('notes');

  Stream<List<Note>> getNotes() {
    return notes.snapshots().map((snapshot) =>
        snapshot.docs.map((doc) =>
            Note.fromMap(doc.data() as Map<String, dynamic>, doc.id)).toList());
  }

  Future<void> addNote(Note note) {
    return notes.add(note.toMap());
  }
}