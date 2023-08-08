import 'package:encrypted_notes/domain/models/request_status.dart';
import 'package:encrypted_notes/injection.dart';
import 'package:encrypted_notes/presentation/core/widgets/Button.dart';
import 'package:encrypted_notes/presentation/core/widgets/note_view.dart';
import 'package:encrypted_notes/presentation/screens/home/bloc/note_bloc.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<NoteBloc>()..add(const LoadNotes()),
      child: HomeView(),
    );
  }
}

class HomeView extends StatefulWidget {
  HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late NoteBloc bloc;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    bloc = BlocProvider.of<NoteBloc>(context);
  }

  @override
  dispose() {
    bloc.dispose();
    super.dispose();
  }

  getNotes() async {
    // modifyNoteRepository.getNotes().listen((event) {
    //   print("list");
    //   print(event);
    // });
  }

  Future<void> addNewNote(BuildContext context) async {
    context.read<NoteBloc>().add(NavigateToAddNote());
    // modifyNoteRepository.addNote(
    //   NotesCompanion(
    //     message: drift.Value("hi"),
    //     createdAt: drift.Value("created_at: 1"),
    //     updatedAt: drift.Value("created_at: 2"),
    //   ),
    // );
  }

  Future editNote() async {
    // final isSuccess = modifyNoteRepository.editNote(
    //   NotesCompanion(
    //       message: drift.Value("hi"),
    //       updatedAt: drift.Value("updatedAt: 4"),
    //       id: drift.Value(1)),
    // );
    // print("edit note: ${isSuccess}");
  }

  Future deleteNote() async {
    // final isSuccess = modifyNoteRepository.deleteNote(3);
    // print("delete note: ${isSuccess}");
  }

  @override
  Widget build(BuildContext context) {
    // final state = context.watch<NoteBloc>().state;
    // print("state: ${state}");

    return Scaffold(
      appBar: null,
      body: Column(
        children: [
          const Center(child: Text("HOME")),
          Button(text: "add", onPressed: () => addNewNote(context)),
          Button(text: "edit", onPressed: editNote),
          Button(text: "delete", onPressed: deleteNote),
          BlocBuilder<NoteBloc, NoteState>(
            builder: (context, state) {
              if (state.loadingLocalStatus == RequestStatus.loading) {
                return CircularProgressIndicator();
              }

              return Expanded(
                child: ListView.builder(
                  itemCount: state.filteredNotes.length,
                  itemBuilder: (context, index) {
                    return NoteView(
                      message: state.filteredNotes[index].message,
                      updatedAt: state.filteredNotes[index].updatedAt,
                    );
                  },
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
