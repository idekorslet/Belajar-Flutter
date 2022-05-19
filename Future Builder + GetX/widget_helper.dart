import 'package:flutter/material.dart';

class WidgetHelper {

  ButtonStyle btnCategoryStyle(bool changeColor) {
    return ButtonStyle(
        padding: MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.all(10)),
        foregroundColor: changeColor ? MaterialStateProperty.all<Color>(Colors.white) : MaterialStateProperty.all<Color>(Colors.blue),
        backgroundColor: changeColor ? MaterialStateProperty.all<Color>(Colors.blue) : MaterialStateProperty.all<Color>(Colors.white),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
                side: const BorderSide(color: Colors.blue)
            )
        )
    );
  }
}
