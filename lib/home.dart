import 'package:flutter/material.dart';
import 'package:onlineorder/ui_view/qr_view.dart';
import 'page_app_theme.dart';
import 'package:onlineorder/ui_view/title_view.dart';
import 'package:onlineorder/ui_view/order_view.dart';
import 'package:onlineorder/ui_view/appbar_view.dart';
import 'package:onlineorder/order.dart';

class Home extends StatefulWidget {
  const Home({Key? key, this.animationController}) : super(key: key);

  final AnimationController? animationController;

  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> with TickerProviderStateMixin {
  Animation<double>? topBarAnimation;
  double topBarOpacity = 0.0;
  final ScrollController scrollController = ScrollController();
  List<Widget> listViews = <Widget>[];

  @override
  void initState() {
    topBarAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
            parent: widget.animationController!,
            curve: Interval(0, 0.5, curve: Curves.fastOutSlowIn)));
    addAllListData();
  }

  void addAllListData() {
    const int count = 9;
    listViews.add(
      TitleView(
        titleTxt: 'Thống kê đơn hàng',
        subTxt: 'Details',
        animation: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: widget.animationController!,
            curve:
                Interval((1 / count) * 0, 1.0, curve: Curves.fastOutSlowIn))),
        animationController: widget.animationController!,
      ),
    );

    listViews.add(
      OrderView(
        animation: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: widget.animationController!,
            curve:
            Interval((1 / count) * 1, 1.0, curve: Curves.fastOutSlowIn))),
        animationController: widget.animationController!,
      ),
    );

    listViews.add(
      TitleView(
        titleTxt: 'Website bán hàng của bạn',
        subTxt: 'Details',
        animation: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: widget.animationController!,
            curve:
            Interval((1 / count) * 0, 1.0, curve: Curves.fastOutSlowIn))),
        animationController: widget.animationController!,
      ),
    );


    listViews.add(
      QrView(
        animation: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: widget.animationController!,
            curve:
            Interval((1 / count) * 1, 1.0, curve: Curves.fastOutSlowIn))),
        animationController: widget.animationController!,
      ),
    );

  }
  @override
  Widget build(BuildContext context) {
    return Container(
      color: PageAppTheme.background,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: PageAppTheme.nearlyDarkBlue,
          title: const Center(child: Text('Trang chủ')),
        ),
        body: getMainListViewUI(),
      ),
    );
  }

  Widget getMainListViewUI() {
    return FutureBuilder<bool>(
      future: getData(),
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        if (!snapshot.hasData) {
          return const SizedBox();
        } else {
          return ListView.builder(
            controller: scrollController,
            padding: EdgeInsets.only(
              top: 10
            ),
            itemCount: listViews.length,
            scrollDirection: Axis.vertical,
            itemBuilder: (BuildContext context, int index) {
              widget.animationController?.forward();
              return listViews[index];
            },
          );
        }
      },
    );
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 50));
    return true;
  }
}

