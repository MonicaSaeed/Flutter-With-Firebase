import 'package:fluttertoast/fluttertoast.dart';

import '../../core/theme/light_colors.dart';

class ToastHelper {
  static void showSuccess(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 15,
      backgroundColor: LightColor.primaryColor,
      textColor: LightColor.secondaryColor,
      fontSize: 16.0,
    );
  }

  static void showError(String message) {
    Fluttertoast.showToast(
      msg: "Error: $message",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 15,
      backgroundColor: LightColor.errorColor,
      textColor: LightColor.secondaryColor,
      fontSize: 16.0,
    );
  }
}
