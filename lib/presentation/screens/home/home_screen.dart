import 'package:drift_db_viewer/drift_db_viewer.dart';
import 'package:encrypted_notes/data/database/database.dart';
import 'package:encrypted_notes/domain/models/notes/notes.dart';
import 'package:encrypted_notes/domain/models/request_status.dart';
import 'package:encrypted_notes/injection.dart';
import 'package:encrypted_notes/presentation/core/widgets/Button.dart';
import 'package:encrypted_notes/presentation/core/widgets/note_view.dart';
import 'package:encrypted_notes/presentation/navigation/screens.dart';
import 'package:encrypted_notes/presentation/screens/home/bloc/home_bloc.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<HomeBloc>()..add(const LoadNotes()),
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
  late HomeBloc bloc;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    bloc = BlocProvider.of<HomeBloc>(context);
  }

  @override
  dispose() {
    bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.push(AppScreens.modifyNote.path);
        },
        child: const Icon(Icons.add),
      ),
      body: Column(
        children: [
          const Center(child: Text("HOME")),
          Button(
            text: "database",
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => DriftDbViewer(
                    AppDatabase.getInstance(),
                  ),
                ),
              );
            },
          ),
          Button(
            text: "logout",
            onPressed: () {
             bloc.add(const Logout());
            },
          ),
          BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              if (state.loadingLocalStatus == RequestStatus.loading) {
                return const CircularProgressIndicator();
              }

              return Expanded(
                child: ListView.builder(
                  itemCount: state.filteredNotes.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        NoteView(
                          message: state.filteredNotes[index].title,
                          updatedAt: state.filteredNotes[index].updatedAt,
                          messageId: state.filteredNotes[index].id,
                        ),
                        CHIL(state.filteredNotes[index].syncedDevices)
                      ],
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

class CHIL extends StatelessWidget {
  final List<SyncedDevice> syncedDevices;
  CHIL(this.syncedDevices);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: syncedDevices.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text("DeviceId: ${syncedDevices[index].deviceId}"),
                Text("isSynced: ${syncedDevices[index].isSynced}"),
              ],
            ),
          );
        },
      ),
    );
  }
}
