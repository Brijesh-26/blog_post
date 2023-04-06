import 'package:flutter/material.dart';


class Desc extends StatefulWidget {
  const Desc({super.key});

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

      body: Center(child: Text('here you will see description of post')),
    );
  }
}