import 'package:flutter/material.dart';

class LoadMoreFailedWidget extends StatelessWidget {
  final Function() retry;
  const LoadMoreFailedWidget({Key? key,required this.retry}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(child: Padding(
      padding: const EdgeInsets.symmetric(vertical:10),
      child: Column(
        children: [
          const Text("Something went wrong"),
          IconButton(onPressed: retry, icon: const Icon(Icons.refresh))
        ],
      ),
    ),);
  }
}
