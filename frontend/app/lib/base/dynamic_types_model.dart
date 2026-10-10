//
//  DynamicTypesModel.dart
//
//
//  Created by JSONConverter on 2023/08/11.
//  Copyright © 2023年 JSONConverter. All rights reserved.
//

import 'package:json_annotation/json_annotation.dart';

part 'dynamic_types_model.g.dart';

@JsonSerializable()
class DynamicTypesModel extends Object {

	@JsonKey(name: 'code')
	String? code;

	@JsonKey(name: 'keyBookId')
	num? keyBookId;

	@JsonKey(name: 'name')
	String? name;

	@JsonKey(name: 'type')
	String? type;

	@JsonKey(name: 'typeName')
	String? typeName;

	@JsonKey(name: 'value')
	String? value;

	DynamicTypesModel(this.code,this.keyBookId,this.name,this.type,this.typeName,this.value,);

	factory DynamicTypesModel.fromJson(Map<String, dynamic> srcJson) => _$DynamicTypesModelFromJson(srcJson);

	Map<String, dynamic> toJson() => _$DynamicTypesModelToJson(this);

}
