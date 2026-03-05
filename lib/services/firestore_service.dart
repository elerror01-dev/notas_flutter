import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/note_model.dart';

class FirestoreService {

  // Obtener el UID del usuario actual
  String get userId => FirebaseAuth.instance.currentUser!.uid;

  // Ruta privada: users/{uid}/notes
  CollectionReference get notes => FirebaseFirestore.instance
      .collection('users')
      .doc(userId)
      .collection('notes');

  // Obtener notas del usuario actual
  Stream<List<Note>> getNotes() {
    return notes.snapshots().map(
      (snapshot) => snapshot.docs.map(
        (doc) {
          final data = doc.data() as Map<String, dynamic>;
          return Note.fromMap(data, doc.id);
        },
      ).toList(),
    );
  }

  // Agregar nota al usuario actual
  Future<void> addNote(Note note) async {
    await notes.add(note.toMap());
  }
}