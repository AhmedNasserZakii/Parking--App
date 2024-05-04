import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:riverpod/riverpod.dart';

class UserImageNotifier extends StateNotifier<File?> {
  UserImageNotifier() : super(null) {
    loadSavedImage();
  }
  Future<void> loadSavedImage() async {
    try {
      final Directory appDocDir = await getApplicationDocumentsDirectory();
      final String filePath = '${appDocDir.path}/picked_image';
      final File savedImage = File(filePath);
      if (await savedImage.exists() && savedImage.lengthSync() > 0) {
        state = savedImage;
      }
    } catch (e) {
      // Handle errors if necessary
    }
  }

  Future<void> pickImage(ImageSource source) async {
    final pickedImage = await ImagePicker().pickImage(
      source: source,
      imageQuality: 50,
      maxWidth: 1500,
    );

    if (pickedImage != null) {
      try {
        final appDir = await getApplicationDocumentsDirectory();
        final fileName = basename(pickedImage.path);
        final savedImage =
            await File(pickedImage.path).copy('${appDir.path}/$fileName');

        state = savedImage; // Update the state with the new image
        saveImageLocal(savedImage); // Optionally save the image locally
      } catch (error) {
        if (kDebugMode) {
          print('Error saving image: $error');
        }
      }
    }
  }

  Future<void> saveImageLocal(File imageFile) async {
    final appDocDir = await getApplicationDocumentsDirectory();
    final filePath = '${appDocDir.path}/picked_image';
    final savedImage = await imageFile.copy(filePath);
    state = savedImage; // Update the state if necessary
  }
}

final userImageProvider =
    StateNotifierProvider<UserImageNotifier, File?>((ref) {
  return UserImageNotifier();
});
