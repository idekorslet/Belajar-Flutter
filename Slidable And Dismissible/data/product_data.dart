import '../messages_popup/snackbar_popup.dart';
import '../model/product_model.dart';

final allProduct = [
  Product(name: 'mouse', price: 50000),
  Product(name: 'keyboard', price: 150000),
  Product(name: 'Laptop', price: 10000000),
  Product(name: 'Senter Mini', price: 55000),
  Product(name: 'Mouse pad', price: 90000),
  Product(name: 'HDMI to AV converter', price: 75000),
  Product(name: 'Power Bank 10000 Mah', price: 180000),
];

class ProductData {
  final List<Product> _productList = List.of(allProduct);
  late Product _lastData; // menampung data terakhir yang dihapus
  int _deletedIndex = 0;  // menampung index terakhir yang dihapus

  // singleton
  ProductData._privateConstructor();
  static final ProductData _instance = ProductData._privateConstructor();

  factory ProductData() {
    print('Product data created');
    return _instance;
  }

  int getProductLength() => _productList.length;
  int getDeletedIndex() => _deletedIndex;
  int getProductPrice(int index) => _productList[index].price;
  String getProductTitle(int index) => _productList[index].name;

  void removeProduct(int index, Function setState) {
    if (_productList.isNotEmpty) {
      _lastData = _productList[index];
      _deletedIndex = index;

      setState(() {
        _productList.removeAt(index);
      });

      SnackBarInfo().showSnackBar('Data ke ${index + 1} dihapus', true, setState);
    }
  }

  void restoreProduct(Function setState) {
    setState(() {
      _productList.insert(_deletedIndex, _lastData);
    });
    SnackBarInfo().showSnackBar('Data ke ${_deletedIndex + 1} dikembalikan', false, setState);
  }
}
