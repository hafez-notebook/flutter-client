import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:hafez/main.dart' show HafezHomePage;
import 'package:hafez/utils.dart' as utils;

class HafezLoginPage extends StatefulWidget {
  const HafezLoginPage({Key? key}) : super(key: key);

  @override
  _HafezLoginPageState createState() => _HafezLoginPageState();
}

class _HafezLoginPageState extends State<HafezLoginPage> {
  var username;
  var password;
  bool isLoading = false;

  void loginfunc() async {
    await Hive.initFlutter();
    var login = await utils.login(username, password);
    setState(() {
      isLoading = false;
    });
    if (login == 1) {
      Navigator.pop(context);
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const HafezHomePage()));
    } else if (login == 2) {
      utils.showSnackBar(context, "اطلاعات وارد شده نادرست است.");
    } else {
      utils.showSnackBar(
          context, "مشکلی در برقرای ارتباط با کارساز وجود دارد.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("ورود"),
          centerTitle: true,
        ),
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("اطلاعات خود را وارد کنید",
                style: TextStyle(fontSize: 16)),
            Padding(
                padding: const EdgeInsets.only(
                    right: 15, left: 15, bottom: 5, top: 15),
                child: TextField(
                  onChanged: (inputUsername) {
                    setState(() {
                      username = inputUsername;
                    });
                  },
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), hintText: "نام کاربری"),
                )),
            Padding(
                padding: const EdgeInsets.only(left: 15, right: 15, bottom: 5),
                child: TextField(
                  obscureText: true,
                  onChanged: (inputPassword) {
                    setState(() {
                      password = inputPassword;
                    });
                  },
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), hintText: "رمز عبور"),
                )),
            Padding(
                padding: const EdgeInsets.only(top: 15, bottom: 10),
                child: ElevatedButton(
                    onPressed: () {
                      if (username == "" ||
                          password == "" ||
                          username == null ||
                          password == null) {
                        utils.showSnackBar(
                            context, "لطفا تمام فیلد ها را پر کنید");
                      } else {
                        setState(() {
                          isLoading = true;
                        });
                        loginfunc();
                      }
                    },
                    child: isLoading
                        ? const SizedBox(
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                            width: 20,
                            height: 20,
                          )
                        : const Text(
                            "ورود",
                            style: TextStyle(fontSize: 16),
                          ),
                    style: TextButton.styleFrom(
                        primary: Colors.white, backgroundColor: Colors.green))),
            TextButton(
                onPressed: () async {
                  const signupUrl = "http://hafeznote.ir";
                  if (await canLaunch(signupUrl)) {
                    launch(signupUrl);
                  }
                },
                child: const Text("حسابی ندارید؟ ثبت نام کنید")),
          ],
        )));
  }
}
