import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:onlineorder/models/character_summary.dart';
import 'package:onlineorder/remote_api.dart';
import 'package:onlineorder/ui_view/character_list_item_Order.dart';
import 'package:onlineorder/ui_view/character_search_input_sliver.dart';


class ListViewOrder extends StatefulWidget {
  const ListViewOrder({Key? key}) : super(key: key);

  @override
  _ListViewOrderState createState() => _ListViewOrderState();
}

class _ListViewOrderState extends State<ListViewOrder> {
  static const _pageSize = 17;

  final PagingController<int, CharacterSummary> _pagingController =
  PagingController(firstPageKey: 0);

  String? _searchTerm;

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });

    _pagingController.addStatusListener((status) {
      if (status == PagingStatus.subsequentPageError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text(
              'Something went wrong while fetching a new page.',
            ),
            action: SnackBarAction(
              label: 'Retry',
              onPressed: () => _pagingController.retryLastFailedRequest(),
            ),
          ),
        );
      }
    });
    super.initState();
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final newItems = await RemoteApi.getCharacterList(
        pageKey,
        _pageSize,
        searchTerm: _searchTerm,
      );

      final isLastPage = newItems.length < _pageSize;
      if (isLastPage) {
        _pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + newItems.length;
        _pagingController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }
  @override
  Widget build(BuildContext context) => CustomScrollView(
    slivers: <Widget>[
      CharacterSearchInputSliver(
        onChanged: (searchTerm) => _updateSearchTerm(searchTerm),
        searchName: "Đơn hàng",
      ),
      PagedSliverList<int, CharacterSummary>(
        pagingController: _pagingController,
        builderDelegate: PagedChildBuilderDelegate<CharacterSummary>(
          animateTransitions: true,
          itemBuilder: (context, item, index) => Column(
            children: <Widget>[
              CharacterListItemOrder(
                character: item,
              ),
              Divider(), //                           <-- Divider
            ],
          ),
        ),
      ),
    ],
  );

  void _updateSearchTerm(String searchTerm) {
    _searchTerm = searchTerm;
    _pagingController.refresh();
  }


  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }
}


