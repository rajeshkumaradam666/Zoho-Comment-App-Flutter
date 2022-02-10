import 'package:flutter/material.dart';
import 'package:zoho_project/db_page.dart' as obj;
import 'package:zoho_project/login_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController txtemail = TextEditingController();
  TextEditingController txtpwd = TextEditingController();
  TextEditingController txtsecret = TextEditingController();
  final dbHelper = obj.DatabaseHelper.instance;

  Future savecategory() async {
    if (txtemail.text.isEmpty) {
      obj.toastMsg('Please Enter Email Id', '', context);
      return;
    }
    if (txtpwd.text.isEmpty) {
      obj.toastMsg('Please Enter Password', '', context);
      return;
    }

    try {
      obj.QueryResponse rr;
      if (txtemail.text.isNotEmpty && txtpwd.text.isNotEmpty) {
        Map<String, dynamic> row = {
          obj.DatabaseHelper.tableAppuserEmail: txtemail.text.toString(),
          obj.DatabaseHelper.tableAppuserPassword: txtpwd.text.toString(),
          obj.DatabaseHelper.tableAppuserSecret: txtsecret.text.toString(),
          obj.DatabaseHelper.tableAppusercommand: "",
        };
        rr = await dbHelper.insertAppUser(
          row,
        );

        if (rr.result == true) {
          obj.toastMsg('CREATED SUCCESSFULLY', '', context);
          txtpwd.text = "";
          txtemail.text = "";
          txtsecret.text = "";
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const LoginScreen()),
          );
        } else {
          obj.toastMsg('CREATE FAILED', '', context);
        }
      }
    } catch (er) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/Images/Zohosign.jpg'),
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
                    'SIGN UP',
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
                      controller: txtemail,
                      // ignore: use_full_hex_values_for_flutter_colors
                      cursorColor: const Color(0xfff1bb274),
                      decoration: const InputDecoration(
                          icon: Icon(
                            Icons.mail,
                            color: Color(0xff1b5e20),
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
                      decoration: const InputDecoration(
                          icon: Icon(
                            Icons.lock,
                            color: Color(0xff1b5e20),
                          ),
                          hintText: 'Password',
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
                            Icons.lock_open_outlined,
                            color: Color(0xff1b5e20),
                          ),
                          hintText: 'Secret',
                          hintStyle: TextStyle(fontFamily: 'OpenSans'),
                          border: InputBorder.none),
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  ElevatedButton(
                    child: const Text(
                      'SIGN UP',
                      style: TextStyle(color: Colors.white, fontSize: 17),
                    ),
                    onPressed: () {
                      savecategory();
                    },
                    style: ElevatedButton.styleFrom(
                        primary: const Color(0xff4caf50),
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
                        "Already have an  Account ? ",
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
                      'SIGN IN',
                      style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const LoginScreen()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                        primary: const Color(0xffa5d6a7),
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
