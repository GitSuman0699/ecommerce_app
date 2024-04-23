import 'package:firebase_storage/firebase_storage.dart';

class FirebaseStorageService {
  static FirebaseStorageService get instance => FirebaseStorageService();
  final FirebaseStorage firebaseStorage = FirebaseStorage.instance;
}
