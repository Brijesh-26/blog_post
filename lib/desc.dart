import 'package:flutter/material.dart';

class Desc extends StatefulWidget {
  String desc;
  Desc({required this.desc});

  @override
  State<Desc> createState() => _DescState();
}

class _DescState extends State<Desc> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('dummy app bar'),
      ),
      body: Center(child: Text(widget.desc)),
    );
  }
}
