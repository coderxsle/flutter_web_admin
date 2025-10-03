
// 小区
class Community {
  final String? companyId;
  final String? communityId;
  final String? communityName;
  final String? firstSpell; // 首字母

  Community({this.companyId, this.communityId, this.communityName, this.firstSpell, });

  factory Community.fromJson(Map<dynamic, dynamic> json) {
    return Community(
      companyId : json['companyId'].toString(),
      communityId : json['communityId'].toString(),
      communityName : json['communityName'].toString(),
      firstSpell : json['firstSpell'].toString(),
    );
  }

}


class DataModel {
  final String? name;
  DataModel({this.name});
  factory DataModel.fromJson(Map<String, dynamic> json) {
    return DataModel(
      name: json['name'] as String?,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'name': name,
    };
  }
}