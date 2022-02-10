import 'package:flutter/material.dart';

import 'package:zoho_project/db_page.dart' as obj;

import 'package:zoho_project/forgot_screen.dart';
import 'package:zoho_project/home_page.dart';
import 'package:zoho_project/signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final dbHelper = obj.DatabaseHelper.instance;
  TextEditingController txtemail = TextEditingController();
  TextEditingController txtpwd = TextEditingController();
  bool _obscureText = true;

  @override
  void initState() {
    startup();

    super.initState();
  }

  void _viewPassword() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  Future startup() async {
    await dbHelper.selectAppuser().then((dynamic value) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/Images/zohob.jpg'),
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
                    'SIGN IN',
                    style: TextStyle(color: Colors.white, fontSize: 50, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
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
                            color: Color(0xff1a237e),
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
                      controller: txtpwd,
                      obscureText: _obscureText,
                      decoration: InputDecoration(
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.remove_red_eye),
                            onPressed: _viewPassword,
                          ),
                          icon: const Icon(
                            Icons.lock,
                            color: Color(0xff1a237e),
                          ),
                          hintText: 'Password',
                          hintStyle: const TextStyle(fontFamily: 'OpenSans'),
                          border: InputBorder.none),
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const ForgotScreen()),
                    ),
                    child: const Text(
                      'Forgot your Password ?',
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  ElevatedButton(
                    child: const Text(
                      'SIGN IN',
                      style: TextStyle(color: Colors.white, fontSize: 17),
                    ),
                    onPressed: () {
                      if (txtemail.text.isEmpty) {
                        obj.toastMsg('Please Enter Email', '', context);
                      } else if (txtpwd.text.isEmpty) {
                        obj.toastMsg('Please Enter Password', '', context);
                      } else {
                        List<obj.AppuserModel> obj1 = dbHelper.appuserlist.where((element) => element.Email.toString() == txtemail.text && element.Password.toString() == txtpwd.text).toList();

                        if (obj1.isNotEmpty) {
                          dbHelper.userid = obj1[0].Id;
                          // dbHelper.appuserlist = (obj1[0]) as List<obj.AppuserModel>;
                          // storagenew.setString('Loginrecord', json.encode(obj1[0]));
                          // storagenew.setString('loginstatus', "1");
                          obj.toastMsg('Successfully Login', '', context);
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const Home_Page()),
                          );
                        } else {
                          txtemail.text = "";
                          txtpwd.text = "";
                          obj.toastMsg('Invalid Credentials, Signup First...', '', context);
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        primary: const Color(0xff1a237e),
                        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                        textStyle: const TextStyle(letterSpacing: 2, color: Colors.black, fontSize: 12, fontWeight: FontWeight.bold, fontFamily: 'OpenSans')),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    child: Container(
                      padding: const EdgeInsets.all(10.0),
                      // height: 30,
                      child: const Text(
                        "Don't have an  Account ? ",
                        style: TextStyle(color: Colors.black, fontSize: 14),
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  ElevatedButton(
                    child: const Text(
                      'SIGN UP',
                      style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const SignupScreen()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                        primary: const Color(0xff7986cb),
                        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                        textStyle: const TextStyle(letterSpacing: 2, color: Colors.black, fontSize: 12, fontWeight: FontWeight.bold, fontFamily: 'OpenSans')),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        )
      ],
    );
  }
}
