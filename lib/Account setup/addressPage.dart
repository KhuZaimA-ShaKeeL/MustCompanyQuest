import 'package:flutter/material.dart';
import 'package:mustcompanyy/Account%20setup/personalDetailPage.dart';

import '../Components/customButton.dart';
import '../Components/customTextFields.dart';
class AddressPage extends StatefulWidget {
  const AddressPage({super.key});

  @override
  State<AddressPage> createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  final _addressLineController = TextEditingController();
  final _cityController = TextEditingController();
  final _postCodeController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _addressLineController.addListener(() {
      setState(() {});
    });
    _cityController.addListener(() {
      setState(() {});
    });
    _postCodeController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _addressLineController.dispose();
    _cityController.dispose();
    _postCodeController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("Home address", style: TextStyle(fontSize: 24)),
            SizedBox(height: 5),
            Text(
              "This info needs to be accurate with your ID document",
              style: TextStyle(color: Colors.grey),
            ),
            SizedBox(height: 10),
            Text("Address Line"),
            SizedBox(height: 5),
            CustomTextField(
              controller: _addressLineController,
              hintText: 'Mr. John Doe',
            ),
            SizedBox(
              height: 5,
            ),
            Text("City"),
            SizedBox(height: 5),
            CustomTextField(
              controller: _cityController,
              hintText: 'City, State',
            ),
            Text("Postcode "),
            SizedBox(height: 5),
            CustomTextField(
              controller: _postCodeController,
              hintText: 'Ex: 12345',
            ),
            Spacer(),
            CustomButton(
              text: "Continue",
              isEnabled: _addressLineController.text.isNotEmpty&&
                  _cityController.text.isNotEmpty &&
                  _postCodeController.text.isNotEmpty,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PersonalDetailPage(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
