import 'package:flutter/material.dart';

enum NoteSyncingStatus { inProgress, synced, failed }

class NoteView extends StatelessWidget {
  final String message;
  final String updatedAt;
  final NoteSyncingStatus syncingStatus = NoteSyncingStatus.inProgress;
  const NoteView({super.key, required this.message, required this.updatedAt});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const CircleAvatar(
                    child: Icon(Icons.headset_mic_sharp),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    message,
                    style: theme.textTheme.bodyLarge,
                  ),
                ],
              ),
              SizedBox(
                width: 150,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Text("synced: "),
                        const SizedBox(width: 5),
                        Text(syncingStatus.name)
                      ],
                    ),
                    Row(
                      children: [
                        const Text("last updated"),
                        const SizedBox(width: 5),
                        Flexible(child: Text(updatedAt, maxLines: 1,))
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Divider()
      ],
    );
  }
}
