import 'package:flutter/material.dart';

class LoadPageWidget extends StatelessWidget {
  const LoadPageWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator(),);
  }
}
