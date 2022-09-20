import 'package:dismissable_test/view/product_view.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_slidable/flutter_slidable.dart';
import 'data/product_data.dart';
// import 'model/product_model.dart';

// referensi:
// https://stackoverflow.com/questions/70573686/how-to-make-tap-to-open-slidable-using-flutter-slidable-package
// https://github.com/letsar/flutter_slidable/issues/167
// https://github.com/letsar/flutter_slidable/issues/31
// https://stackoverflow.com/questions/54303001/flutter-listview-delete-and-undo-operation
// https://stackoverflow.com/questions/61475025/how-to-allow-only-one-slidable-at-a-time-to-be-open
// https://stackoverflow.com/questions/12649573/how-do-you-build-a-singleton-in-dart

// final List<Product> productList = List.of(allProduct);
// late Product lastData;
// int deletedIndex = 0;

// final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
// ProductData prodData = ProductData();
late ProductData prodData;

void main() {
  prodData = ProductData();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('rendered in stateless');
    return MaterialApp(
      title: "Test Menggunakan Slidable & Dismissable",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: myHomePage(),
    );
  }
}

Widget myHomePage() {
  return Scaffold(
    key: prodData.scaffoldKey,
    appBar: AppBar(
      title: const Text("Slidable & Dismissable Test"),
      centerTitle: true,
    ),
    // body: appBody(),
    body: const ProductsView(),
  );
}

// -------------------------------- versi ori ------------------------------------
// Widget appBody() {
//     return StatefulBuilder(builder: (context, setState) {
//       return SlidableAutoCloseBehavior(
//         // ListView.Builder di bungkus SlidableAutoCloseBehavior supaya hanya single item yang aktif menunya
//         closeWhenOpened: true, // ketika menu delete sedang aktif, menu share & edit tidak langsung tampil ketika di tap
//         child: ListView.builder(
//           itemCount: productList.length,
//           scrollDirection: Axis.vertical,
//           shrinkWrap: true,
//           itemBuilder: (context, index) {
//             // hapus SlidableAutoCloseBehavior yang membungkus ListView.Builder
//             // dan pindahkan kesini (bungkus widget slidable) jika ingin membuat multiple menu yang aktif
//             return Slidable(
//               key: UniqueKey(),
//
//               startActionPane: ActionPane(
//                 motion: const ScrollMotion(),
//                 extentRatio: 0.25,
//                 dismissible: DismissiblePane(onDismissed: () {
//                   print('on dismissed');
//                   _removeProduct(index, setState);
//                 }),
//
//                 children: [
//                   SlidableAction(
//                     autoClose: false, // harus disertakan jika ingin ada efek animasi ketika menghapus list
//                     onPressed: (context) {
//                       print('Tombol delete ditekan');
//
//                       final slidable = Slidable.of(context);
//                       slidable?.dismiss(
//                         ResizeRequest(const Duration(milliseconds: 300), () {
//                           _removeProduct(index, setState);
//                         }),
//                       );
//                     },
//                     backgroundColor: const Color(0xFFFE4A49),
//                     foregroundColor: Colors.white,
//                     icon: Icons.delete,
//                     label: 'Delete',
//                   )
//                 ],
//               ),
//
//               endActionPane: ActionPane(
//                 motion: const ScrollMotion(),
//                 extentRatio: 0.5,
//                 children: [
//                   SlidableAction(
//                     onPressed: (context) {
//                       print('Tombol edit ditekan');
//                     },
//                     backgroundColor: Colors.blue,
//                     foregroundColor: Colors.white,
//                     icon: Icons.edit,
//                     label: 'Edit',
//                   ),
//
//                   SlidableAction(
//                     onPressed: (context) {
//                       print('Tombol share ditekan');
//                     },
//                     backgroundColor: Colors.green,
//                     foregroundColor: Colors.white,
//                     icon: Icons.share,
//                     label: 'Share',
//                   )
//                 ],
//               ),
//
//               child: buildListTile(index)
//             );
//           }),
//       );
//     });
//   }

// LayoutBuilder buildListTile(int index) {
//   // bool isOpen = true;
//   return LayoutBuilder(
//     builder: (layoutBuilderContext, constraints) {
//       return ListTile(
//         contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
//         leading: CircleAvatar(
//           child: Text('#${index + 1}'),
//         ),
//         title: Text(productList[index].name),
//         subtitle: Text('Rp.${productList[index].price.toString()}'),
//         onTap: () {
//           final slidable = Slidable.of(layoutBuilderContext);
//
//           // if (isOpen == true) {
//             slidable?.openEndActionPane(
//               duration: const Duration(milliseconds: 500),
//               curve: Curves.decelerate,
//             );
//           // } else {
//           //   slidable?.close(
//           //     duration: const Duration(milliseconds: 500),
//           //     curve: Curves.decelerate
//           //   );
//           // }
//
//           // isOpen = !isOpen;
//         },
//       );
//     },
//   );
// }

// _customSnackBar(String title, bool isRestoreData, Function setState) {
//   return SnackBar(
//     duration: const Duration(seconds: 5),
//     content: Text(title, style: const TextStyle(fontSize: 20),),
//     action: SnackBarAction(
//       label: isRestoreData ? 'UNDO' : 'CLOSE',
//       onPressed: () {
//         if (isRestoreData) {
//           _restoreProduct(setState);
//           print('new product list length: ${productList.length}');
//         }
//       }
//     ),
//   );
// }

// _showCustomSnackBar(title, BuildContext context, bool isRestoreData, Function setState) {
//   return ScaffoldMessenger.of(context).showSnackBar(_customSnackBar(title, isRestoreData, setState));
// }

// void _removeProduct(int index, Function setState) {
//   if (productList.isNotEmpty) {
//     lastData = productList[index];
//     deletedIndex = index;
//
//     setState(() {
//       productList.removeAt(index);
//     });
//
//     ScaffoldMessenger.of(_scaffoldKey.currentContext!).hideCurrentSnackBar();
//     _showCustomSnackBar('Data ke ${index + 1} dihapus', _scaffoldKey.currentContext!, true, setState);
//   }
// }

// void _restoreProduct(Function setState) {
//   ScaffoldMessenger.of(_scaffoldKey.currentContext!).hideCurrentSnackBar();
//   setState(() {
//     productList.insert(deletedIndex, lastData);
//   });
//   _showCustomSnackBar('Data ke ${deletedIndex + 1} dikembalikan', _scaffoldKey.currentContext!, false, setState);
// }
