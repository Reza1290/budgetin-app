import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:permission_handler/permission_handler.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;
  MyHomePage({Key? key, required this.title}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  Future<void> _generateCsvFile() async {
    if (await Permission.storage.isGranted) {
      _createCsvFile();
    } else {
      PermissionStatus status = await Permission.storage.request();
      if (status.isGranted) {
        _createCsvFile();
      } else {
        _showPermissionDeniedDialog();
      }
    }
  }

  Future<void> _createCsvFile() async {
    List<Map<String, dynamic>> associateList = [
      {"number": 1, "lat": "14.97534313396318", "lon": "101.22998536005622"},
      {"number": 2, "lat": "14.97534313396318", "lon": "101.22998536005622"},
      {"number": 3, "lat": "14.97534313396318", "lon": "101.22998536005622"},
      {"number": 4, "lat": "14.97534313396318", "lon": "101.22998536005622"}
    ];

    List<List<dynamic>> rows = [];

    List<dynamic> header = ["number", "latitude", "longitude"];
    rows.add(header);

    for (var associate in associateList) {
      List<dynamic> row = [];
      row.add(associate["number"]);
      row.add(associate["lat"]);
      row.add(associate["lon"]);
      rows.add(row);
    }

    String csv = const ListToCsvConverter().convert(rows);

    Directory? dir = await getExternalStorageDirectory();
    String path = dir?.path ?? "";
    String file = "$path/filename.csv";

    File f = File(file);
    await f.writeAsString(csv);

    setState(() {
      _counter++;
    });

    print("CSV file saved at: $file");
  }

  void _showPermissionDeniedDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Permission Denied"),
          content: Text("Storage permission is required to save the CSV file. Please enable it in the app settings."),
          actions: <Widget>[
            TextButton(
              child: Text("Open Settings"),
              onPressed: () async {
                Navigator.of(context).pop();
                await openAppSettings();
              },
            ),
            TextButton(
              child: Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('You have pushed the button this many times:'),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _generateCsvFile,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
