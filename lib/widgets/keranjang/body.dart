import 'package:flutter/material.dart';
import 'package:finalproject/widgets/keranjang/keranjang_body.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(children: const [Expanded(child: KeranjangBody())]);
  }
}
