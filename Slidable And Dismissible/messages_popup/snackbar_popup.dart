import 'package:flutter/material.dart';
import '../main.dart';

class SnackBarInfo {
  _customSnackBar(String title, bool isUndoChanges, Function setState) {
    return SnackBar(
      duration: const Duration(seconds: 5),
      content: Text(title, style: const TextStyle(fontSize: 20),),
      action: SnackBarAction(
          label: isUndoChanges ? 'UNDO' : 'CLOSE',
          onPressed: () {
            if (isUndoChanges) {
              prodData.restoreProduct(setState);
            }
          }
      ),
    );
  }

  showSnackBar(title, bool isUndoChanges, Function setState) {
    ScaffoldMessenger.of(scaffoldKey.currentContext!).hideCurrentSnackBar();
    return ScaffoldMessenger.of(scaffoldKey.currentContext!).showSnackBar(_customSnackBar(title, isUndoChanges, setState));
  }
}
