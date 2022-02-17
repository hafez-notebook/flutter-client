import 'package:flutter/material.dart';
import 'package:hafez/Pages/notes.dart';
import 'package:hafez/Pages/settings.dart';
import 'package:hafez/Pages/connectionFailed.dart';
import 'package:hafez/Pages/login.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hafez/db.dart';
import 'package:hafez/utils.dart' as utils;

class DB {
  static void initHive() async {
    await Hive.initFlutter();
    Hive.registerAdapter(NoteAdapter());
  }
}

Future<Widget> checkLogin() async {
  await Hive.initFlutter();
  var box = await Hive.openBox("userdata");
  if (box.get("username") == null ||
      box.get("password") == null ||
      box.get("username") == "" ||
      box.get("password") == "") {
    return const HafezLoginPage();
  } else {
    var username = box.get("username");
    var password = box.get("password");
    var login = await utils.login(username, password);
    if (login == 1) {
      return const HafezHomePage();
    } else if (login == 2) {
      return const HafezLoginPage();
    } else {
      return const HafezConnectionFailedPage();
    }
  }
}

void main() async {
  runApp(MaterialApp(
    localizationsDelegates: const [
      GlobalCupertinoLocalizations.delegate,
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
    ],
    supportedLocales: const [
      Locale("fa", "IR"),
    ],
    locale: const Locale("fa", "IR"),
    home: await checkLogin(),
    theme: ThemeData(fontFamily: "Vazir"),
    debugShowCheckedModeBanner: false,
  ));
}

class HafezHomePage extends StatefulWidget {
  const HafezHomePage({Key? key}) : super(key: key);

  @override
  _HafezHomePageState createState() => _HafezHomePageState();
}

class _HafezHomePageState extends State<HafezHomePage> {
  int _currentIndex = 0;
  static const pagesList = [
    HafezSettingsPage(),
    HafezNotesPage(),
  ];
  var pagesName = ["تنظیمات", "خانه"];
  void _changeScreen(index) {
    if (index != _currentIndex) {
      setState(() {
        _currentIndex = index;
      });
    }
  }

  Widget home() {
    return pagesList[_currentIndex];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(pagesName[_currentIndex]),
        centerTitle: true,
      ),
      body: home(),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: "تنظیمات"),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "خانه"),
        ],
        currentIndex: _currentIndex,
        onTap: _changeScreen,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.black,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
