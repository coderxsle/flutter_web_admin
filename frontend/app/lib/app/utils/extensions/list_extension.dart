


extension SafeAccess on List {

  /// 安全的从数组中获取元素
  dynamic objectAtIndex(int index) {
    if (index >= 0 && index < length) {
      return this[index];
    } else {
      return null;
    }
  }
}