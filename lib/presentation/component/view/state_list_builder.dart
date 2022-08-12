import 'package:clean_architecture_getx/base/base_result.dart';
import 'package:clean_architecture_getx/presentation/component/view/failed_widget.dart';
import 'package:clean_architecture_getx/presentation/component/view/load_more_failed_widget.dart';
import 'package:clean_architecture_getx/presentation/component/view/load_more_widget.dart';
import 'package:clean_architecture_getx/presentation/component/view/load_page_widget.dart';
import 'package:clean_architecture_getx/presentation/component/view/no_internet_widget.dart';
import 'package:clean_architecture_getx/presentation/component/view/something_went_wrong_widget.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import 'empty_list_widget.dart';

class StateListBuilder<TItem> extends StatelessWidget {
  final List<TItem>? items;
  final PagingController<int,TItem> pagingController;
  final Widget Function(BuildContext context,TItem item,int index) itemBuilder;

  const StateListBuilder({super.key,required this.items,required this.pagingController,required this.itemBuilder});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: ()=> Future.sync(
          (){
            pagingController.nextPageKey = 0;
            pagingController.refresh();
          }
      ),
      child: PagedListView<int,TItem>(
          pagingController: pagingController,
          builderDelegate: PagedChildBuilderDelegate(
            itemBuilder: itemBuilder,
            firstPageErrorIndicatorBuilder: (_) {
              var result = pagingController.error as BaseResult;
              if(result.requestStatus == RequestStatus.failed){
                return FailedWidget(retry: (){
                  pagingController.refresh();
                }, errorResponse: result.errorResponse!);
              }else if(result.requestStatus == RequestStatus.somethingWentWrong){
                return SomethingWentWrongWidget(retry:(){
                  pagingController.refresh();
                });
              }else if(result.requestStatus == RequestStatus.noInternet){
                return NoInternetWidget(retry: (){
                  pagingController.refresh();
                });
              }else{
                return const SizedBox();
              }
            },
            newPageErrorIndicatorBuilder: (_) => LoadMoreFailedWidget(retry: (){
              pagingController.retryLastFailedRequest();
            }),
            firstPageProgressIndicatorBuilder: (_) => const LoadPageWidget(),
            newPageProgressIndicatorBuilder: (_) => const LoadMoreWidget(),
            noItemsFoundIndicatorBuilder: (_) => const EmptyListWidget(),
            noMoreItemsIndicatorBuilder: (_) => const SizedBox(),
          )
      ),
    );
  }
}
