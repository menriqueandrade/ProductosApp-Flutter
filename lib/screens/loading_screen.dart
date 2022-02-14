// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, duplicate_ignore

import 'package:flutter/material.dart';

class LoadingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Products'),
      ),
      // ignore: prefer_const_constructors
      body: Center(
        child: CircularProgressIndicator(
          color: Colors.indigo,
        )
      ),
    );
  }
}
