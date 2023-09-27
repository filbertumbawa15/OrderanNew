import 'package:flutter/material.dart';
import 'package:tasorderan/components/masking_view/mask_for_camera_view.dart';
import 'package:tasorderan/components/masking_view/mask_for_camera_view_camera_description.dart';
import 'package:tasorderan/components/masking_view/mask_for_camera_view_result.dart';

class CameraVerifikasi extends StatefulWidget {
  final String? param;
  final String? title;
  const CameraVerifikasi({Key? key, this.param, this.title}) : super(key: key);

  @override
  State<CameraVerifikasi> createState() => _CameraVerifikasiState();
}

class _CameraVerifikasiState extends State<CameraVerifikasi> {
  @override
  void initState() {
    super.initState();
  }

  // Future<XFile> initializeFileKtp(Uint8List imageBytes) async {
  //   Uint8List imageInUnit8List = imageBytes;
  //   Directory root = await getTemporaryDirectory();
  //   String directoryPath = '${root.path}';
  //   File file =
  //       await File('$directoryPath/${DateTime.now().millisecondsSinceEpoch}')
  //           .create();
  //   file.writeAsBytesSync(imageInUnit8List);
  //   print(file.path);
  //   return XFile(file.path);
  // }

  // Future<File> initializeFilenpwp(Uint8List imageBytes) async {
  //   Uint8List imageInUnit8List = imageBytes;
  //   Directory root = await getTemporaryDirectory();
  //   String directoryPath = '${root.path}';
  //   File file =
  //       await File('$directoryPath/${DateTime.now().millisecondsSinceEpoch}')
  //           .create();
  //   file.writeAsBytesSync(imageInUnit8List);
  //   print(file.path);
  //   return File(file.path);
  // }

  // CameraController controller;
  // bool _cameraVisible;

  // SimpleFontelicoProgressDialog _dialog;

  // @override
  // void initState() {
  //   super.initState();
  //   _cameraVisible = true;
  // }

  // void _showDialog(BuildContext context, SimpleFontelicoProgressDialogType type,
  //     String text) async {
  //   if (_dialog == null) {
  //     _dialog = SimpleFontelicoProgressDialog(
  //         context: context, barrierDimisable: false);
  //   }
  //   if (type == SimpleFontelicoProgressDialogType.custom) {
  //     _dialog.show(
  //         message: text,
  //         type: type,
  //         width: 150.0,
  //         height: 75.0,
  //         loadingIndicator: Text(
  //           'C',
  //           style: TextStyle(fontSize: 24.0),
  //         ));
  //   } else {
  //     _dialog.show(
  //         message: text,
  //         type: type,
  //         horizontal: true,
  //         width: 150.0,
  //         height: 75.0,
  //         hideText: true,
  //         indicatorColor: Colors.blue);
  //   }
  // }

  // Future<File> takePicturenpwp() async {
  //   Directory root = await getTemporaryDirectory();
  //   String directoryPath = '${root.path}';
  //   await Directory(directoryPath).create(recursive: true);
  //   String filePath =
  //       '$directoryPath/${DateTime.now().millisecondsSinceEpoch}.jpg';
  //   print(directoryPath);

  //   try {
  //     await controller.takePicture();
  //   } catch (e) {
  //     return null;
  //   }
  //   ImageProperties properties =
  //       await FlutterNativeImage.getImageProperties(filePath);

  //   int width = properties.width;
  //   var offset = (properties.height - properties.width) / 2;
  //   File croppedFile = await FlutterNativeImage.cropImage(
  //       filePath, 10.round(), 150.round(), 450, 300);
  //   return File(croppedFile.path);
  // }

  // Future<XFile> takePictureKtp() async {
  //   Directory root = await getTemporaryDirectory();
  //   String directoryPath = '${root.path}';
  //   await Directory(directoryPath).create(recursive: true);
  //   String filePath =
  //       '$directoryPath/${DateTime.now().millisecondsSinceEpoch}.jpg';

  //   print(filePath);

  //   try {
  //     await controller.takePicture();
  //   } catch (e) {
  //     return null;
  //   }
  //   ImageProperties properties =
  //       await FlutterNativeImage.getImageProperties(filePath);

  //   var width = MediaQuery.of(context).size.width;
  //   double height = MediaQuery.of(context).size.width / 2;
  //   var cropSize = min(properties.width, properties.height);
  //   print(properties.width);
  //   print(properties.height);
  //   print("baca");
  //   print(cropSize);
  //   int offsetX =
  //       (properties.width - min(properties.width, properties.height)) ~/ 2;
  //   int offsetY =
  //       (properties.height - min(properties.width, properties.height)) ~/ 2;
  //   File croppedFile = await FlutterNativeImage.cropImage(
  //       filePath, offsetX, offsetY, height.round(), width.round());
  //   return XFile(croppedFile.path);
  // }

  @override
  Widget build(BuildContext context) {
    return MaskForCameraView(
      visiblePopButton: false,
      boxBorderWidth: 3.0,
      cameraDescription: MaskForCameraViewCameraDescription.rear,
      onTake: (MaskForCameraViewResult res) async {
        Navigator.pop(context, {
          'croppedImage': res.croppedImage,
        });
      },
    );
  }
}
