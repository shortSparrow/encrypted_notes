import 'dart:convert';

import 'package:cryptography/cryptography.dart';
import 'package:encrypted_notes/data/mapper/notes_mapper.dart';
import 'package:encrypted_notes/domain/models/notes/notes.dart';
import 'package:encrypted_notes/domain/repositories/secret_shared_preferences_repository.dart';
import 'package:encrypted_notes/domain/usecases/encryption/generate_keys.dart';
import 'package:encrypted_notes/domain/usecases/encryption/message_encryption_use_case.dart';
import 'package:encrypted_notes/domain/usecases/notes/get_synced_device_list.dart';
import 'package:encrypted_notes/injection.dart';
import 'package:encrypted_notes/main.dart';
import 'package:hive/hive.dart';
import 'package:jwk/jwk.dart';

const noteTestBox = 'noteTestBox';

class TestE2E {
  Future init() async {
    await Hive.openBox(noteTestBox);
  }

  Future start() async {
    await init();

    final TestEncryptionUseCase testEncryptionUseCase = sl();
    try {
      await testEncryptionUseCase.registerAlice();
      await testEncryptionUseCase.registerBob();
      await testEncryptionUseCase.bobSendMessageToAlice();
      await testEncryptionUseCase.aliceGetMessage();

      await testEncryptionUseCase.aliceSendMessageToBob();
      await testEncryptionUseCase.bobGetMessage();
    } catch (e) {
      print(e);
    }
  }
}

class TestEncryptionUseCase {
  TestEncryptionUseCase({
    required GetSyncedDeviceListUseCase getSyncedDeviceListUseCase,
    required NotesMapper notesMapper,
    required MessageEncryptionUseCase getE2EKeyPairForNotesUseCase,
    required SecretSharedPreferencesRepository
        secretSharedPreferencesRepository,
    required MessageEncryptionUseCase messageEncryptionUseCase,
  })  : _getSyncedDeviceListUseCase = getSyncedDeviceListUseCase,
        _notesMapper = notesMapper,
        _secretSharedPreferencesRepository = secretSharedPreferencesRepository,
        _messageEncryptionUseCase = messageEncryptionUseCase,
        _getE2EKeyPairForNotesUseCase = getE2EKeyPairForNotesUseCase;

  final GetSyncedDeviceListUseCase _getSyncedDeviceListUseCase;
  final NotesMapper _notesMapper;
  final MessageEncryptionUseCase _getE2EKeyPairForNotesUseCase;
  final SecretSharedPreferencesRepository _secretSharedPreferencesRepository;
  final MessageEncryptionUseCase _messageEncryptionUseCase;

  final box = Hive.box(noteTestBox);

  Future<List<SyncedDevice>> getSyncingDeviceForBob() async {
    final alicePair = await getAliceDeviceKeyPair();
    final alicePublic = await alicePair.extractPublicKey();

    return [
      SyncedDevice(
        deviceId: "device_1",
        isSynced: false,
      )
    ];
  }

  Future<List<SyncedDevice>> getSyncingDeviceForAlice() async {
    final bobPair = await getBobDeviceKeyPair();
    final bobPublic = await bobPair.extractPublicKey();

    return [
      SyncedDevice(
        deviceId: "device_2",
        isSynced: false,
      )
    ];
  }

