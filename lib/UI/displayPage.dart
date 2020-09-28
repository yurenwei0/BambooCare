import 'dart:io';
import 'package:bamboo/UI/InfoPage.dart';
import 'package:flutter/material.dart';
import 'package:gradient_widgets/gradient_widgets.dart';
import 'package:bamboo/widgets/sexy_bottom_sheet.dart';
class DisplayPage extends StatefulWidget {
  final String imageLocation;
  DisplayPage({Key key, @required this.imageLocation}) : super(key : key);
  @override
  _DisplayPageState createState() => _DisplayPageState();


}

class _DisplayPageState extends State<DisplayPage> {

  @override
  Widget build(BuildContext context) {
    print("顯示圖片"+widget.imageLocation);
    return Scaffold(
      
      appBar: AppBar(
        backgroundColor: Color(0xff009100),
        title: Text('BambooCare'),
      ),
      body: Stack(
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

          /* Now Draw the Centre frame for image */
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                child: Card(
                  child: Image.file( File(widget.imageLocation) ),
                  // child: Image(
                  //   image: Image.file(widget.imageLocation);
                  // ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(right: 10),
                      child: GradientButton(
                        gradient: Gradients.tameer,
                        callback: () {Navigator.pop(context);},
                        
                        increaseHeightBy: 5,
                        increaseWidthBy: 5,
                        child: Text(
                          "重新",
                          style: TextStyle(fontSize: 10),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: GradientButton(
                        callback: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => InfoPage(imageData: widget.imageLocation)));
                        }, // Info page ko bas paas kar do Khatam
                        increaseHeightBy: 5,
                        increaseWidthBy: 5,
                        child: Text(
                          "送出",
                          style: TextStyle(fontSize: 10),
                        ),
                      ),

                    ),

                  ],

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
