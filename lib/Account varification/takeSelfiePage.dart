import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as img;
import 'package:lottie/lottie.dart';
import 'package:mustcompanyy/Account%20varification/scanPage.dart';

class Takeselfiepage extends StatefulWidget {
  const Takeselfiepage({super.key});

  @override
  State<Takeselfiepage> createState() => _TakeselfiepageState();
}

class _TakeselfiepageState extends State<Takeselfiepage> {
  XFile? image = null;
  bool isSuccess = false;
  bool isFaceDetected = false;

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
                child:
                    image == null
                        ? Lottie.asset(
                          'assets/lottie/photo.json',
                          height: MediaQuery.of(context).size.height * 0.4,
                        )
                        : isSuccess && isFaceDetected
                        ? ClipOval(
                      clipBehavior: Clip.hardEdge,
                          child: Image.file(
                            File(image!.path),
                           // height: MediaQuery.of(context).size.height * 0.4,
                          ),
                        )
                        : Text(
                          "No face is detected",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
              ),

              const SizedBox(height: 20),
              const Text(
                "Take a selfie to verify\nyour identity",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 5),
              const Text(
                "Quick and easy identification verification using you phone camera.Confirm your identity by taking a selfie.",
                style: TextStyle(fontSize: 16, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              InkWell(
                onTap: PickImage,
                child: CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.blue,
                  child: Icon(CupertinoIcons.camera),
                ),
              ),
              SizedBox(height: 5),
              Text(
                "Take a selfie",
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 20),
              if (isSuccess)
                Align(
                  alignment: Alignment.centerRight,
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return Scanpage();
                          },
                        ),
                      );
                    },
                    child: CircleAvatar(
                      radius: 20,
                      child: Icon(Icons.arrow_forward_ios),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  void PickImage() async {
    final ImagePicker _picker = ImagePicker();
    image = await _picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 50,
    );

    if (image != null) {
      final inputImage = InputImage.fromFilePath(image!.path);

      final faceDetector = FaceDetector(
        options: FaceDetectorOptions(
          enableTracking: true,
          enableClassification: true,
          enableContours: true,
          enableLandmarks: true,
        ),
      );
      final faces = await faceDetector.processImage(inputImage);
      if(faces.isEmpty) {
        print('No face detected.');
        setState(() {
          isSuccess = false;
          isFaceDetected = false;
        });
        return;
      }
      print("Faces detected: ${faces.length}");
      setState(() {
        isSuccess = true;
        isFaceDetected = faces.isNotEmpty;
      });




        final faceBox = faces.first.boundingBox;

        final bytes = await File(image!.path).readAsBytes();
        final originalImage = img.decodeImage(bytes);

        if (originalImage == null) return;

          final left = faceBox.left.toInt();
        final top = faceBox.top.toInt();
        final width = faceBox.width.toInt();
        final height = faceBox.height.toInt();

        final cropped = img.copyCrop(originalImage, x: left, y: top, width: width, height: height);
        final croppedPath = '${image!.path}_face.jpg';
        await File(croppedPath).writeAsBytes(img.encodeJpg(cropped));
        setState(() {
          image = XFile(croppedPath);
        });

        print('Face detected and cropped.');
    } else {
      print('No image selected.');
    }
  }
}
