import 'package:flutter/material.dart';
import '../services/firestore_service.dart';
import '../models/note_model.dart';

class NotesScreen extends StatelessWidget {
  final FirestoreService firestoreService = FirestoreService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notas Cloud"),
      ),
      body: StreamBuilder<List<Note>>(
        stream: firestoreService.getNotes(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          final notes = snapshot.data!;

          if (notes.isEmpty) {
            return Center(child: Text("No hay notas aún"));
          }

          return ListView.builder(
            itemCount: notes.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(notes[index].title),
                subtitle: Text(notes[index].content),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          firestoreService.addNote(
            Note(
              id: '',
              title: "Nota de prueba",
              content: "Probando conexión con Firebase",
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}