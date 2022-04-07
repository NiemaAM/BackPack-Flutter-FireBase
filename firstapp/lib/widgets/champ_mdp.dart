// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

// ignore: camel_case_types
class champMdp extends StatelessWidget {
  const champMdp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const TextField(
      obscureText: true,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.password),
        border: OutlineInputBorder(),
      ),
    );
  }
}