  Future bobSendMessageToAlice() async {
    final syncedDevices = await getSyncingDeviceForBob();
    final bobPair = await getBobDeviceKeyPair();
    final alicePair = await getAliceDeviceKeyPair();
    final alicePublic = await alicePair.extractPublicKey();

    final note = Note(
      title: 'From bob to Alice',
      message: 'Message from Bob to Alice',
      createdAt: '1',
      updatedAt: '1',
      id: 1,
      globalId: '1',
      syncedDevices: syncedDevices,
    );

    final generateKeys = GenerateKeys();
    final sharedSecret = await generateKeys.algorithmE2E
        .sharedSecretKey(keyPair: bobPair, remotePublicKey: alicePublic);

    final messageSecretBox = await generateKeys.algorithmAES.encrypt(
      utf8.encode(note.message),
      secretKey: sharedSecret,
    );

    final messageCipher = EncryptedMessage(
      cipherText: messageSecretBox.cipherText,
      mac: messageSecretBox.mac.bytes,
      nonce: messageSecretBox.nonce,
    );

    final titleSecretBox = await generateKeys.algorithmAES.encrypt(
      utf8.encode(note.title),
      secretKey: sharedSecret,
    );

    final titleCipher = EncryptedMessage(
      cipherText: titleSecretBox.cipherText,
      mac: titleSecretBox.mac.bytes,
      nonce: titleSecretBox.nonce,
    );

    final gson = jsonEncode(
      NoteDataForServerEncryptedData(
        title: titleCipher,
        message: messageCipher,
      ),
    );
    box.put('alice', gson);
  }

  Future aliceSendMessageToBob() async {
    final syncedDevices = await getSyncingDeviceForAlice();
    final alicePair = await getAliceDeviceKeyPair();
    final bobPair = await getBobDeviceKeyPair();
    final bobPublic = await bobPair.extractPublicKey();

    final note = Note(
      title: 'From Alice to Bob',
      message: 'Message from Alice to Bob',
      createdAt: '1',
      updatedAt: '1',
      id: 1,
      globalId: '1',
      syncedDevices: syncedDevices,
    );
    final generateKeys = GenerateKeys();
    final sharedSecret = await generateKeys.algorithmE2E
        .sharedSecretKey(keyPair: alicePair, remotePublicKey: bobPublic);

    final messageSecretBox = await generateKeys.algorithmAES.encrypt(
      utf8.encode(note.message),
      secretKey: sharedSecret,
    );

    final messageCipher = EncryptedMessage(
      cipherText: messageSecretBox.cipherText,
      mac: messageSecretBox.mac.bytes,
      nonce: messageSecretBox.nonce,
    );

    final titleSecretBox = await generateKeys.algorithmAES.encrypt(
      utf8.encode(note.title),
      secretKey: sharedSecret,
    );

    final titleCipher = EncryptedMessage(
      cipherText: titleSecretBox.cipherText,
      mac: titleSecretBox.mac.bytes,
      nonce: titleSecretBox.nonce,
    );

    final gson = jsonEncode(
      NoteDataForServerEncryptedData(
        title: titleCipher,
        message: messageCipher,
      ),
    );
    box.put('bob', gson);
  }

  Future aliceGetMessage() async {
    final alicePair = await getAliceDeviceKeyPair();
    final bobPair = await getBobDeviceKeyPair();
    final bobPublic = await bobPair.extractPublicKey();

    final message = box.get('alice');
    final NoteDataForServerEncryptedData parsedMessage =
        NoteDataForServerEncryptedData.fromJson(jsonDecode(message));

    final generateKeys = GenerateKeys();
    final sharedSecret = await generateKeys.algorithmE2E
        .sharedSecretKey(keyPair: alicePair, remotePublicKey: bobPublic);

    final decryptedTitle = await generateKeys.algorithmAES.decryptString(
      SecretBox(
        parsedMessage.title.cipherText,
        nonce: parsedMessage.title.nonce,
        mac: Mac(parsedMessage.title.mac),
      ),
      secretKey: sharedSecret,
    );

    final decryptedMessage = await generateKeys.algorithmAES.decryptString(
      SecretBox(
        parsedMessage.message.cipherText,
        nonce: parsedMessage.message.nonce,
        mac: Mac(parsedMessage.message.mac),
      ),
      secretKey: sharedSecret,
    );

    print("decryptedTitle: ${decryptedTitle}");
    print("decryptedMessage: ${decryptedMessage}");
  }

