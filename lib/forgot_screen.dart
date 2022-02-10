import 'package:flutter/material.dart';
import 'package:zoho_project/login_screen.dart';

import 'package:zoho_project/db_page.dart' as obj;

class ForgotScreen extends StatefulWidget {
  const ForgotScreen({Key? key}) : super(key: key);

  @override
  _ForgotScreenState createState() => _ForgotScreenState();
}

class _ForgotScreenState extends State<ForgotScreen> {
  TextEditingController txtemail = TextEditingController();
  TextEditingController txtsecret = TextEditingController();
  TextEditingController txtpwd = TextEditingController();
  final dbHelper = obj.DatabaseHelper.instance;
  Future startupbyid(String email, String pwd) async {
    await dbHelper.selectforgotpwd(email, pwd).then((dynamic value) {
      if (dbHelper.appuserlist.isNotEmpty) {
        setState(() {
          txtpwd.text = dbHelper.appuserlist[0].Password.toString();
        });
      } else {
        obj.toastMsg('Invalid Credentials', '', context);
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    txtpwd.text = "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/Images/zohoforgot.jpg'),
              fit: BoxFit.fill,
              colorFilter: ColorFilter.mode(Colors.black54, BlendMode.darken),
            ),
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: Column(
            children: [
              const Flexible(
                child: Center(
                  child: Text(
                    'FORGOT PASSWORD',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 50, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: size.height * 0.08,
                    width: size.width * 0.9,
                    padding: const EdgeInsets.only(left: 20.0),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: TextFormField(
                      // ignore: use_full_hex_values_for_flutter_colors
                      cursorColor: const Color(0xfff1bb274),
                      controller: txtemail,
                      decoration: const InputDecoration(
                          icon: Icon(
                            Icons.mail,
                            color: Color(0xffb71c1c),
                          ),
                          hintText: 'Email',
                          hintStyle: TextStyle(fontFamily: 'OpenSans'),
                          border: InputBorder.none),
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Container(
                    height: size.height * 0.08,
                    width: size.width * 0.9,
                    padding: const EdgeInsets.only(left: 20.0),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: TextFormField(
                      // ignore: use_full_hex_values_for_flutter_colors
                      cursorColor: const Color(0xfff1bb274),
                      controller: txtsecret,
                      decoration: const InputDecoration(
                          icon: Icon(
                            Icons.lock,
                            color: Color(0xffb71c1c),
                          ),
                          hintText: 'Secret',
                          hintStyle: TextStyle(fontFamily: 'OpenSans'),
                          border: InputBorder.none),
                    ),
                  ),
                  txtpwd.text != ""
                      ? Container(
                          alignment: Alignment.center,
                          child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, crossAxisAlignment: CrossAxisAlignment.center, children: <Widget>[
                            Expanded(
                                flex: 2,
                                child: RichText(
                                  textAlign: TextAlign.center,
                                  text: const TextSpan(
                                    text: "Your PASSWORD :  ",
                                    style: TextStyle(fontSize: 16.0, color: Colors.white),
                                  ),
                                )),
                            Expanded(
                              flex: 2,
                              child: TextField(
                                controller: txtpwd,
                                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
                                decoration: const InputDecoration(border: InputBorder.none),
                              ),
                            ),
                          ]),
                        )
                      : Container(),
                  const SizedBox(
                    height: 25,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        child: const Text(
                          'SIGN IN',
                          style: TextStyle(color: Colors.white, fontSize: 17),
                        ),
                        onPressed: () {
                          startupbyid(txtemail.text.toString(), txtsecret.text.toString()).then((value) => setState(() {}));
                        },
                        style: ElevatedButton.styleFrom(
                            primary: const Color(0xffb71c1c),
                            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                            textStyle: const TextStyle(letterSpacing: 2, color: Colors.black, fontSize: 12, fontWeight: FontWeight.bold, fontFamily: 'OpenSans')),
                      ),
                      const SizedBox(
                        width: 25,
                      ),
                      ElevatedButton(
                        child: const Text(
                          'BACK',
                          style: TextStyle(color: Colors.white, fontSize: 17),
                        ),
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
                        },
                        style: ElevatedButton.styleFrom(
                            primary: const Color(0xffb71c1c),
                            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                            textStyle: const TextStyle(letterSpacing: 2, color: Colors.black, fontSize: 12, fontWeight: FontWeight.bold, fontFamily: 'OpenSans')),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                ],
              ),
            ],
          ),
        )
      ],
    );
  }
}
