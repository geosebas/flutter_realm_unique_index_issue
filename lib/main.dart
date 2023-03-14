import 'package:flutter/material.dart';
import 'package:realm/realm.dart';

import 'event.dart';

const appId = 'your-app-id';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool loading = false;
  String? error;

  void _incrementCounter() async {
    setState(() {
      loading = true;
      error = null;
    });
    try {
      final app = App(AppConfiguration(appId));
      final user = await app.logIn(Credentials.anonymous());
      final config = Configuration.flexibleSync(user, [SomeEvent.schema]);
      final realm = Realm(config);
      // Add subscription to sync all Car objects in the realm
      realm.subscriptions.update((mutableSubscriptions) {
        mutableSubscriptions.add(realm.all<SomeEvent>());
      });
      // Sync all subscriptions
      await realm.subscriptions.waitForSynchronization();
      final date = DateTime.now();
      final groupId = Uuid.v4().toString();
      final event1 = SomeEvent(Uuid.v4().toString(), groupId, date, 1, 'some info 1');
      final event2 = SomeEvent(Uuid.v4().toString(), groupId, date, 2, 'some info 2');
      final event3 = SomeEvent(Uuid.v4().toString(), groupId, date, 3, 'some info 3');
      realm.write(() => realm.addAll([event1, event2, event3]));
      await realm.syncSession.waitForUpload();

      await Future.delayed(const Duration(seconds: 1));

      realm.write(() {
        realm.deleteMany([event1, event2, event3]);
        final event4 = SomeEvent(Uuid.v4().toString(), groupId, date, 1, 'some info 1+');
        final event5 = SomeEvent(Uuid.v4().toString(), groupId, date, 2, 'some info 2+');
        final event6 = SomeEvent(Uuid.v4().toString(), groupId, date, 3, 'some info 3+');
        realm.addAll([event4, event5, event6]);
      });
      await realm.syncSession.waitForUpload();
    } on Exception catch (e) {
      setState(() {
        error = e.toString();
      });
    } finally {
      setState(() {
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: !loading
              ? [
                  const Text(
                    'Push the button to try bug',
                  ),
                ]
              : [CircularProgressIndicator()],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: loading ? null : _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
