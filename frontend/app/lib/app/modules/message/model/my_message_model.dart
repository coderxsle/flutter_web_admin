
/*{
"isAlreadyDone": "0",
"isOverdue": "1",
"isReminder": "0",
"latentType": "#latentType#"
}*/

class MyMessageModel {
  final String? isRead;
  final String? content;
  final String? createTime;
  final String? notificationId;
  final String? title;
  final String? url;
  //消息关联的业务资源id
  final int? sourceId;
  //--------------------
  //跟推送相关的逻辑；
  //参数是一个String我用json来解析参数
  final String? paramsApp;
  //跳转到APP的哪个页面
  final String? urlApp;
  // final String? jumpApp;
  // final String? isAlreadyDone;
  //是否逾期
  // final String? isOverdue;
  // final String? isReminder;
  // final String? latentType;

  MyMessageModel({
    this.isRead,
    this.content,
    this.createTime,
    this.notificationId,
    this.title,
    this.url,
    this.sourceId,
    //--------------------
    this.paramsApp,
    this.urlApp,
    // this.jumpApp,
    // this.isAlreadyDone,
    // this.isOverdue,
    // this.isReminder,
    // this.latentType,
  });

  factory MyMessageModel.fromJson(Map<dynamic, dynamic> json) {
    return MyMessageModel(
      isRead: json['isRead'].toString(),
      content: json['content'].toString(),
      createTime: json['createTime'].toString(),
      notificationId: json['notificationId'].toString(),
      title: json['title'].toString(),
      url: json['url'].toString(),
      sourceId: json['sourceId'],
      //--------------------
      paramsApp: json['paramsApp'],
      urlApp: json['urlApp'],
      // jumpApp: json['jumpApp'],
      // isAlreadyDone: json['isAlreadyDone'],
      // isOverdue: json['isOverdue'],
      // isReminder: json['isReminder'],
      // latentType: json['latentType'],
    );
  }
}
