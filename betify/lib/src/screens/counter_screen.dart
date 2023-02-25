import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../blocs/counter_bloc.dart';
import '../widgets/bottom_navigation.dart';

class CounterScreen extends StatefulWidget {
  final String _title;
  final CounterBloc counterBloc;
  const CounterScreen({required String title, required this.counterBloc, Key? key}) : _title = title, super(key: key);

  @override
  CounterScreenState createState() => CounterScreenState();
}

class CounterScreenState extends State<CounterScreen> {
  //CounterBloc counterBloc;

  @override
  void didChangeDependencies() {
    //counterBloc = CounterBlocProvider.of(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Welcome in ${widget._title}, lets increment numbers!',
              textDirection: TextDirection.ltr,
              style: const TextStyle(fontSize: 15.0)
            ),
            StreamBuilder(
              stream: widget.counterBloc.counterStream,
              builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
                if (snapshot.hasData) {
                  return Text(
                    'Counter: ${snapshot.data}',
                    textDirection: TextDirection.ltr,
                    style: const TextStyle(fontSize: 30.0)
                  );
                } else {
                  return const Text(
                    'Counter is sad :( No data',
                    textDirection: TextDirection.ltr,
                    style: TextStyle(fontSize: 30.0)
                  );
                }
              },
            ),
            ElevatedButton(
              child: StreamBuilder(
                stream: widget.counterBloc.counterStream,
                builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
                  if (snapshot.hasData) {
                    return Text('Counter - ${snapshot.data}');
                  } else {
                    return const Text('Counter is sad :(');
                  }
                },
              ),
              onPressed: () => context.go('/'),
            )
          ],
        )
      ),
      bottomNavigationBar: BottomNavigation(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => widget.counterBloc.increment(15),
        tooltip: 'Increment',
        child: const Icon(Icons.add)
      ),
      appBar: AppBar(title: Text(widget._title)),
    );
  }
}