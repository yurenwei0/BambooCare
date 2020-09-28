import 'package:flutter/material.dart';
import 'UI/cameraPage.dart';
import 'package:camera/camera.dart';

import 'UI/cameraPage.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  runApp(
    MaterialApp(
      home: LandingPage(),
    ),
  );
}

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage>
    with SingleTickerProviderStateMixin {
  Animation<double> animation;
  AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(duration: const Duration(seconds: 2), vsync: this);
    animation = Tween<double>(begin: 10, end: 40).animate(
      new CurvedAnimation(
        parent: controller,
        curve: Curves.bounceOut,
      ),
    )..addListener(() {
        setState(() {
          print(controller.value);
        });
      });
    controller.forward();
    print(controller.value);
    controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        print("Completed");
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => CameraApp()));
        // Navigate to next page
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  // Center me image hoga jo rotate karega. if animation complete then navigate
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.white,
      body: new Stack(
        children: <Widget>[
          Opacity(
            opacity: 0.25,
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('images/bg.jpg'), fit: BoxFit.cover),
              ),
            ),
          ),
          Center(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(200)),
              ),
              child: Image(
                image: AssetImage('images/Logo.png'),
                height: animation.value * 4,
                width: animation.value * 4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TestPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: new Text(
        "Bamboo",
        style: TextStyle(fontSize: 50),
      ),
    );
  }
}
