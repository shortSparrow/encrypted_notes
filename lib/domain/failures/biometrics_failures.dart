
import 'package:encrypted_notes/domain/failures/failures.dart';

class DeviceIsNotBrowser extends Failure {}
class NoSavedUserId extends Failure {}
class FailureAuthUsingBIO extends Failure {}
class BioNotSupported extends Failure {}
class FailedCreateWebAuth extends Failure {}