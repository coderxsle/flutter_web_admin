/// 布局类型枚举
enum LayoutType {
  def('default'), /// 默认布局
  mix('mix'),   /// 混合布局
  top('top');  /// 顶部布局

  final String value;
  const LayoutType(this.value);
}
