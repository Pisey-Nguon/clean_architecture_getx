import 'package:clean_architecture_getx/base/base_result.dart';
import 'package:flutter/material.dart';

class FailedWidget extends StatelessWidget {
  final Function() retry;
  final ErrorResponse errorResponse;
  const FailedWidget({Key? key,required this.retry, required this.errorResponse}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(child: Column(
      children: [
        Text(errorResponse.error),
        ElevatedButton(onPressed: retry, child: const Text("Retry"))
      ],
    ),);
  }
}
