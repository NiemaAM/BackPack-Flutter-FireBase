// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

import '../pages/page_choix_jeux_langues.dart';

// ignore: camel_case_types
class menueInfos extends StatelessWidget {
  const menueInfos({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(
        Icons.info,
        color: Colors.white,
      ),
      onPressed: () {
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const pageLanguesChoix()));
      },
    );
  }
}
