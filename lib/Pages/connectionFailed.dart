import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HafezConnectionFailedPage extends StatelessWidget {
  const HafezConnectionFailedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("حافظ"),
        centerTitle: true,
      ),
      body: AlertDialog(
        backgroundColor: Colors.black,
        content: const Text(
            "مشکلی در برقرای ارتباط با سرور به وجود آمده است لطفا از اتصال اینترنت خود اطمینان حاصل کنید."),
        actions: [
          TextButton(
              onPressed: () {
                SystemChannels.platform
                    .invokeMethod<void>("SystemNavigator.pop");
              },
              child: const Text("باشه"))
        ],
      ),
    );
  }
}
