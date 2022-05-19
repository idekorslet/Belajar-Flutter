import 'package:flutter/material.dart';
import 'package:test_getx1/data.dart';
import 'package:get/get.dart';
import 'package:test_getx1/widget_helper.dart';

int catIndex = 0;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  final dataController = Get.put(GetXCtrl());

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Combine Future Builder with GetX',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Future builder with getX'),
        ),
        body: showData(),
      )
    );
  }
  
  Widget showData() {
    var helper = Helper();

    return FutureBuilder(
      future: helper.downloadData(apiUrl: 'https://fakestoreapi.com/products'),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        else if (!snapshot.hasError) {
          if (snapshot.hasData) {
            dataController.getxProductList.value = snapshot.data;
            return Obx(() {
              return viewProductList(helper, dataController.getxProductList);
            });

          } else {
            return const Text("DATA KOSONG");
          }
        }
        else {
          // print('Snapshot error: ' + snapshot.error.toString());
          return const Center(child: Text('Showing data error!', style: TextStyle(fontSize: 28)));
        }
      }
    );
  }

  Widget viewProductList(Helper helper, List data) {
    return Column(
      children: [
        SizedBox(
          height: 40,
          /// list view daftar kategori
          child: categoryList(helper),
        ),
        const Divider(
          height: 8,
          thickness: 2,
          color: Colors.blue,
        ),
        /// daftar produk
        Expanded(
          child: GridView.builder(
              itemCount: data.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisSpacing: 6.0,
                  mainAxisSpacing: 6.0,
                  crossAxisCount: 2
              ),
              itemBuilder: (BuildContext context, int index) {
                return productContainer(
                    prodNo: index + 1,
                    title: dataController.getxProductList[index]['title'],
                    price: dataController.getxProductList[index]['price'].toString(),
                    imageUrl: dataController.getxProductList[index]['image']
                );
              }
          ),
        ),
      ],
    );
  }

  Widget categoryList(Helper helper) {
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: helper.categoryList.length,
        itemBuilder: (context, index) {
          return
            GestureDetector(
              child: Container(
                margin: const EdgeInsets.only(left: 2.0, right: 2.0, top: 4.0),
                child: TextButton(
                  onPressed: () {
                    catIndex = helper.categoryList.indexOf(helper.categoryList[index]);
                    dataController.reloadDataByCategory(helper, index-1);
                  },
                  style: index == catIndex ? WidgetHelper().btnCategoryStyle(true) : WidgetHelper().btnCategoryStyle(false),
                  child: Text(
                      helper.categoryList[index],
                      style: const TextStyle(fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center
                  ),
                ),
              ),
            );
        });
  }

  Widget productContainer({required int prodNo, required String title, required String price, required String imageUrl}) {
    /// product container
    return Container(
      padding: const EdgeInsets.all(4.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blue),
      ),
      child: Column(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              "#$prodNo",
            ),
          ),
          Expanded(
            /// image container
            child: Container(
              width: 150,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(imageUrl),
                      fit: BoxFit.fill
                  )
              ),
            ),
          ),
          /// product title
          Text(title),
          /// product price
          Text('\$' + price,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

class GetXCtrl extends GetxController {
  RxList getxProductList = [].obs;

  void reloadDataByCategory(Helper helper, int index) {
    index < 0 ? getxProductList.value = helper.allData : getxProductList.value = helper.filterDataByCategory(index);
  }
}
