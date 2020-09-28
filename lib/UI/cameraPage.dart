import 'dart:io';
import 'package:bamboo/UI/displayPage.dart';
import 'package:bamboo/UI/InfoPage.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:gradient_widgets/gradient_widgets.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as provider;
import 'package:bamboo/widgets/sexy_bottom_sheet.dart';
List<CameraDescription> cameras;

class CameraApp extends StatefulWidget {
  @override
  _CameraAppState createState() => _CameraAppState();
}

void takePicture(CameraController cam, BuildContext context) async {
  // Generate random path
  Directory tempDir = await provider.getTemporaryDirectory();
  String tempPath = tempDir.path;
  final fPath = path.join(tempPath, '${DateTime.now()}.png');
  String Datatime;
  print(fPath);
  print("拍照" + fPath);
  await cam.takePicture(fPath);
  Navigator.push(context,
      MaterialPageRoute(builder: (context) => DisplayPage(imageLocation: fPath)));

}

class _CameraAppState extends State<CameraApp> {
  CameraController controller;

  @override
  void initState() {
    super.initState();
    controller = CameraController(cameras[0], ResolutionPreset.high);
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    // siAR  = _size.
    if (!controller.value.isInitialized) {
      return Container();
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff009100),
        title: Text('BambooCare'),
      ),

      body: Stack(

        children: <Widget>[


          ClipRect(
            child: Container(
              child: Transform.scale(
                scale: controller.value.aspectRatio / _size.aspectRatio,
                child: Center(
                  child: AspectRatio(
                    aspectRatio: controller.value.aspectRatio,
                    child: CameraPreview(controller),
                  ),
                ),
              ),
            ),
          ),
          Column(
            children: <Widget>[

              Padding(
                padding: EdgeInsets.fromLTRB(0, 500, 0, 0),
                child: GradientButton(
                  callback: () {
                    takePicture(controller, context);
                  },
                  increaseHeightBy: 20,
                  increaseWidthBy: 20,
                  child: Text(
                    "拍照",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
            ],
          ),
          SexyBottomSheet(),


        ],
      ),
    );
  }
}
