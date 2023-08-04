import 'package:drift/drift.dart' as drift;
import 'package:encrypted_notes/data/database/database.dart';
import 'package:encrypted_notes/domain/repositories/modify_note_repository.dart';
import 'package:encrypted_notes/injection.dart';
import 'package:encrypted_notes/presentation/core/widgets/Button.dart';

import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ModifyNoteRepository modifyNoteRepository = sl();
  @override
  void initState() {
    super.initState();
    getNotes();
  }

  @override
  dispose() {
    super.dispose();
  }

  getNotes() async {
    modifyNoteRepository.getNotes().listen((event) {
      print("list");
      print(event);
    });
  }

  Future<void> addNewNote() async {
    print("ddd");
    modifyNoteRepository.addNote(
      NotesCompanion(
        message: drift.Value("hi"),
        createdAt: drift.Value("created_at: 1"),
        updatedAt: drift.Value("created_at: 2"),
      ),
    );
  }

  Future editNote() async {
   final isSuccess = modifyNoteRepository.editNote(
      NotesCompanion(
          message: drift.Value("hi"),
          updatedAt: drift.Value("updatedAt: 4"),
          id: drift.Value(1)),
    );
    print("edit note: ${isSuccess}");
  }

  Future deleteNote() async {
    final isSuccess = modifyNoteRepository.deleteNote(3);
    print("delete note: ${isSuccess}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Center(child: Text("HOME")),
          Button(text: "add", onPressed: addNewNote),
          Button(text: "edit", onPressed: editNote),
          Button(text: "delete", onPressed: deleteNote),
        ],
      ),
    );
  }
}
