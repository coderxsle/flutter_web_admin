///@description 登录页新增动态按钮
///@updateTime 2024/9/29 10:53
class ButtonType {
  // final num? functionId;
  // final String? createTime;
  String? functionName;
  // final num? isDelete;
  // final num? appPurviewId;
  String? eventName;
  // final num? sortCode;

  ButtonType({
    // this.functionId,
    // this.createTime,
    this.functionName,
    // this.isDelete,
    // this.appPurviewId,
    this.eventName,
    // this.sortCode,
  });

  factory ButtonType.fromJson(Map<String, dynamic> json) {
    return ButtonType(
      // functionId: json['functionId'],
      // createTime: json['createTime'],
      functionName: json['functionName'],
      // isDelete: json['isDelete'],
      // appPurviewId: json['appPurviewId'],
      eventName: json['eventName'],
      // sortCode: json['sortCode'],
    );
  }

  Map<String, dynamic> toJson() => {
        // 'functionId': functionId,
        // 'createTime': createTime,
        'functionName': functionName,
        // 'isDelete': isDelete,
        // 'appPurviewId': appPurviewId,
        'eventName': eventName,
        // 'sortCode': sortCode,
      };

  @override
  bool operator ==(Object other) => identical(this, other) || other is ButtonType && runtimeType == other.runtimeType && eventName == other.eventName;

  @override
  int get hashCode => eventName.hashCode;

// @override
  // bool operator ==(Object other) => identical(this, other) || other is ButtonType && runtimeType == other.runtimeType && functionName == other.functionName && eventName == other.eventName;
  //
  // @override
  // int get hashCode => functionName.hashCode ^ eventName.hashCode;



}
