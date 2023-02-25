import 'dart:async';

import 'package:flutter/cupertino.dart';

class CounterBloc {
  final StreamController<int> _streamController = StreamController<int>.broadcast();
  final StreamController<int> _counterController = StreamController<int>.broadcast();
  
  Stream<int> get counterStream => _counterController.stream;
  StreamSink<int> get counterSink => _counterController.sink;
  
  int _counter = 0;

  CounterBloc() {
    _streamController.stream
      .listen(_handleIncrement);
  }

  _handleIncrement(int number) {
    _counter += number;
    _counterController.sink.add(_counter);
  }

  increment(int incrementer) {
    _streamController.sink.add(incrementer);
  }

  dispose() {
    _streamController.close();
    _counterController.close();
  }
}

class CounterBlocProvider extends StatefulWidget {
  final CounterBloc bloc;
  final Widget child;

  CounterBlocProvider({Key? key, required this.child})
    : bloc = CounterBloc(),
      super(key: key); 

  @override
  State<StatefulWidget> createState() => CounterBlocProviderState();

  static CounterBloc of(BuildContext context) {
    return CounterBloc();
    //_CounterBlocProviderInherited? provider = context.dependOnInheritedElement<_CounterBlocProviderInherited>();

    //return provider.bloc;
  }
}

class CounterBlocProviderState extends State<CounterBlocProvider> {
  @override
  void dispose() {
    widget.bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _CounterBlocProviderInherited(
      bloc: widget.bloc,
      child: widget.child
    );
  }
}

class _CounterBlocProviderInherited extends InheritedWidget {
  final CounterBloc bloc;

  const _CounterBlocProviderInherited({required Widget child, required this.bloc, Key? key})
    : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  
}