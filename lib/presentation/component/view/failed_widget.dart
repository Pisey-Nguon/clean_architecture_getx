import 'package:flutter/material.dart';

import '../../../domain/entities/response/error_response.dart';

class FailedWidget extends StatelessWidget {
  final Function() retry;
  final ErrorResponse errorResponse;
  const FailedWidget({Key? key,required this.retry, required this.errorResponse}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(errorResponse.error),
        ElevatedButton(onPressed: retry, child: const Text("Retry"))
      ],
    ),);
  }
}
