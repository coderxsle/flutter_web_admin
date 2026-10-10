import '../sring_utils.dart';
import 'my_dialog.dart';

bool validate(dynamic value, String message) {
  return (ParamCheck.isEmpty(value, message));
}

class ParamCheck {
  static bool isEmpty(dynamic value, String message, {bool? isAlert}) {
    if (value == null) {
      if (isAlert == true) {
        showAlertMessage(message);
      } else {
        showMessage(message);
      }
      return true;
    }

    if (value is String) {
      if (StringUtils.isNullOrEmpty(value)) {
        if (isAlert == true) {
          showAlertMessage(message);
        } else {
          showMessage(message);
        }
        return true;
      }
    }
    if (value is List || value is Map) {
      if (value.isEmpty) {
        if (isAlert == true) {
          showAlertMessage(message);
        } else {
          showMessage(message);
        }
        return true;
      }
    }
    return false;
  }

  static bool isNotEmpty(dynamic value, String message, {bool? isAlert}) {
    return !isEmpty(value, message, isAlert: isAlert);
  }

  static bool is0(dynamic value, String message, {bool? isAlert}) {
    if (value == 0) {
      if (isAlert == true) {
        showAlertMessage(message);
      } else {
        showMessage(message);
      }
      return true;
    }
    return false;
  }
}
