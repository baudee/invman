import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:invman_flutter/config/generated/l10n.dart';
import 'package:invman_flutter/core/components/base/error_component.dart';
import 'package:invman_flutter/core/components/base/loading_component.dart';

PagedChildBuilderDelegate<T> pagedChildBuilderDelegate<T>({
  required Widget Function(BuildContext context, T item, int index) itemBuilder,
  required PagingController<int, T> pagingController,
  String? noItemsFoundMessage,
}) {
  return PagedChildBuilderDelegate<T>(
    itemBuilder: itemBuilder,
    firstPageErrorIndicatorBuilder: (context) {
      return ErrorComponent(
        error: S.of(context).error_code(pagingController.error),
        handleRefresh: pagingController.refresh,
      );
    },
    noItemsFoundIndicatorBuilder: (context) =>
        Center(child: Text(noItemsFoundMessage ?? S.of(context).core_noItemsFound)),
    firstPageProgressIndicatorBuilder: (context) => LoadingComponent(),
    newPageProgressIndicatorBuilder: (context) => LoadingComponent(),
  );
}
