import 'package:clean_architecture_getx/base/base_result.dart';
import 'package:clean_architecture_getx/presentation/component/view/failed_widget.dart';
import 'package:clean_architecture_getx/presentation/component/view/load_page_widget.dart';
import 'package:clean_architecture_getx/presentation/component/view/no_internet_widget.dart';
import 'package:clean_architecture_getx/presentation/component/view/something_went_wrong_widget.dart';
import 'package:flutter/material.dart';

import '../../../domain/entities/response/error_response.dart';

class StateViewBuilder<T> extends StatelessWidget{

  final T result;
  final Function() retry;
  final Widget? loadingWidget;
  final Widget Function(T result) successWidget;
  final Widget Function(ErrorResponse errorResponse)? failedWidget;

  const StateViewBuilder({super.key,required this.result,required this.retry,this.loadingWidget,required this.successWidget, this.failedWidget});

  @override
  Widget build(BuildContext context) {
    var data = result as BaseResult;
    if(data.requestStatus == null){
      if(loadingWidget != null){
        return loadingWidget!;
      }else{
        return const LoadPageWidget();
      }
    }else{
      switch(data.requestStatus!){
        case RequestStatus.success:
          return successWidget.call(result);
        case RequestStatus.noInternet:
          return NoInternetWidget(retry: retry);
        case RequestStatus.failed:
          if(data.errorResponse != null){
            return FailedWidget(retry: retry, errorResponse: data.errorResponse!);
          }else{
            return SomethingWentWrongWidget(retry: retry);
          }
        case RequestStatus.somethingWentWrong:
          return SomethingWentWrongWidget(retry: retry);
      }
    }

  }


}