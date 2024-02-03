import 'package:encrypted_notes/injection.dart';
import 'package:encrypted_notes/presentation/core/widgets/Button.dart';
import 'package:encrypted_notes/presentation/screens/modify_note/bloc/modify_note_bloc.dart';
import 'package:encrypted_notes/presentation/screens/modify_note/widgets/synced_device_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum ModifyNoteMode { add, edit }

class ModifyNoteScreen extends StatelessWidget {
  final ModifyNoteMode mode;
  final int? noteId;

  const ModifyNoteScreen({super.key, required this.mode, this.noteId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          sl<ModifyNoteBloc>()..add(SetParams(mode: mode, noteId: noteId)),
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
  final titleEditorController = TextEditingController();


  Future<void> _dialogBuilder(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: SizedBox(
            width: double.maxFinite,
            height: 400,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Expanded(child: SyncedDeviceList()),
                const SizedBox(height: 20),
                Button(
                  onPressed: () {},
                  text: "Save",
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<ModifyNoteBloc>().state;
    final editableNoteMessage = state.editableNote?.message ?? '';

    final title = state.editableNote?.title ?? '';
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: titleEditorController..text = title,
          decoration: InputDecoration(
            border: InputBorder.none,
            label: null,
            contentPadding: EdgeInsets.zero,
            hintText: state.mode == ModifyNoteMode.add ? "new note" : null,
          ),
          style: const TextStyle(fontSize: 20, height: 1),
        ),
        actions: [
          IconButton(
              onPressed: () {
                _dialogBuilder(context);
              },
              icon: const Icon(Icons.add_task_sharp)),
        ],
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: TextFormField(
                controller: messageEditorController..text = editableNoteMessage,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                ),
                maxLines: null,
              ),
            ),
            Button(
              onPressed: () => context.read<ModifyNoteBloc>().add(
                    SaveNote(
                        message: messageEditorController.text,
                        title: titleEditorController.text),
                  ),
              text: "Save",
            )
          ],
        ),
      )

          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: Stack(
          //     children: [
          //       TextFormField(
          //         controller: messageEditorController,
          //         decoration: const InputDecoration(
          //           border: UnderlineInputBorder(),
          //           labelText: 'message',
          //         ),
          //       ),
          //       Positioned.directional(
          //         end: 0,
          //         top: 15,
          //         textDirection: TextDirection.ltr,
          //         child: IconButton(
          //           onPressed: () {
          //             context.read<ModifyNoteBloc>().add(
          //                 AddNewNote(message: messageEditorController.text));
          //           },
          //           icon: const Icon(Icons.send),
          //         ),
          //       )
          //     ],
          //   ),
          // ),

          ),
    );
  }
}
