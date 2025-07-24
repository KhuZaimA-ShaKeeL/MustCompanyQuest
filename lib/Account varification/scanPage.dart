import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:mustcompanyy/ProductView/ProductPage.dart';
class Scanpage extends StatefulWidget {
  const Scanpage({super.key});

  @override
  State<Scanpage> createState() => _ScanpageState();
}

class _ScanpageState extends State<Scanpage> {
  XFile? image;
  bool isSuccess = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Center(
                child: Lottie.asset(
                  'assets/lottie/scanDocument.json',
                  height: MediaQuery.of(context).size.height * 0.4,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "Scan ID document to\nverify your identity",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
        
              const SizedBox(height: 5),
              const Text(
                "Confirm your identity with few taps on your phone.",
                style: TextStyle(fontSize: 16, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              InkWell(
                onTap: PickImage,
                child: CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.blue,
                  child: Icon(CupertinoIcons.qrcode),
                ),
              ),
              SizedBox(height: 5),
              Text(
                "Scan",
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 20),
        
              if(isSuccess)
                Align(
                  alignment: Alignment.centerRight,
                  child: InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                        return  Productpage();
                      },));
                    },
                    child: CircleAvatar(
                      radius: 20,
                      child: Icon(Icons.arrow_forward_ios),
                    ),
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
  void PickImage() async {
    final ImagePicker _picker = ImagePicker();
    image = await _picker.pickImage(source: ImageSource.camera, imageQuality: 50);
    if (image != null) {
      setState(() {
        isSuccess=true;
      });
      print('Image selected: ${image!.path}');
    } else {
      print('No image selected.');
    }
  }
}
