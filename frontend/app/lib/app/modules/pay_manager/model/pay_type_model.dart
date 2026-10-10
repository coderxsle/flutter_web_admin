class PayTypeModel {
	String? image;
	String? payTypeCode;
	int? payTypeId;
	double? payRate;
	int? isOnline;
	String? payName;
	int? sortCode;
	int? isEnable;
	dynamic amount;

	PayTypeModel({this.image, this.payTypeCode, this.payTypeId, this.payRate, this.isOnline, this.payName, this.sortCode, this.isEnable, this.amount});

	PayTypeModel.fromJson(Map<String, dynamic> json) {
		image = json['image'];
		payTypeCode = json['payTypeCode'];
		payTypeId = json['payTypeId']??json['payType'];
		payRate = json['payRate'];
		isOnline = json['isOnline'];
		payName = json['payName']??json['payTypeName'];
		sortCode = json['sortCode'];
		isEnable = json['isEnable'];
		amount = json['amount'];
		// payType = json['payType'];
		// payTypeName = json['payTypeName'];
	}
}