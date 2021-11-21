import 'package:flutter/material.dart';
import 'package:value_client/resources/index.dart';
import 'package:value_client/widgets/index.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AppList extends StatefulWidget {
  final bool loadingListItems;
  final bool hasReachedEndOfResults;
  final bool endLoadingFirstTime;
  final List<dynamic> listItems;
  final Widget Function(BuildContext context, int index) itemBuilder;
  final void Function(Map<String, dynamic> quray) fetchPageData;

  final WidgetBuilder? emptyBuilder;
  final Color? loadingColor;

  const AppList({
    Key? key,
    required this.loadingListItems,
    required this.hasReachedEndOfResults,
    required this.endLoadingFirstTime,
    required this.listItems,
    required this.itemBuilder,
    required this.fetchPageData,
    this.emptyBuilder,
    this.loadingColor,
  }) : super(key: key);

  @override
  _AppListState createState() => _AppListState();
}

class _AppListState extends State<AppList> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    widget.fetchPageData({});
  }

  Future refreshData() async {
    debugPrint('refresh data +++===============');
    await Future.delayed(Duration(milliseconds: 1000));
    widget.fetchPageData({'loadMore': true});
  }

  @override
  Widget build(BuildContext context) {
    if (widget.loadingListItems) {
      return AppLoading(
        color: widget.loadingColor ?? AppColors.primaryL,
      );
    } else if (widget.listItems.isEmpty && widget.endLoadingFirstTime) {
      debugPrint('====== empty ');
      if (widget.emptyBuilder != null) {
        return widget.emptyBuilder!(context);
      } else {
        return _emptyBuilder();
      }
    } else {
      return RefreshIndicator(
        backgroundColor: AppColors.primaryL,
        color: AppColors.white,
        onRefresh: refreshData,
        child: NotificationListener<ScrollNotification>(
          onNotification: _handleScrollNotification,
          child: ListView.separated(
            physics: BouncingScrollPhysics(),
            shrinkWrap: true,
            controller: _scrollController,
            itemCount: calculateListItemCount(),
            separatorBuilder: separatorBuilder,
            itemBuilder: (context, index) {
              return index >= widget.listItems.length
                  ? _buildLoaderListItem()
                  : widget.itemBuilder(context, index);
            },
          ),
        ),
      );
    }
  }

  bool _handleScrollNotification(ScrollNotification notification) {
    if (notification is ScrollEndNotification &&
        _scrollController.position.extentAfter == 0 &&
        !widget.hasReachedEndOfResults) {
      debugPrint('is buttom ====== ');
      widget.fetchPageData({'loadMore': true});
    }

    return false;
  }

  int calculateListItemCount() {
    if (widget.hasReachedEndOfResults || !widget.endLoadingFirstTime) {
      return widget.listItems.length;
    } else {
      // + 1 for the loading indicator
      return widget.listItems.length + 1;
    }
  }

  Widget _buildLoaderListItem() {
    return AppLoading(
      color: AppColors.red,
    );
    // if (!widget.hasReachedEndOfResults)
    //   return AppLoading(
    //     color: AppColors.primaryL,
    //   );
    // else
    //   return Center(child: Text('Nothing more to load'));
  }

  Widget _emptyBuilder() {
    return Center(
      child: Text(AppLocalizations.of(context)!.no_data),
    );
  }
}
