import 'package:flutter/material.dart';
import 'package:slidable_dismissible_test/view/product_view.dart';
import 'data/product_data.dart';

// referensi:
// https://stackoverflow.com/questions/70573686/how-to-make-tap-to-open-slidable-using-flutter-slidable-package
// https://github.com/letsar/flutter_slidable/issues/167
// https://github.com/letsar/flutter_slidable/issues/31
// https://stackoverflow.com/questions/54303001/flutter-listview-delete-and-undo-operation
// https://stackoverflow.com/questions/61475025/how-to-allow-only-one-slidable-at-a-time-to-be-open
// https://stackoverflow.com/questions/12649573/how-do-you-build-a-singleton-in-dart
// https://www.youtube.com/watch?v=81nbfr37oxg

late ProductData prodData;
final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Slidable and Dismissible test'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  void initState() {
    super.initState();
    prodData = ProductData();
  }
  
  @override
  void dispose() {
    
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Center(child: Text(widget.title)),
      ),
      body: const ProductsView(),
    );
  }
}
