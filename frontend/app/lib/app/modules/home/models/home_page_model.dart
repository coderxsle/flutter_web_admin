//
//  HomePageModel.dart
//
//
//  Created by JSONConverter on 2023/08/08.
//  Copyright © 2023年 JSONConverter. All rights reserved.
//

import 'package:json_annotation/json_annotation.dart';

part 'home_page_model.g.dart';

@JsonSerializable()
class HomePageModel extends Object {

	@JsonKey(name: 'actorIds')
	String? actorIds;

	@JsonKey(name: 'actorName')
	String? actorName;

	@JsonKey(name: 'appPurviewList')
	List<HomePageModelAppPurviewList>? appPurviewList;

	@JsonKey(name: 'managerName')
	String? managerName;

	@JsonKey(name: 'photoUrl')
	String? photoUrl;

	@JsonKey(name: 'shopInfoId')
	num? shopInfoId;

	@JsonKey(name: 'shopName')
	String? shopName;

	HomePageModel(this.actorIds,this.actorName,this.appPurviewList,this.managerName,this.photoUrl,this.shopInfoId,this.shopName,);

	factory HomePageModel.fromJson(Map<String, dynamic> srcJson) => _$HomePageModelFromJson(srcJson);

	Map<String, dynamic> toJson() => _$HomePageModelToJson(this);

}

@JsonSerializable()
class HomePageModelAppPurviewList extends Object {

	@JsonKey(name: 'app')
	num? app;

	@JsonKey(name: 'appLabelId')
	num? appLabelId;

	@JsonKey(name: 'appPurviewId')
	num? appPurviewId;

	@JsonKey(name: 'appPurviewIds')
	List<String>? appPurviewIds;

	@JsonKey(name: 'communityAppPurviewId')
	num? communityAppPurviewId;

	@JsonKey(name: 'communityId')
	num? communityId;

	@JsonKey(name: 'createTime')
	String? createTime;

	@JsonKey(name: 'dailyValue')
	String? dailyValue;

	@JsonKey(name: 'isDelete')
	num? isDelete;

	@JsonKey(name: 'isLeaf')
	num? isLeaf;

	@JsonKey(name: 'parentId')
	num? parentId;

	@JsonKey(name: 'purviewCode')
	String? purviewCode;

	@JsonKey(name: 'purviewName')
	String? purviewName;

	@JsonKey(name: 'purviewUrl')
	String? purviewUrl;

	@JsonKey(name: 'shopInfoAppPurviewId')
	num? shopInfoAppPurviewId;

	@JsonKey(name: 'shopInfoId')
	num? shopInfoId;

	@JsonKey(name: 'showLocation')
	num? showLocation;

	@JsonKey(name: 'sortCode')
	num? sortCode;

	@JsonKey(name: 'totalValue')
	String? totalValue;

	@JsonKey(name: 'updateTime')
	String? updateTime;

	@JsonKey(name: 'url')
	String? url;

	@JsonKey(name: 'userMessage')
	num? userMessage;

	@JsonKey(name: 'wechatAppId')
	String? wechatAppId;

	HomePageModelAppPurviewList(this.app,this.appLabelId,this.appPurviewId,this.appPurviewIds,this.communityAppPurviewId,this.communityId,this.createTime,this.dailyValue,this.isDelete,this.isLeaf,this.parentId,this.purviewCode,this.purviewName,this.purviewUrl,this.shopInfoAppPurviewId,this.shopInfoId,this.showLocation,this.sortCode,this.totalValue,this.updateTime,this.url,this.userMessage,this.wechatAppId,);

	factory HomePageModelAppPurviewList.fromJson(Map<String, dynamic> srcJson) => _$HomePageModelAppPurviewListFromJson(srcJson);

	Map<String, dynamic> toJson() => _$HomePageModelAppPurviewListToJson(this);

}
