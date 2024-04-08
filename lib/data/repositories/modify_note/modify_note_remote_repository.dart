import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:encrypted_notes/data/mapper/notes_mapper.dart';
import 'package:encrypted_notes/data/remote/apiClient.dart';
import 'package:encrypted_notes/domain/models/notes/modify_notes.dart';
import 'package:encrypted_notes/domain/failures/failures.dart';
import 'package:encrypted_notes/domain/models/notes/notes.dart';
import 'package:encrypted_notes/domain/repositories/modify_note_remote_repository.dart';

class ModifyNoteRemoteRepositoryImpl extends ModifyNoteRemoteRepository {
  final NotesMapper notesMapper = NotesMapper();

  ModifyNoteRemoteRepositoryImpl();

  @override
  Future<List<DeleteNotesResponse>> deleteNotes(
      List<String> globalNoteIds) async {
    try {
      final response = await apiClient.delete<List<dynamic>>(
        '/delete-notes',
        data: jsonEncode(globalNoteIds),
      );

      return response.data
              ?.map(
                (e) => DeleteNotesResponse(
                    globalNoteId: e['noteGlobalId'],
                    isDeleteSuccess: e['isSuccess']),
              )
              .toList() ??
          List.empty();
    } on DioException catch (e) {
      print("deleteNote error ${e}");
      throw NetworkFailure(
        statusCode: e.response?.statusCode,
        message: e.response?.data,
      );
    } catch (e) {
      throw UnexpectedFailure();
    }
  }

  @override
  Future<List<GetRemovingNotesResponse>> getRemovingNotes() async {
    try {
      final response =
          await apiClient.get<List<dynamic>>('/get-all-removing-notes');

      return response.data?.map((e) {
            return GetRemovingNotesResponse(
                noteGlobalId: e['noteGlobalId'],
                sendToDeviceId: e['sendToDeviceId']);
          }).toList() ??
          List.empty();
    } on DioException catch (e) {
      print("addNote DioException ${e}");
      throw NetworkFailure(
        statusCode: e.response?.statusCode,
        message: e.response?.data,
      );
    } catch (e) {
      print("getNotes unexpected Error");
      throw UnexpectedFailure();
    }
  }

  @override
  Future<void> confirmRemovingNoteFromDevice(List<String> globalNoteIds) async {
    try {
      await apiClient.post<List<dynamic>>('/confirm-removing-notes',
          data: jsonEncode(globalNoteIds));
    } on DioException catch (e) {
      print("addNote DioException ${e}");
      throw NetworkFailure(
        statusCode: e.response?.statusCode,
        message: e.response?.data,
      );
    } catch (e) {
      print("getNotes unexpected Error");
      throw UnexpectedFailure();
    }
  }

  @override
  Future<List<GetAllNotesResponse>> getNotes() async {
    try {
      final response = await apiClient.get<List<dynamic>>('/get-all-notes');

      final allNotes = response.data?.map((note) {
        List<dynamic> syncedWithDevices = note['metaData']['syncedWithDevices'];
        List<String> syncedWithDevicesId =
            syncedWithDevices.map((item) => item.toString()).toList();

        return GetAllNotesResponse(
          title: EncryptedMessage.fromJson(note['data']['title']),
          message: EncryptedMessage.fromJson(note['data']['message']),
          createdAt: note['metaData']['createdAt'],
          updatedAt: note['metaData']['updatedAt'],
          noteGlobalId: note['metaData']['noteGlobalId'],
          sendFromDeviceId: note['metaData']['sendFromDeviceId'],
          syncedWithDevicesId: syncedWithDevicesId,
        );
      }).toList();

      if (allNotes == null) {
        throw UnexpectedFailure();
      }

      return allNotes;
    } on DioException catch (e) {
      print("addNote DioException ${e}");
      throw NetworkFailure(
        statusCode: e.response?.statusCode,
        message: e.response?.data,
      );
    } catch (e) {
      print("getNotes unexpected Error");
      throw UnexpectedFailure();
    }
  }

  @override
  Future<AddNotesResponse> addNote(List<NoteDataForServer> data) async {
    try {
      final response = await apiClient.post<Map<String, dynamic>>(
        '/add-notes',
        data: jsonEncode(data),
      );

      final noteGlobalId = response.data?['noteGlobalId'];
      final parsedResponse = response.data?['notes']?.map((e) => NoteResponse(
            deviceId: e["sendToDeviceId"],
            isSuccess: e["isSuccess"],
            noteGlobalId: noteGlobalId,
          ));

      return AddNotesResponse(
        noteGlobalId: noteGlobalId,
        notes: List<NoteResponse>.from(parsedResponse),
      );
    } on DioException catch (e) {
      print("addNote error ${e}");
      throw NetworkFailure(
        statusCode: e.response?.statusCode,
        message: e.response?.data,
      );
    } catch (e) {
      throw UnexpectedFailure();
    }
  }

  @override
  Future<EditNotesResponse> editNote(List<NoteDataForServer> data) async {
    try {
      final response = await apiClient.put<Map<String, dynamic>>(
        '/edit-notes',
        data: jsonEncode(data),
      );

      final noteGlobalId = response.data?['noteGlobalId'];
      final parsedResponse = response.data?['notes']?.map((e) => NoteResponse(
            deviceId: e["sendToDeviceId"],
            isSuccess: e["isSuccess"],
            noteGlobalId: noteGlobalId,
          ));

      return EditNotesResponse(
        noteGlobalId: noteGlobalId,
        notes: List<NoteResponse>.from(parsedResponse),
      );
    } on DioException catch (e) {
      print("editNote error ${e}");
      throw NetworkFailure(
        statusCode: e.response?.statusCode,
        message: e.response?.data,
      );
    } catch (e) {
      throw UnexpectedFailure();
    }
  }
}
