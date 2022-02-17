import 'dart:convert';
import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:dart_ipify/dart_ipify.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hafez/config.dart';

void showSnackBar(context, text) {
  var snackBar = SnackBar(
    content: Text("$text", style: const TextStyle(fontFamily: "Vazir")),
    behavior: SnackBarBehavior.floating,
    action: SnackBarAction(
      label: "باشه",
      onPressed: () {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
      },
    ),
  );
  ScaffoldMessenger.of(context).removeCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

Future login(username, password) async {
  var url = Uri.parse("$serverAdress/users/login/");
  try {
    var response = await post(url, headers: {
      'Accept': 'application/json',
      'Content-Type': 'application/x-www-form-urlencoded'
    }, body: {
      'username': username.toString(),
      'password': password.toString(),
      'ip': await getPublicIp(),
      "deviceName": Platform.localHostname.toString(),
    });
    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      if (body['Status'] == "SUCCESSED") {
        var userbox = await Hive.openBox("userbox");
        userbox.put("username", username);
        userbox.put("password", password);
        return 1;
      } else if (body['Status'] == "AUTHENTICATION_FAILED") {
        return 2;
      } else {
        return 0;
      }
    } else {
      return 0;
    }
  } catch (e) {
    return 0;
  }
}

Future<String> getPublicIp() async {
  final ip = await Ipify.ipv4();
  return ip;
}
