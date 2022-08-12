import 'package:flutter/material.dart';

class NoInternetWidget extends StatelessWidget {
  final Function() retry;
  const NoInternetWidget({Key? key,required this.retry}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("No internet"),
        ElevatedButton(onPressed: retry, child: const Text("Retry"))
      ]
    ),);
  }
}
