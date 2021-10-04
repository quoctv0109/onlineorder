import 'package:flutter/material.dart';
import 'package:onlineorder/page_app_theme.dart';

class AppBarView extends StatelessWidget {
  const AppBarView({
    Key? key,
    required this.topBarOpacity,
    required this.context,
    required this.titleBar,
  }) : super(key: key);

  final double topBarOpacity;
  final BuildContext context;
  final String titleBar;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            color: PageAppTheme.nearlyDarkBlue.withOpacity(topBarOpacity),
            border: Border.all(color: PageAppTheme.dart_border_bar),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: PageAppTheme.grey
                      .withOpacity(0.4 * topBarOpacity),
                  offset: const Offset(1.1, 1.1),
                  blurRadius: 10.0),
            ],
          ),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: MediaQuery.of(context).padding.top,
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: 16,
                    right: 16,
                    top: 16 - 8.0 * topBarOpacity,
                    bottom: 12 - 8.0 * topBarOpacity),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          titleBar,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: PageAppTheme.fontName,
                            fontWeight: FontWeight.w700,
                            fontSize: 22 + 6 - 6 * topBarOpacity,
                            letterSpacing: 1.2,
                            color: PageAppTheme.darkerText,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}