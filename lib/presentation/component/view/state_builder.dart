import 'package:clean_architecture_getx/base/base_result.dart';
import 'package:flutter/material.dart';

class StateBuilder<T> extends StatelessWidget{

  final T result;
  final Widget? loadingWidget;
  final Widget Function(T result) successWidget;
  final Widget Function(ErrorResponse errorResponse) failedWidget;

  const StateBuilder({super.key,required this.result,this.loadingWidget,required this.successWidget, required this.failedWidget});

  @override
  Widget build(BuildContext context) {
    var data = result as BaseResult;
    switch(data.requestStatus){
      case RequestStatus.loading:
        return const Center(child: CircularProgressIndicator(),);
      case RequestStatus.success:
        return successWidget.call(result);
      case RequestStatus.noInternet:
        return const Center(child: Text("No internet"),);
      case RequestStatus.failed:
        if(data.errorResponse != null){
          return Center(child: Text(data.errorResponse!.error),);
        }else{
          return const Center(child: Text("Something went wrong"),);
        }
      case RequestStatus.somethingWentWrong:
        return const Center(child: Text("Something went wrong"),);
    }
  }


}