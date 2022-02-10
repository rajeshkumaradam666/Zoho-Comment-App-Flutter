import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:zoho_project/db_page.dart' as obj;
import 'package:zoho_project/login_screen.dart';

// ignore: camel_case_types
class Home_Page extends StatefulWidget {
  const Home_Page({Key? key}) : super(key: key);

  @override
  _Home_PageState createState() => _Home_PageState();
}

// ignore: camel_case_types
class _Home_PageState extends State<Home_Page> {
  final dbHelper = obj.DatabaseHelper.instance;
  TextEditingController txtcmd = TextEditingController();

  @override
  void initState() {
    startup();

    super.initState();
  }

  Future startup() async {
    await dbHelper.selectcomments().then((dynamic value) {
      setState(() {});
    });
  }

  Future startupbyid() async {
    await dbHelper.selectcommentsbyId(dbHelper.userid).then((dynamic value) {
      setState(() {});
    });
  }

  Future savecommand() async {
    List<obj.AppuserModel> obj1 = dbHelper.appuserlist.where((element) => element.Id == dbHelper.userid).toList();
    if (txtcmd.text.isEmpty) {
      obj.toastMsg('Enter Comment', '', context);
      return;
    }

    obj.QueryResponse rr;

    Map<String, dynamic> row = {
      obj.DatabaseHelper.tablecommentscommand: txtcmd.text,
      obj.DatabaseHelper.tablecommentsEmail: obj1[0].Email,
      obj.DatabaseHelper.tablecommentsUserRefId: obj1[0].Id,
    };
    rr = await dbHelper.insertAppUsercomments(row);

    if (rr.result == true) {
      obj.toastMsg('SAVED SUCCESSFULLY', '', context);
      await startup();
      txtcmd.text = "";
    } else {
      obj.toastMsg('SAVE ERROR ' + rr.message, '', context);
    }
  }

  Row loadgridheader() {
    return Row(
      children: const <Widget>[
        Expanded(
          flex: 1,
          child: Text(
            "Email",
            textAlign: TextAlign.left,
            style: TextStyle(
              color: Colors.white,
              fontSize: 15.0,
              fontWeight: FontWeight.bold,
              fontFamily: 'Alatsi',
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(
            "Comments",
            textAlign: TextAlign.left,
            style: TextStyle(
              color: Colors.white,
              fontSize: 15.0,
              fontWeight: FontWeight.bold,
              fontFamily: 'Alatsi',
            ),
          ),
        ),
      ],
    );
  }

  Widget loadBillDetailsGrid(dynamic objBillDetails) {
    return Container(
      // margin: const EdgeInsets.all(10.0),
      // shape: RoundedRectangleBorder(
      //   borderRadius: BorderRadius.circular(0.0),
      // ),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 3,
            child: Text(
              objBillDetails.Email.toString(),
              maxLines: 5,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'Alatsi',
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Text(
              objBillDetails.Command.toString(),
              textAlign: TextAlign.justify,
              maxLines: 6,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'Alatsi',
              ),
            ),
          )
        ],
      ),
    );
  }

  Future<bool> _onBackPressed() async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: const Text(
            "Confirm",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          content: const Text("Are you Sure you want to Exit?"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            // ignore: deprecated_member_use
            FlatButton(
              child: const Text(
                "No",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),

            // ignore: deprecated_member_use
            FlatButton(
              child: const Text(
                "Yes",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              onPressed: () {
                SystemNavigator.pop();
              },
            ),
          ],
        );
      },
    );
    return false;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(
          children: [
            Container(
              height: size.height * 0.2,
              decoration: const BoxDecoration(color: Color(0xff1a237e), borderRadius: BorderRadius.only(bottomLeft: Radius.circular(36), bottomRight: Radius.circular(36))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                      flex: 3,
                      // ignore: avoid_unnecessary_containers
                      child: Container(
                        child: const Text(
                          "Hi User !!!\nWelcome You All...",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 25.00, fontWeight: FontWeight.bold, color: Colors.white, letterSpacing: 2.0),
                        ),
                      )),
                  Expanded(
                      flex: 1,
                      child: IconButton(
                        icon: const Icon(
                          Icons.logout,
                          size: 35,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
                        },
                      ))
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              padding: const EdgeInsets.only(left: 20.0),
              alignment: Alignment.centerLeft,
              child: const Text(
                "What would you like to share with world ? ",
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 3,
                    child: Container(
                      padding: const EdgeInsets.only(left: 5),
                      height: 100.0,
                      // width: 10,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.brown,
                          // width: 5,
                        ),
                      ),
                      child: TextFormField(
                        controller: txtcmd,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: "  Place Your Command Here.... ",
                        ),
                        minLines: 1,
                        maxLines: 5,
                        // controller: txtremark,
                        keyboardType: TextInputType.multiline,
                        textInputAction: TextInputAction.next,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    flex: 1,
                    child: ElevatedButton(
                      child: const Text(
                        'SUBMIT',
                        style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                      ),
                      onPressed: () {
                        savecommand().then((value) => setState(() {
                              startup();
                            }));
                      },
                      style: ElevatedButton.styleFrom(
                          primary: const Color(0xff1a237e),
                          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                          textStyle: const TextStyle(letterSpacing: 2, color: Colors.black, fontSize: 12, fontWeight: FontWeight.bold, fontFamily: 'OpenSans')),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              padding: const EdgeInsets.all(10.0),
              decoration: const BoxDecoration(
                color: Colors.indigo,
                borderRadius: BorderRadius.vertical(top: Radius.circular(30), bottom: Radius.circular(30)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Comments ",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25, color: Colors.white),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  ElevatedButton(
                    child: const Text(
                      'Filter',
                      style: TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                    onPressed: () {
                      startupbyid().then((value) => setState(() {}));
                    },
                    style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                        textStyle: const TextStyle(letterSpacing: 2, color: Colors.black, fontSize: 12, fontWeight: FontWeight.bold, fontFamily: 'OpenSans')),
                  ),
                  // ignore: avoid_unnecessary_containers
                  Container(
                    child: IconButton(
                      icon: const Icon(
                        Icons.refresh,
                        size: 25,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        startup().then((value) => setState(() {}));
                      },
                    ),
                  )
                ],
              ),
            ),
            Container(
              height: (MediaQuery.of(context).size.height - 520),
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Column(children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.indigo,
                        borderRadius: BorderRadius.vertical(top: Radius.circular(10), bottom: Radius.circular(10)),
                      ),
                      padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                      height: 10,
                      // color: Colors.indigo,
                      child: loadgridheader(),
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: dbHelper.commentslist.isNotEmpty
                        // ignore: avoid_unnecessary_containers
                        ? Container(
                            padding: const EdgeInsets.all(10.0),
                            // height: (MediaQuery.of(context).size.height - 350),
                            // height: 100,
                            child: GridView.count(
                              crossAxisCount: 1,
                              shrinkWrap: true,
                              primary: false,
                              crossAxisSpacing: 2,
                              mainAxisSpacing: 6,
                              childAspectRatio: 9,
                              scrollDirection: Axis.vertical,
                              children: List.generate(dbHelper.commentslist.length, (index) {
                                return loadBillDetailsGrid(dbHelper.commentslist[index]);
                              }),
                            ))
                        : const SizedBox(
                            height: 60,
                            // height: (screenHeight - 350),
                            child: Center(
                              child: Text('No Record'),
                            ),
                          ),
                  )
                ]),
              ),
            )
          ],
        ),
      ),
    );
  }
}
