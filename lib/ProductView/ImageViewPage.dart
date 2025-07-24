import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_spinbox/material.dart';
import 'package:mustcompanyy/Services/API.dart';

class Imageviewpage extends StatefulWidget {
  const Imageviewpage({super.key});

  @override
  State<Imageviewpage> createState() => _ImageviewpageState();
}

class _ImageviewpageState extends State<Imageviewpage> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _hexColorController = TextEditingController();
  Uint8List? base64Image;
  double height = 100;
  double width = 100;
  double red = 128;
  double green = 128;
  double blue = 128;

  @override
  void initState() {
    super.initState();
    setHExCOlor(getHexColor());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text("Image View"),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Slider(
                  min: 0,
                  max: 255,
                  allowedInteraction: SliderInteraction.tapAndSlide,
                  activeColor: Color.fromRGBO(
                    red.toInt(),
                    green.toInt(),
                    blue.toInt(),
                    1,
                  ),
                  inactiveColor: Colors.grey,
                  value: red,
                  onChanged: (value) {
                    setState(() {
                      red = value;
                      _hexColorController.text = getHexColor();
                    });
                  },
                ),
                Slider(
                  min: 0,
                  max: 255,
                  allowedInteraction: SliderInteraction.tapAndSlide,
                  activeColor: Color.fromRGBO(
                    red.toInt(),
                    green.toInt(),
                    blue.toInt(),
                    1,
                  ),
                  inactiveColor: Colors.grey,
                  value: green,
                  onChanged: (value) {
                    setState(() {
                      green = value;
                      _hexColorController.text = getHexColor();
                    });
                  },
                ),
                Slider(
                  min: 0,
                  max: 255,
                  allowedInteraction: SliderInteraction.tapAndSlide,
                  activeColor: Color.fromRGBO(
                    red.toInt(),
                    green.toInt(),
                    blue.toInt(),
                    1,
                  ),
                  inactiveColor: Colors.grey,
                  value: blue,
                  onChanged: (value) {
                    setState(() {
                      blue = value;
                      _hexColorController.text = getHexColor();
                    });
                  },
                ),

                SizedBox(height: 5),
                TextField(
                  controller: _hexColorController,
                  decoration: InputDecoration(
                    hintText: "Enter Hex Color Code",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                  onChanged: (value) {
                    setHExCOlor(value);
                  },
                ),
                SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      spacing: 3,
                      children: [
                        Text("height in px"),
                        Container(
                          width: 150,
                          child: SpinBox(
                            min: 100,
                            max: 500,
                            incrementIcon: Icon(Icons.add, size: 15),
                            decrementIcon: Icon(Icons.remove, size: 15),
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(left: 2, right: 0),
                            ),
                            value: height,
                            onChanged: (value) {
                              setState(() {
                                height = value;
                              });
                              print("Height: $value");
                            },
                          ),
                        ),
                      ],
                    ),
                    Column(
                      spacing: 3,
                      children: [
                        Text("width in px"),
                        Container(
                          width: 150,
                          child: SpinBox(
                            min: 100,
                            max: 1000,
                            incrementIcon: Icon(Icons.add, size: 15),
                            decrementIcon: Icon(Icons.remove, size: 15),
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(left: 2, right: 0),
                            ),
                            value: width,
                            onChanged: (value) {
                              setState(() {
                                width = value;
                              });
                              print("Width : $value");
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 20),
                TextField(
                  controller: _titleController,
                  decoration: InputDecoration(
                    hintText: "Enter Something",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                if (base64Image != null) ...[

                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Image.memory(
                      base64Image!,
                      height: height,
                      width: width,
                      fit: BoxFit.cover,
                    ),
                  )
                ],
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    String imageUrl =
                        "${height}x${width}/${getHexColor()}?text=${modifyText(_titleController.text)}";
                    String? res = await API().getImage(imageUrl);
                    if (res != null) {
                      print("Image URL: $imageUrl");
                      setState(() {
                        base64Image = base64Decode(res);
                      });
                    }
                  },
                  child: Text("Confirm"),
                ),
              ],
            ),
          )
        ),
      ),
    );
  }

  String? modifyText(String text) {
    int len = text.length;
    if (len == 0) {
      return "";
    }
    return text.replaceAll(" ", "+");
  }

  void setHExCOlor(String hexColor) {
    if (hexColor.length != 6) {
      print("Invalid Hex Color Code");
      return;
    }
    String r = hexColor.substring(0, 2);
    String g = hexColor.substring(2, 4);
    String b = hexColor.substring(4, 6);
    red = int.parse(r, radix: 16).toDouble();
    green = int.parse(g, radix: 16).toDouble();
    blue = int.parse(b, radix: 16).toDouble();
    setState(() {
      _hexColorController.text = hexColor;
    });
  }

  String getHexColor() {
    return '${red.toInt().toRadixString(16).padLeft(2, '0')}${green.toInt().toRadixString(16).padLeft(2, '0')}${blue.toInt().toRadixString(16).padLeft(2, '0')}'
        .toUpperCase();
  }
}