  Future bobGetMessage() async {
    final bobPair = await getBobDeviceKeyPair();
    final alicePair = await getAliceDeviceKeyPair();
    final alicePublic = await bobPair.extractPublicKey();

    final message = box.get('bob');
    final NoteDataForServerEncryptedData parsedMessage =
        NoteDataForServerEncryptedData.fromJson(jsonDecode(message));

    final generateKeys = GenerateKeys();
    final sharedSecret = await generateKeys.algorithmE2E
        .sharedSecretKey(keyPair: alicePair, remotePublicKey: alicePublic);

    final decryptedTitle = await generateKeys.algorithmAES.decryptString(
      SecretBox(
        parsedMessage.title.cipherText,
        nonce: parsedMessage.title.nonce,
        mac: Mac(parsedMessage.title.mac),
      ),
      secretKey: sharedSecret,
    );

    final decryptedMessage = await generateKeys.algorithmAES.decryptString(
      SecretBox(
        parsedMessage.message.cipherText,
        nonce: parsedMessage.message.nonce,
        mac: Mac(parsedMessage.message.mac),
      ),
      secretKey: sharedSecret,
    );

    print("decryptedTitle: ${decryptedTitle}");
    print("decryptedMessage: ${decryptedMessage}");
  }

  Future aliceBobMessage() async {
    final bobPair = await getBobDeviceKeyPair();
    final alicePair = await getAliceDeviceKeyPair();
    final alicePublic = await alicePair.extractPublicKey();

    final message = box.get('bob');
    final NoteDataForServerEncryptedData parsedMessage =
        NoteDataForServerEncryptedData.fromJson(jsonDecode(message));

    final generateKeys = GenerateKeys();
    final sharedSecret = await generateKeys.algorithmE2E
        .sharedSecretKey(keyPair: bobPair, remotePublicKey: alicePublic);

    final decryptedTitle = await generateKeys.algorithmAES.decryptString(
      SecretBox(
        parsedMessage.title.cipherText,
        nonce: parsedMessage.title.nonce,
        mac: Mac(parsedMessage.title.mac),
      ),
      secretKey: sharedSecret,
    );

    final decryptedMessage = await generateKeys.algorithmAES.decryptString(
      SecretBox(
        parsedMessage.message.cipherText,
        nonce: parsedMessage.message.nonce,
        mac: Mac(parsedMessage.message.mac),
      ),
      secretKey: sharedSecret,
    );

    print("decryptedTitle: ${decryptedTitle}");
    print("decryptedMessage: ${decryptedMessage}");
  }

  Future registerBob() async {
    // final bobPair = await _getE2EKeyPairForNotesUseCase.getBobDeviceKeyPair(); // TODO check how Error thow if no saved pair
    final bobPair = await _messageEncryptionUseCase.generateNewE2EKeyPair();
    await setE2EKeyPair(bobPair, 'bob');
  }

  Future registerAlice() async {
    // final alicePair =
    //     await _getE2EKeyPairForNotesUseCase.getAliceDeviceKeyPair();
    final alicePair = await _messageEncryptionUseCase.generateNewE2EKeyPair();
    await setE2EKeyPair(alicePair, 'alice');
  }

  Future setE2EKeyPair(SimpleKeyPair keyPair, String who) async {
    final jwk = await Jwk.fromKeyPair(keyPair);

    final json = jwk.toJson();
    await secureStorage.write(
      key: who,
      value: jsonEncode(json),
    );
  }

  Future<SimpleKeyPair> getAliceDeviceKeyPair() async {
    final String? keyPair = await secureStorage.read(key: 'alice');

    final gson = jsonDecode(keyPair as String);
    final parsedKeyPair = Jwk.fromJson(gson);
    return parsedKeyPair.toKeyPair() as SimpleKeyPair;
  }

  Future<SimpleKeyPair> getBobDeviceKeyPair() async {
    final String? keyPair = await secureStorage.read(key: 'bob');

    final gson = jsonDecode(keyPair as String);
    final parsedKeyPair = Jwk.fromJson(gson);
    return parsedKeyPair.toKeyPair() as SimpleKeyPair;
  }
}
