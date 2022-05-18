import 'dart:convert';
import 'package:http/http.dart' as http;

class Helper {
  List _allData = [];
  bool downloadNewData = false;
  List<String> _categoryText = [];
  List _productByCategoryIndex = [];
  List<Map<String, dynamic>> _dataByCategory = [];

  static final Helper _instance = Helper._privateConstructor();
  Helper._privateConstructor();

  factory Helper() {
    return _instance;
  }

  Future loadData({required String apiUrl}) async {
    try {
      final uri = Uri.parse(apiUrl);
      var client = http.Client();
      var response = await client.get(uri);

      if (response.statusCode == 200) {
        // convert dari json ke list map
        _allData = List<Map>.from(json.decode(response.body));
        return _allData;
      } else {
        throw Exception('Shomething wrong: ${response.statusCode}');
      }
    } catch (e) {
      print('Loading data error: $e}');
    }
  }

  Future downloadData({required String apiUrl}) async {
    await loadData(apiUrl: apiUrl);
    _divideDataByCategory();
    return allData;
  }

  void _divideDataByCategory() {
    String title = '';
    String category = '';
    String price = '';
    String imageUrl = '';
    int index;
    int currentIndex = 0;

    _categoryText = [];
    _productByCategoryIndex = [];

    for (int i = 0; i < _allData.length; i++) {
      title = _allData[i]['title'];
      category = _allData[i]['category'];
      price = _allData[i]['price'].toString();
      imageUrl = _allData[i]['image'];
      index = _categoryText.indexOf(category);

      // jika kategori tidak ditemukan maka input kategori baru ke list
      if (index < 0) {
        currentIndex = _categoryText.length;
        _categoryText.add(category);
      } else {
        currentIndex = index;
      }

      _productByCategoryIndex.add([currentIndex, [title, category, price, imageUrl]]);
    }

    _categoryText.insert(0, 'All');

    // urutkan berdasarkan currentIndex / index kategori
    _productByCategoryIndex.sort((a, b) => a[0].compareTo(b[0]));

    // variable untuk menampung data sementara
    Map<String, dynamic> _tempData = {};
    int _curIndex = 0;
    _dataByCategory = [];

    // looping sebanyak jumlah data yang kategorinya sudah diurutkan berdasarkan index kategori
    for (int i=0; i < _productByCategoryIndex.length; i++) {

      // jika nilai index data ke-n berbeda dengan nilai index sekarang
      if (_productByCategoryIndex[i][0] != _curIndex) {
        // simpan semua data ke list setelah semua data sesuai indexnya di kumpulkan
        _dataByCategory.add(_tempData);
        _curIndex += 1;
        _tempData = {};
      }

      _tempData[i.toString()] = {
        'title'   : _productByCategoryIndex[i][1][0],
        'category': _productByCategoryIndex[i][1][1],
        'price'   : _productByCategoryIndex[i][1][2],
        'image'   : _productByCategoryIndex[i][1][3]
      };
    }

    // masukkan data terakhir
    _dataByCategory.add(_tempData);
  }

  List filterDataByCategory(int categoryIndex) {
    List result = [];
    _dataByCategory[categoryIndex].forEach((key, value) {
      result.add(value);
    });

    return result;
  }

  List<String> get categoryList => _categoryText;
  List get allData => _allData;
}

// void main() async {
//   await Helper().downloadData(apiUrl: 'https://fakestoreapi.com/products');
//   print('====================');
//   // print(Helper().filterDataByCategory(2));
//   print(Helper().categoryList);
//   print('====================');
//   print(Helper().allData);
//   // print(Helper()._productByCategory);
// }
