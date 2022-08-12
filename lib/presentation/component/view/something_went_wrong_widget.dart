import 'package:flutter/material.dart';

class SomethingWentWrongWidget extends StatelessWidget {
  final Function() retry;
  const SomethingWentWrongWidget({Key? key,required this.retry}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(child: Column(
      children: [
        Text("Something went wrong"),
        ElevatedButton(onPressed: retry, child: Text("Retry"))
      ],
    ),);
  }
}
