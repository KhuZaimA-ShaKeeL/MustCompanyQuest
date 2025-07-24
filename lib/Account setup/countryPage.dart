import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:country_picker/country_picker.dart';
import '../Account varification/settingUpPage.dart';
import '../Components/customButton.dart';
import '../Components/customTextFields.dart';

class Countrypage extends StatefulWidget {
  const Countrypage({super.key});

  @override
  State<Countrypage> createState() => _CountrypageState();
}

class _CountrypageState extends State<Countrypage> {
  final TextEditingController _countryController = TextEditingController();
  bool dropDownOpen = false;
  String SelectedCountry='';
  Map<String, String> countries = {
    "Bangladesh": "assets/flags/bangladesh.png",

    "United States": "assets/flags/united_states.png",

    "Singapore": "assets/flags/singapore.png",

    "India": "assets/flags/india.png",
  };

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
            Text("Country of residence", style: TextStyle(fontSize: 24)),
            SizedBox(height: 5),
            Text(
              "This info needs to be accurate with your ID document",
              style: TextStyle(color: Colors.grey),
            ),
            SizedBox(height: 10),
            Text("Country"),
            SizedBox(height: 5),
            CustomTextField(
              controller: _countryController,
              hintText: "Select your country",
              readOnly: true,
              //prefixIcon:
              suffixIcon: Icons.arrow_drop_down,
              prefixWidget: SelectedCountry.isNotEmpty
                  ? Image.asset(
                countries[SelectedCountry]!,
                width: 30,
                height: 20,
              )
                  : null,

              onTap: () {
                setState(() {
                  dropDownOpen = true;
                });
              },
            ),
            SizedBox(height: 10),
            if (dropDownOpen) ...[
              Card(
                child: Column(
                  children: [
                    for (var country in countries.keys)
                      ListTile(
                        leading: Image.asset(
                          countries[country] ?? "assets/flags/default.png",
                          width: 30,
                          height: 20,
                        ),
                        trailing: SelectedCountry ==country?Icon(Icons.check,color:Colors.black,):null,
                        title: Text(country),
                        onTap: () {
                          setState(() {
                            _countryController.text = country;
                            SelectedCountry=country;
                            dropDownOpen = false;
                          });
                        },
                      ),
                  ],
                ),
              ),
            ],
            Spacer(),
            CustomButton(
              text: "Continue",
              isEnabled:SelectedCountry.isNotEmpty,
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => Settinguppage(),));
              },
            ),
          ],
        ),
      ),
    );
  }
}
