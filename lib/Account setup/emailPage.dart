import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mustcompanyy/Account%20setup/addressPage.dart';

import '../Components/customButton.dart';
import '../Components/customTextFields.dart';
class emailPage extends StatefulWidget {
  const emailPage({super.key});

  @override
  State<emailPage> createState() => _emailPageState();
}

class _emailPageState extends State<emailPage> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () =>SystemNavigator.pop(),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("Add your email", style: TextStyle(fontSize: 24)),
            SizedBox(height: 5),
            Text(
              "This info needs to be accurate with your ID document",
              style: TextStyle(color: Colors.grey),
            ),
            SizedBox(height: 10),
            Text("Email"),
            SizedBox(height: 5),
            CustomTextField(
              controller: _controller,
              hintText: 'name@example.com',
            ),
            Spacer(),
            CustomButton(
              text: "Continue",
              isEnabled: _controller.text.isNotEmpty,
              onPressed: () {
               Navigator.push(context, MaterialPageRoute(builder: (context) => AddressPage(),)); 
              },
            ),
          ],
        ),
      ),
    );
  }
}
