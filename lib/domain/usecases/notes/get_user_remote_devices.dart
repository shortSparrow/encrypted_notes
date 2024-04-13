import 'package:dartz/dartz.dart';
import 'package:drift/drift.dart';
import 'package:encrypted_notes/data/database/database.dart';
import 'package:encrypted_notes/domain/failures/failures.dart';
import 'package:encrypted_notes/domain/models/remote_device/remote_device.dart';
import 'package:encrypted_notes/domain/repositories/synced_client_repository_local.dart';
import 'package:encrypted_notes/domain/repositories/synced_client_repository_remote.dart';
import 'package:encrypted_notes/extensions/encryption_key_extension.dart';

enum GetAllUserDevicesErrorCodes { unexpectedError }

enum UpdateRemoteDevicesLocalErrorCodes { unexpectedError }

typedef GetAllUserDevicesResponse
    = Future<Either<AppError<GetAllUserDevicesErrorCodes>, List<RemoteDevice>>>;

class GetUserRemoteDevicesUseCase {
  GetUserRemoteDevicesUseCase({
    required RemoteDeviceRepositoryRemote remoteDeviceRepositoryRemote,
    required RemoteDeviceRepositoryLocal remoteDeviceRepositoryLocal,
  })  : _remoteDeviceRepositoryRemote = remoteDeviceRepositoryRemote,
        _remoteDeviceRepositoryLocal = remoteDeviceRepositoryLocal;

  final RemoteDeviceRepositoryRemote _remoteDeviceRepositoryRemote;
  final RemoteDeviceRepositoryLocal _remoteDeviceRepositoryLocal;

  GetAllUserDevicesResponse getAllUserDevices() async {
    try {
      final devices = await _remoteDeviceRepositoryLocal.getAllRemoteDevices();
      return right(devices);
    } catch (e) {
      return left(
        AppError(
          code: GetAllUserDevicesErrorCodes.unexpectedError,
          message: "Can't get remote devices",
        ),
      );
    }
  }

  updateRemoteDevicesLocalData() async {
    try {
      final devices = await _remoteDeviceRepositoryRemote.getAllRemoteDevices();
      for (var newDeviceInfo in devices) {
        if (newDeviceInfo.deleted) {
          _remoteDeviceRepositoryLocal.deleteRemoteDevice(newDeviceInfo.id);
        } else {
          await _remoteDeviceRepositoryLocal.updateRemoteDevice(
            RemoteDevicesCompanion(
              id: Value(newDeviceInfo.id),
              userId: Value(newDeviceInfo.userId),
              deviceName: Value(newDeviceInfo.deviceName),
              systemVersion: Value(newDeviceInfo.systemVersion),
              devicePublicKey: Value(
                newDeviceInfo.devicePublicKey.toJsonString(),
              ),
            ),
          );
        }
      }
    } catch (e) {
      AppError(
        code: UpdateRemoteDevicesLocalErrorCodes.unexpectedError,
        message: e.toString(),
      );
    }
  }
}
