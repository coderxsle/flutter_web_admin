import 'package:common_utils/common_utils.dart';
import 'package:flutter_web_admin/my_dialog.dart';

/// 验证参数是否为空
/// 
/// [value] 要验证的值
/// [message] 错误信息
/// [isAlert] 是否显示弹窗
/// 
/// 返回: 是否为空
bool validate(dynamic value, String message) {
  return ParamCheck.isEmpty(value, message);
}

bool validateNotEmpty(dynamic value, String message) {
  return ParamCheck.isNotEmpty(value, message);
}

class ParamCheck {
  static bool isEmpty(dynamic value, String message, {bool? isAlert}) {
    if (ObjectUtil.isEmpty(value)) {
        if (isAlert == true) {
          showAlertMessage(message);
        } else {
          showMessage(message);
        }
        return true;
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
