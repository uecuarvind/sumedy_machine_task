import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import '../constants/string_constants.dart';
import '../navigation/navigation_service.dart';
import '../themes/app_text_style.dart';

class AppImagePickerAndCropper {
  String string = "";

  static List<File> convertXFilesToFiles({required List<XFile> xFiles}) {
    List<File> files = xFiles.map((xFile) => File(xFile.path)).toList();
    return files;
  }

  static Future<File?> pickImage({
    bool pickImageFromGallery = false,
    bool wantCropper = false,
    Color color = Colors.blue,
  }) async {
    XFile? imagePicker;

    await showDialog(
      context: NavigationService.navigatorKey.currentContext!,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Center(
            child: Text(
              StringConstants.selectImage,
              style: AppTextStyle.titleStyle18bb,
            ),
          ),
          content: Text(
            StringConstants.chooseImageFromTheOptionsBelow,
            style: AppTextStyle.titleStyle14bb,
            textAlign: TextAlign.center,
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () async {
                    pickImageFromGallery = false;
                    try {
                      imagePicker = await ImagePicker().pickImage(
                        source: ImageSource.camera,
                      );
                    } catch (e) {
                      print('ImagePicker error: $e');
                    }
                    NavigationService.pop();
                  },
                  child: CupertinoDialogAction(
                    isDefaultAction: true,
                    child: Text(
                      StringConstants.camera,
                      style: AppTextStyle.titleStyle12pct,
                    ),
                    onPressed: () {},
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    pickImageFromGallery = true;
                    try {
                      imagePicker = await ImagePicker().pickImage(
                        source: ImageSource.gallery,
                      );
                    } catch (e) {
                      print('ImagePicker error: $e');
                    }
                    NavigationService.pop();
                  },
                  child: CupertinoDialogAction(
                    isDefaultAction: true,
                    child: Text(
                      StringConstants.gallery,
                      style: AppTextStyle.titleStyle12pct,
                    ),
                    onPressed: () {},
                  ),
                ),
              ],
            ),

          ],
        );
      },
    );

    if (imagePicker == null) return null;

    File imageFile = File(imagePicker!.path);

    if (wantCropper) {
      CroppedFile? cropImage = await ImageCropper().cropImage(
        sourcePath: imagePicker!.path,
        uiSettings: [
          AndroidUiSettings(
            toolbarColor: color,
            toolbarTitle: "Cropper",
            activeControlsWidgetColor: color,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false,
            hideBottomControls: false,
            statusBarColor: color, // ✅ Make sure status bar matches toolbar
            toolbarWidgetColor: Colors.white, // ✅ For visibility
            showCropGrid: true,
          ),
          IOSUiSettings(
            title: 'Cropper',
          ),
        ],
        compressQuality: 80,
      );
      if (cropImage != null) return File(cropImage.path);
    }

    return imageFile;
  }

  static Future<List<XFile>> pickMultipleImages() async {
    final ImagePicker imagePicker = ImagePicker();
    List<XFile> imageFileList = [];

    final List<XFile> selectedImages = await imagePicker.pickMultiImage() ?? [];
    if (selectedImages.isNotEmpty) {
      imageFileList.addAll(selectedImages);
      if (kDebugMode) {
        print("Selected Image List Length:${imageFileList.length}");
      }
      return imageFileList;
    } else {
      return [];
    }
  }
}
