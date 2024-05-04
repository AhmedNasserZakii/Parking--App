// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

// import 'package:path_provider/path_provider.dart';
// import 'package:path/path.dart';

import '../models/const.dart';
import '../provider/user_image.dart';

class UserImagePicker extends ConsumerStatefulWidget {
  const UserImagePicker({
    super.key,
  });

  // final void Function(File pikceImage) onPickedImage;
  @override
  ConsumerState<UserImagePicker> createState() => _UserImagePickerState();
}

class _UserImagePickerState extends ConsumerState<UserImagePicker> {
  // File? pickedImageFile;
  // @override
  // void initState() {
  //   super.initState();
  //   _loadSavedImage();
  // }

  // Future<void> _loadSavedImage() async {
  //   final Directory appDocDir = await getApplicationDocumentsDirectory();
  //   final String filePath = '${appDocDir.path}/picked_image';

  //   setState(() {
  //     pickedImageFile = File(filePath);
  //     widget.onPickedImage(pickedImageFile!);
  //   });
  // }

  // void _pickImage(ImageSource sourse) async {
  //   final pickedImage = await ImagePicker().pickImage(source: sourse);

  //   if (pickedImage == null) {
  //     return;
  //   }
  //   setState(() {
  //     pickedImageFile = File(pickedImage.path);
  //   });

  //   _saveImageLocal(pickedImageFile!);
  // }
  // void _pickImage(ImageSource source) async {
  //   final pickedImage = await ImagePicker().pickImage(
  //     source: source,
  //     imageQuality: 50,
  //     maxWidth: 1500,
  //   );

  //   if (pickedImage != null) {
  //     // Creating a new file in your app's document directory
  //     final appDir = await getApplicationDocumentsDirectory();
  //     final fileName = basename(pickedImage.path);
  //     final savedImage =
  //         await File(pickedImage.path).copy('${appDir.path}/$fileName');

  //     setState(() {
  //       pickedImageFile = savedImage;
  //     });

  //     widget.onPickedImage(savedImage);
  //     _saveImageLocal(pickedImageFile!);
  //   }
  // }

  // void _saveImageLocal(File imageFile) async {
  //   if (imageFile != null) {
  //     final Directory appDocDir = await getApplicationDocumentsDirectory();
  //     final String filePath = '${appDocDir.path}/picked_image';
  //     await imageFile.copy(filePath);
  //   }
  // }

  Future<void> _pickImageSource(BuildContext context) async {
    //final pickedImage = ref.watch(userImageProvider);
    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: kProfileCardColor,
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ListTile(
                  leading: const Icon(
                    Icons.camera,
                    color: Colors.black,
                  ),
                  title: Text(
                    'Camera',
                    style: latoStyle.copyWith(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  onTap: () async {
                    Navigator.pop(context);
                    await ref
                        .read(userImageProvider.notifier)
                        .pickImage(ImageSource.camera);

                    // if (pickedImage != null) {
                    //   ref
                    //       .read(userImageProvider.notifier)
                    //       .saveImageLocal(pickedImage);
                    // }

                    // _pickImage(ImageSource.camera);
                  },
                ),
                ListTile(
                  leading: const Icon(
                    Icons.image,
                    color: Colors.black,
                  ),
                  title: Text(
                    'Gallery',
                    style: latoStyle.copyWith(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  onTap: () async {
                    Navigator.pop(context);
                    await ref
                        .read(userImageProvider.notifier)
                        .pickImage(ImageSource.gallery);

                    // if (pickedImage != null) {
                    //   ref
                    //       .read(userImageProvider.notifier)
                    //       .saveImageLocal(pickedImage);
                    // }

                    // _pickImage(ImageSource.gallery);
                  },
                ),
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final pickedImageFile = ref.watch(userImageProvider);
    return Column(
      children: [
        GestureDetector(
          onTap: () => _pickImageSource(context),
          child: CircleAvatar(
              radius: 80.w,
              backgroundColor: const Color.fromARGB(120, 218, 213, 213),
              foregroundImage:
                  pickedImageFile != null ? FileImage(pickedImageFile) : null,
              child: pickedImageFile == null
                  ? Center(
                      child: Text(
                        'ADD..PHOTO',
                        style: latoStyle.copyWith(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    )
                  : null),
        ),
      ],
    );
  }
}
