import 'dart:convert';

import 'package:cryptography/cryptography.dart';
import 'package:dio/dio.dart';
import 'package:encrypted_notes/data/remote/apiClient.dart';
import 'package:encrypted_notes/domain/failures/failures.dart';
import 'package:encrypted_notes/domain/models/remote_device/remote_device.dart';
import 'package:encrypted_notes/domain/repositories/synced_client_repository_remote.dart';
import 'package:jwk/jwk.dart';

class RemoteDeviceRepositoryImpl extends RemoteDeviceRepositoryRemote {
  @override
  Future<List<RemoteDevice>> getAllRemoteDevices() async {
    try {
      final response = await apiClient.get('/get-all-user-devices');

      var data = response.data['message'] as List;

      return data
          .map(
            (item) => RemoteDevice(
              deviceName: item["name"],
              id: item["deviceId"],
              systemVersion: null,
              devicePublicKey:
                  Jwk.fromJson(jsonDecode(item["noteEncryptionPublicKey"]))
                      .toPublicKey() as SimplePublicKey,
              userId: item["userId"],
              deleted: false, // TODO return from server
            ),
          )
          .toList();
    } on DioException catch (e) {
      throw NetworkFailure(
        statusCode: e.response?.statusCode,
        message: e.response?.data,
      );
    } catch (e) {
      throw UnexpectedFailure();
    }
  }

  @override
  Future<RemoteDevice?> getRemoteDeviceById(String id) {
    // TODO: implement getRemoteDeviceById
    throw UnimplementedError();
  }

  @override
  Future registerRemoteDevices(RemoteDevice remoteDevice) {
    // TODO: implement registerRemoteDevices
    throw UnimplementedError();
  }
}
