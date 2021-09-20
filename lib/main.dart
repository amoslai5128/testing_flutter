import './local_storage.dart';

import 'package:flutter/material.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

import 'state.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await RM.storageInitializer(SharedPreferencesStore());

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo CRUD Persistence'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final String title;
  const MyHomePage({Key? key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                  onPressed: () async {
                    // Fetch data from CRUD (Online)
                    await testOrderCRUD.crud.read();
                    testOrderCRUD.persistState();
                  },
                  child: const Text('Fetch Online Data ')),
              ElevatedButton(
                  onPressed: () {
                    // Refresh the state
                    testOrderCRUD.refresh();
                  },
                  child: const Text('Refresh & Query from LocalDB')),
              ElevatedButton(
                  onPressed: () {
                    // Delete the cache from localDB
                    testOrderCRUD.deletePersistState();
                  },
                  child: const Text('Delete Cache')),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: OnCRUDBuilder(
                  listenTo: testOrderCRUD,
                  onWaiting: () => const Center(child: CircularProgressIndicator()),
                  onResult: (_) {
                    final List<ListTile> listOfResult = testOrderCRUD.state
                        .map((order) =>
                            ListTile(title: Text(order?.id ?? 'NO ID'), subtitle: Text(order?.orderName ?? 'NO NAME')))
                        .toList();
                    return Column(children: listOfResult);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
