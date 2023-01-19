import 'package:flutter/material.dart';

class AppStore extends StatefulWidget {
  final Widget child;

  AppStore({required Widget this.child});

  @override
  _AppStoreState createState() => _AppStoreState();

  static of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<_InhertitedAppState>()!.data;
  }
}



class _AppStoreState extends State<AppStore> {
  String testingData = 'Testing data (:';
  String testingData2 = 'Testing data2 (:';
  String testingData3 = 'Testing data3 (:';

  @override
  Widget build(BuildContext context) {
    return _InhertitedAppState(
      child: widget.child,
      data: this
    );
  }
}



class _InhertitedAppState extends InheritedWidget {
  final _AppStoreState data;

  _InhertitedAppState({required Widget child, required this.data}) : super(child: child);

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => true;
}