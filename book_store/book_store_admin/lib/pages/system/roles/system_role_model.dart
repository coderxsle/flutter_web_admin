class SystemRoleModel {
  int id;
  String name;
  int? userCount;
  int? resourceCount;

  SystemRoleModel({
    required this.id,
    required this.name,
    this.userCount,
    this.resourceCount,
  });

  factory SystemRoleModel.fromJson(Map<String, dynamic> json) {
    return SystemRoleModel(
      id: json['id'] as int,
      name: json['name'] as String,
      userCount: json['userCount'] as int?,
      resourceCount: json['resourceCount'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'userCount': userCount,
      'resourceCount': resourceCount,
    };
  }
} 