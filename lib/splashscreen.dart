import 'dart:async';

import 'package:flutter/material.dart';

import 'package:zoho_project/login_screen.dart';
import 'package:zoho_project/db_page.dart' as obj;

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  int progress = 3;
  Timer _timer = Timer(const Duration(seconds: 1), () {});
  String loginstatus = "0";
  final dbHelper = obj.DatabaseHelper.instance;
  @override
  void initState() {
    // loginstatus = storagenew.get('loginstatus').toString();
    _timer = Timer.periodic(const Duration(seconds: 5), (void call) {
      // if (loginstatus != "null" || loginstatus != "0") {
      //   var rec = storagenew.get('Loginrecord');
      //   dbHelper.appuserlist = jsonDecode(rec.toString());
      //   _timer.cancel();
      //   Navigator.push(context, MaterialPageRoute(builder: (context) => const Home_Page()));
      // } else {
      _timer.cancel();
      Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
      // }
    });

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Container(
        alignment: Alignment.center,
        // padding: const EdgeInsets.all(50.0),
        height: MediaQuery.of(context).size.height - 50,
        child: Stack(
          // fit: StackFit.expand,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  flex: 6,
                  // ignore: avoid_unnecessary_containers
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const <Widget>[
                        // SizedBox(
                        //   height: 60,
                        // ),
                        CircleAvatar(
                          backgroundColor: Color(0xffffebee),
                          radius: 60.0,
                          child: Image(
                            image: AssetImage("assets/Images/zohomail.png"),
                            // width: 180.0,
                            // height: 200.0,
                            fit: BoxFit.contain,
                          ),
                        ),
                        Text(
                          "ZOHO",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.red, fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "COMMENT APP",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.indigo, fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                        // Padding(
                        //   padding: EdgeInsets.only(top: 30.0),
                        // ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 6,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: const <Widget>[
                      Image(
                        image: AssetImage("assets/Images/zoholoader.gif"),
                        // image: AssetImage("assets/kassalogo.jpg"),
                        width: 180.0,
                        height: 250.0,
                        fit: BoxFit.contain,
                      ),
                      // SizedBox(height: 20.0),
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
