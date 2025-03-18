/*
 * Copyright (c) 2022-present Charles7c Authors. All Rights Reserved.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package top.continew.admin.system.service;

import top.continew.admin.system.enums.SponsorTypeEnum;
import top.continew.admin.system.model.entity.SponsorDO;
import top.continew.admin.system.model.query.SponsorQuery;
import top.continew.admin.system.model.req.SponsorReq;
import top.continew.admin.system.model.resp.SponsorResp;
import top.continew.admin.system.model.resp.SponsorSimpleResp;
import top.continew.starter.data.mp.service.IService;
import top.continew.starter.extension.crud.service.BaseService;

import java.util.List;

/**
 * 赞助商业务接口
 *
 * @author coderxslee
 * @since 2024/3/17 11:20
 */
public interface SponsorService extends BaseService<SponsorResp, SponsorResp, SponsorQuery, SponsorReq>, IService<SponsorDO> {

    /**
     * 获取指定类型的赞助商列表
     *
     * @param type 赞助商类型
     * @return 赞助商列表
     */
    List<SponsorSimpleResp> listSponsorsByType(SponsorTypeEnum type);

    /**
     * 获取所有类型的赞助商列表
     *
     * @return 所有赞助商列表
     */
    List<SponsorSimpleResp> listAllSponsors();
}