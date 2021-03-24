import 'package:flutter/material.dart';

class CustomPageRoute extends MaterialPageRoute {
  final Widget? previousPage;
  CustomPageRoute(
      {this.previousPage,
      required WidgetBuilder builder,
      RouteSettings? settings})
      : super(builder: builder, settings: settings);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget currentPage) {
    final Animation<Offset> _slideAnimationPage1 = Tween<Offset>(
            begin: const Offset(0.0, 0.0), end: const Offset(0.0, -1.0))
        .animate(animation);
    final Animation<Offset> _slideAnimationPage2 = Tween<Offset>(
            begin: const Offset(0.0, 0.0), end: const Offset(0.0, 0.0))
        .animate(animation);
    return Stack(
      children: <Widget>[
        SlideTransition(position: _slideAnimationPage1, child: previousPage),
        SlideTransition(position: _slideAnimationPage2, child: currentPage),
      ],
    );
  }
}
