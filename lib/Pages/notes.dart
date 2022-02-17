import 'package:flutter/material.dart';

class HafezNotesPage extends StatefulWidget {
  const HafezNotesPage({Key? key}) : super(key: key);

  @override
  _HafezNotesPageState createState() => _HafezNotesPageState();
}

class _HafezNotesPageState extends State<HafezNotesPage> {
  @override
  Widget build(BuildContext context) {
    return Container(child: const Center(child: Text("یادداشت ها")));
  }
}
