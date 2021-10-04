import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'page_app_theme.dart';
import 'package:onlineorder/ui_view/list_view_order.dart';

class ListOrder extends StatelessWidget {
  const ListOrder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: PageAppTheme.background,
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          floatingActionButton: Padding(
            padding: const EdgeInsets.only(bottom: 60.0),
            child: FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () {
                pushNewScreen(context, screen: AddNewOrder());
              },
              backgroundColor: PageAppTheme.nearlyDarkBlue,
            ),
          ),
          appBar: AppBar(
            backgroundColor: PageAppTheme.nearlyDarkBlue,
            bottom: const TabBar(
              indicatorColor: Colors.white,
              tabs: [
                Tab(icon: Text("Đơn hàng")),
                Tab(icon: Text("Đang xử lý")),
                Tab(icon: Text("Đã giao")),
              ],
            ),
            title: const Center(child: Text('Đơn hàng')),
          ),
          body: TabBarView(
            children: [
              Container(
                  padding: EdgeInsets.only(
                    bottom: 62 + MediaQuery.of(context).padding.bottom,
                  ),
                  child: ListViewOrder()),
              Container(
                  padding: EdgeInsets.only(
                    bottom: 62 + MediaQuery.of(context).padding.bottom,
                  ),
                  child: ListViewOrder()),
              Container(
                  padding: EdgeInsets.only(
                    bottom: 62 + MediaQuery.of(context).padding.bottom,
                  ),
                  child: ListViewOrder())
            ],
          ),
        ),
      ),
    );
  }
}

class TitleAddProduct extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      color: Colors.white,
      height: 40,
      child: Row(
        children: <Widget>[
          Expanded(
            child: Align(
              alignment: Alignment.centerLeft,
              child: Container(),
            ),
          ),
          Expanded(
            flex: 3,
            child: Align(
              alignment: Alignment.center,
              child: Container(
                color: Colors.white,
                child: Text('Tìm kiếm sản phẩm',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
              ),
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.topRight,
              child: Container(
                width: 55,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Icon(Icons.close),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AddNewOrder extends StatelessWidget {
  final items = List<String>.generate(4, (i) => "Item $i");
  @override
  Widget build(BuildContext context) {
    return Container(
        color: PageAppTheme.background,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: PageAppTheme.nearlyDarkBlue,
            title: const Center(child: Text('Thêm đơn hàng')),
          ),
          body: Container(
            child: Column(
              children: [
                Expanded(child: ListView(
                  padding: const EdgeInsets.all(15),
                  children: [
                    Container(
                        child: Text("Người nhận",
                            style: TextStyle(fontWeight: FontWeight.bold))),
                    Container(
                        padding: const EdgeInsets.only(bottom: 15),
                        child: TextField(
                            style: TextStyle(
                              fontSize: 20.0,
                              height: 1,
                              color: Colors.black,
                            ),
                            decoration: InputDecoration(
                              isDense: true, // Added this
                            ))),
                    Container(
                        child: Text("Số điện thoại",
                            style: TextStyle(fontWeight: FontWeight.bold))),
                    Container(
                        padding: const EdgeInsets.only(bottom: 15),
                        child: TextField(
                            style: TextStyle(
                              fontSize: 20.0,
                              height: 1,
                              color: Colors.black,
                            ),
                            decoration: InputDecoration(
                              isDense: true, // Added this
                            ))),
                    Container(
                        child: Text("Địa chỉ",
                            style: TextStyle(fontWeight: FontWeight.bold))),
                    Container(
                        padding: const EdgeInsets.only(bottom: 15),
                        child: TextField(
                            style: TextStyle(
                              fontSize: 20.0,
                              height: 1,
                              color: Colors.black,
                            ),
                            decoration: InputDecoration(
                              isDense: true, // Added this
                            ))),
                    Container(
                        child: Text("Email",
                            style: TextStyle(fontWeight: FontWeight.bold))),
                    Container(
                        padding: const EdgeInsets.only(bottom: 0),
                        child: TextField(
                            style: TextStyle(
                              fontSize: 20.0,
                              height: 1,
                              color: Colors.black,
                            ),
                            decoration: InputDecoration(
                              isDense: true, // Added this
                            ))),
                    Row(
                      children: [
                        Expanded(
                            child: Container(
                                padding: const EdgeInsets.only(top: 10),
                                child: FlatButton(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.search),
                                      SizedBox(width: 10),
                                      Center(child: Text("Tìm sản phẩm"))
                                    ],
                                  ),
                                  onPressed: () {
                                    showModalBottomSheet(
                                        context: context,
                                        backgroundColor: Colors.transparent,
                                        isScrollControlled: true,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10.0),
                                        ),
                                        builder: (context) => Container(
                                            height: 600,
                                            width: MediaQuery.of(context).size.width,
                                            padding: EdgeInsets.all(6),
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                BorderRadius.vertical(top: Radius.circular(20))),
                                            child: Column(
                                              children: <Widget>[
                                                TitleAddProduct(),
                                                Expanded(
                                                  child: Padding(
                                                    padding: const EdgeInsets.only(
                                                        bottom: 10, top: 10, left: 20, right: 20),
                                                    child: ListView(
                                                      children: [

                                                      ],
                                                    ),
                                                  ),
                                                )
                                              ],
                                            )));
                                  },
                                  color: PageAppTheme.nearlyDarkBlue,
                                  textColor: Colors.white,
                                ))),
                        Expanded(
                            child: Container(
                                padding: const EdgeInsets.only(top: 10, left: 10),
                                child: FlatButton(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.save),
                                      SizedBox(width: 10),
                                      Center(child: Text("Lưu"))
                                    ],
                                  ),
                                  onPressed: () {},
                                  color: PageAppTheme.nearlyDarkBlue,
                                  textColor: Colors.white,
                                )))
                      ],
                    )
                  ],
                )),
                if(items.length > 0)
                  Expanded(
                      child: ListView.builder(
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(0.0),//or 15.0
                          child: Container(
                            height: 100.0,
                            width: 80.0,
                            color: Colors.transparent,
                            child: Image.asset("assets/fitness_app/lavie.png", width: 100, height: 80),
                          ),
                        ),
                        title:
                        Row(children: [
                          Expanded(flex: 2, child: Text("Lavie")),
                          Expanded(child: Text("100.000đ", style: TextStyle(
                              fontWeight: FontWeight.bold))),
                        ]),
                        subtitle: Row(children: [
                          Expanded(
                            child: Text("5 x 20.000đ"),
                          )
                        ]) ,
                        onTap: () => {
                        },
                      );
                    },
                  )),
                if(items.length > 0)
                  Container(
                  padding: const EdgeInsets.all(9),
                  alignment: Alignment.centerRight,
                  child: Text("Tổng tiền: 500.000đ",  style: TextStyle(fontWeight: FontWeight.bold)))
              ],
            ),
          ),
        ));
  }
}

//Button add new product
Future<T?> pushNewScreen<T>(
  BuildContext context, {
  required Widget screen,
  bool? withNavBar,
  PageTransitionAnimation pageTransitionAnimation =
      PageTransitionAnimation.cupertino,
  PageRoute? customPageRoute,
}) {
  if (withNavBar == null) {
    withNavBar = true;
  }
  return Navigator.of(context, rootNavigator: !withNavBar).push<T>(
      customPageRoute as Route<T>? ??
          getPageRoute(pageTransitionAnimation, enterPage: screen));
}
