import 'package:encrypted_notes/injection.dart';
import 'package:encrypted_notes/presentation/screens/modify_note/bloc/modify_note_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ModifyNoteScreen extends StatelessWidget {
  const ModifyNoteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<ModifyNoteBloc>(),
      child: const ModifyNoteView(),
    );
  }
}

class ModifyNoteView extends StatefulWidget {
  const ModifyNoteView({super.key});

  @override
  State<ModifyNoteView> createState() => _ModifyNoteViewState();
}

class _ModifyNoteViewState extends State<ModifyNoteView> {
  final messageEditorController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Stack(
              children: [
                TextFormField(
                  controller: messageEditorController,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'message',
                  ),
                ),
                Positioned.directional(
                  end: 0,
                  top: 15,
                  textDirection: TextDirection.ltr,
                  child: IconButton(
                    onPressed: () {
                      context.read<ModifyNoteBloc>().add(AddNewNote(message: messageEditorController.text));
                    },
                    icon: const Icon(Icons.send),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
