import 'package:flutter/material.dart';
import 'package:test_getx1/data.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
            return Column(
              children: [
                SizedBox(
                  height: 40,
                  /// list view daftar toko / seller
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: helper.categoryList.length,
                    itemBuilder: (context, index) {
                      return
                        GestureDetector(
                          child: Container(
                            margin: const EdgeInsets.only(left: 2.0, right: 2.0, top: 4.0),
                            // child: textButtonSeller(index),
                            child: TextButton(
                              onPressed: () {
                                index == 0 ? print(helper.allData) : helper.filterDataByCategory(index-1);
                              },
                              style: ButtonStyle(
                                padding: MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.all(10)),
                                foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                      side: const BorderSide(color: Colors.blue)
                                  )
                                )
                              ),
                              child: Text(
                                // " Toko ${(index + 1)} ",
                                helper.categoryList[index],
                                style: const TextStyle(fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center
                              ),
                            ),
                          ),
                        );
                    }),
                ),
                const Divider(
                  height: 8,
                  thickness: 2,
                  color: Colors.blue,
                ),
                /// daftar produk
                Expanded(
                  child: GridView.builder(
                      itemCount: snapshot.data.length,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisSpacing: 6.0,
                          mainAxisSpacing: 6.0,
                          crossAxisCount: 2
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        return productContainer(
                            imageUrl: snapshot.data[index]['image'],
                            title: snapshot.data[index]['title'],
                            price: snapshot.data[index]['price'].toString()
                        );
                      }
                  ),
                ),
              ],
            );
          } else {
            print('data kosong');
            return const Text("DATA KOSONG");
          }
        }
        else {
          print('Snapshot error: ' + snapshot.error.toString());
          return const Center(child: Text('Showing data error!', style: TextStyle(fontSize: 28)));
        }
      }
    );
  }

  Widget productContainer({required String imageUrl, required String title, required String price}) {
    /// product container
    return Container(
      padding: const EdgeInsets.all(4.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blue),
      ),
      child: Column(
        children: [
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
