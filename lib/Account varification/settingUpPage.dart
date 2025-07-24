import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:mustcompanyy/Account%20varification/takeSelfiePage.dart';

class Settinguppage extends StatefulWidget {
  const Settinguppage({super.key});

  @override
  State<Settinguppage> createState() => _SettinguppageState();
}

class _SettinguppageState extends State<Settinguppage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Center(
              child: Lottie.asset(
                'assets/lottie/setup.json',
                height: MediaQuery
                    .of(context)
                    .size
                    .height * 0.4,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "Setting up\nyour account",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 5),
            const Text(
              "We are analyzing your data to verify",
              style: TextStyle(fontSize: 16, color: Colors.grey),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 20),
            ListView(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              children: [
                const ListTile(
                  leading: CircleAvatar(
                    foregroundColor: Colors.black,
                    minRadius: 15,
                    maxRadius: 18,

                    // radius: 15,
                    child: Text("1"),
                    backgroundColor: Color(0xBCB8B8FF),
                  ),
                  trailing: Icon(
                    Icons.check_circle, color: Colors.blue, size: 30,),
                  title: Text("Personal details verified"),
                ),
                const ListTile(
                  leading: CircleAvatar(
                    foregroundColor: Colors.black,
                    minRadius: 15,
                    maxRadius: 18,

                    // radius: 15,
                    child: Text("2"),
                    backgroundColor: Color(0xBCB8B8FF),
                  ),
                  trailing: Icon(
                    Icons.check_circle, color: Colors.blue, size: 30,),
                  title: Text("Checking up document ID"),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) => Takeselfiepage(),));
                  },
                  child: const ListTile(
                    leading: CircleAvatar(
                      foregroundColor: Colors.black,
                      minRadius: 15,
                      maxRadius: 18,

                      // radius: 15,
                      child: Text("3"),
                      backgroundColor: Color(0xBCB8B8FF),
                    ),
                    trailing: SizedBox(
                      height: 27,
                      width: 27,
                      child: CircularProgressIndicator(
                        color: Colors.blue,
                        strokeWidth: 1.5,
                      ),
                    ),
                    title: Text("Verify photo"),
                  ),
                ),

              ],
            )
          ],
        ),
      ),
    );
  }
}
