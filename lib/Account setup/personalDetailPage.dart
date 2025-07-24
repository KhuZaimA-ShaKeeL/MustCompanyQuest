import 'package:flutter/material.dart';
import 'package:mustcompanyy/Account%20setup/countryPage.dart';
import '../Components/customButton.dart';
import '../Components/customTextFields.dart';

class PersonalDetailPage extends StatefulWidget {
  const PersonalDetailPage({super.key});

  @override
  State<PersonalDetailPage> createState() => _PersonalDetailPageState();
}

class _PersonalDetailPageState extends State<PersonalDetailPage> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();

  DateTime? dateOfBirth;

  Future<void> _pickDate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: dateOfBirth ?? DateTime(2000, 1, 1),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null) {
      setState(() {
        dateOfBirth = pickedDate;
        _dobController.text =
        "${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}";
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _fullNameController.addListener(() => setState(() {}));
    _userNameController.addListener(() => setState(() {}));
    _dobController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _userNameController.dispose();
    _dobController.dispose();
    super.dispose();
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
            Text("Add your personal details", style: TextStyle(fontSize: 24)),
            SizedBox(height: 5),
            Text(
              "This info needs to be accurate with your ID document",
              style: TextStyle(color: Colors.grey),
            ),
            SizedBox(height: 10),
            Text("Full Name"),
            SizedBox(height: 5),
            CustomTextField(
              controller: _fullNameController,
              hintText: 'Mr. John Doe',
            ),
            SizedBox(height: 10),
            Text("User Name"),
            SizedBox(height: 5),
            CustomTextField(
              controller: _userNameController,
              hintText: '@Username',
            ),
            SizedBox(height: 10),
            Text("Date of Birth"),
            SizedBox(height: 5),
            CustomTextField(
              controller: _dobController,
              hintText: 'Select your birthdate',
              readOnly: true,
              onTap: _pickDate,
              prefixIcon: Icons.calendar_today,
            ),
            Spacer(),
            CustomButton(
              text: "Continue",
              isEnabled: _fullNameController.text.isNotEmpty &&
                  _userNameController.text.isNotEmpty &&
                  dateOfBirth != null,
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => Countrypage(),));
              },
            ),
          ],
        ),
      ),
    );
  }
}
