import 'package:drift/drift.dart';
import 'package:drift/wasm.dart';
import 'package:encrypted_notes/data/database/open_connection/open_connection.dart';

class OpenConnectionWebImpl implements OpenConnection {
  @override
  DatabaseConnection openConnection() {
    return DatabaseConnection.delayed(Future(() async {
      final result = await WasmDatabase.open(
        databaseName: 'encrypted_notes_db',
        sqlite3Uri: Uri.parse('sqlite3.wasm'),
        driftWorkerUri: Uri.parse('drift_worker.dart.js'),
      );

      if (result.missingFeatures.isNotEmpty) {
        print('Using ${result.chosenImplementation} due to missing browser '
            'features: ${result.missingFeatures}');
      }

      return result.resolvedExecutor;
    }));
  }
}
