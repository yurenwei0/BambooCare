import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:gradient_widgets/gradient_widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:path_provider/path_provider.dart';
import 'package:intl/intl.dart';
import 'package:bamboo/widgets/sexy_bottom_sheet.dart';



void postTest() async {

  // Body me list hai sirf
  print("步驟1");
  final response = await http.get('https://jsonplaceholder.typicode.com/posts/1'); // Body se banega string
  print("步驟2");
  print(response.body);

}



class FetchDecode {


  List <String>  diseaseNameList;
  List <String>  speciesList;


  //  = http.get('124');


  String diseaseName;
  String speciesName;
  String boolBamboo;
  String boolHealth;



}



List<String> tempList = ['Test', 'TestA'];

class InfoPage extends StatefulWidget {



  final String imageData; // Location of the captured image to display
  InfoPage( {Key key , @required this.imageData}):super(key : key);

  @override
  _InfoPageState createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
   String value; // 每次input的值
   String allText = '辨識等待中...'; // 从本地文件获取的值
   /**
    * 此方法返回本地文件地址
    */
   Future<File> _getLocalFile() async {
     // 获取文档目录的路径
     Directory appDocDir = await getApplicationDocumentsDirectory();
     String dir = appDocDir.path;
     final file = new File('$dir/demo.txt');
     // print(file);
     return file;
   }



   sendImage(String loc) async {
     File imageFile = new File(loc);
     List <int> imageBytes = imageFile.readAsBytesSync();
     String encImage = base64.encode(imageBytes);
     // Map <String, String>  jString=  {
     //   'file': encImage,
     //   'size': '224',
     // };
     print("上傳圖片");
     var temp = await http.post(
         'http://140.123.94.141:8000/api/test/', body: encImage);




     print("圖片資訊");
     print("辨識結果:" + temp.body);
     print("圖片資訊2"  );
     DateTime now = new DateTime.now();
     String formattedDate = DateFormat('yyyy-MM-dd kk:mm:ss').format(now);
     print("時間：" + formattedDate);

       try {
         File f = await _getLocalFile();
         IOSink slink = f.openWrite(mode: FileMode.append);
         slink.write(formattedDate +" \n"+ "辨識結果為:"+ temp.body+" \n");
         //slink.write(widget.imageData +" \n"+ temp.body);
         // await fs.writeAsString('$value');
         setState(() {
           value = '';
         });
         slink.close();
       } catch (e) {
         // 写入错误
         print(e);
       }
        File file = await _getLocalFile();
           // 从文件中读取变量作为字符串，一次全部读完存在内存里面
           String contents = await file.readAsString();
           setState(() {
           allText = contents;
           });

           File f = await _getLocalFile();
           await f.writeAsString('');

   }


   /**
    * 读取本地文件的内容
    */
   void _readContent() async {
     File file = await _getLocalFile();
     // 从文件中读取变量作为字符串，一次全部读完存在内存里面
     String contents = await file.readAsString();
     setState(() {
       allText = contents;
     });
   }
// 清空本地保存的文件
  void _clearContent() async {
    File f = await _getLocalFile();
    await f.writeAsString('');
  }
  // Init state me kare to har redraw pe print karna hoga
  @override
  void initState() {
    sendImage(widget.imageData);
    super.initState();
    print("sendImage");
    String INimg1 = "123" + widget.imageData;
    print(INimg1);


  }

@override
  Widget build(BuildContext context) {
  print("IMG" + widget.imageData );


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
          Padding(
            padding: EdgeInsets.fromLTRB(80, 0, 80, 0),
            child: Container(
              decoration: BoxDecoration(
                color: Color(0x11111111),
              ),
              child: Center(
                child: Column(
                  // mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 80, 0, 0),
                      child: GradientText(
                        "辨識結果",
                        gradient: Gradients.tameer,
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),

                      ),
                    ),
                    Container(
                      child: Card(
                        child: Image.file( File(widget.imageData) ),
                        // child: Image(
                        //   image: Image.file(widget.imageLocation);
                        // ),
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 100, 0, 0),

                      child: Text(
                          '''$allText'''
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 50),
                      child: GradientButton(
                        callback: () {_clearContent();},
                        increaseHeightBy: 10,
                        increaseWidthBy: 10,
                        child: Text(
                          "清除",
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ),

                  ],
                ),

              ),
            ),
          ),
          SexyBottomSheet(),
        ],

      ),
    );
  }
}



/*

class DropDownList extends StatefulWidget {
  // Lis

  final String headValue;
  final List<String> listValues;
  DropDownList(this.headValue, this.listValues);

  @override
  _DropDownListState createState() => _DropDownListState();
}

class _DropDownListState extends State<DropDownList> {
  String curValue = 'Test'; // Yahi Change hoga

  @override
  Widget build(BuildContext context) {
    print("未知動作步驟1");
    return Container(
        child: Row(
        mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(widget.headValue + " : "),
        DropdownButton(
          onChanged: (String newValue) {
            setState(
              () {
                this.curValue = newValue;
              },
            );
          },
          value: curValue,
          /* Basically List ka type change karna hai,  */
          items:
              widget.listValues.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      ],
    ));
  }
}
*///