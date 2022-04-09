// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

// ignore: camel_case_types
class retour extends StatelessWidget {
  final Color color;
  const retour({Key key, this.color = Colors.white}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(
        Icons.arrow_back,
        color: Colors.black,
        size: 50,
      ),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
  }
}
