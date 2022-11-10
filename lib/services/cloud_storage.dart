import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class CloudStoragService {
  final FirebaseStorage storage = FirebaseStorage.instance;

  Future<void> uploadFile(
    File imgFile,
    String fileName,
  ) async {
    try {
      print("inside");
      await storage.ref('test/$fileName').putFile(imgFile);
      print("Uploaded");
    } on FirebaseException catch (e) {
      debugPrint(
        e.toString(),
      );
    }
  }

  Future<String?> getURL(String imageName) async {
    try {
      String? downloadURL =
          await storage.ref('test/$imageName').getDownloadURL();
      return downloadURL;
    } on FirebaseException catch (e) {
      debugPrint(
        e.toString(),
      );
      return null;
    }
  }
}
