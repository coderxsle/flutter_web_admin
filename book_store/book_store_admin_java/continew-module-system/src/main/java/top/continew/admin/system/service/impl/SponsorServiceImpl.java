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

package top.continew.admin.system.service.impl;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import top.continew.admin.common.enums.DisEnableStatusEnum;
import top.continew.admin.system.enums.SponsorTypeEnum;
import top.continew.admin.system.mapper.SponsorMapper;
import top.continew.admin.system.model.entity.SponsorDO;
import top.continew.admin.system.model.query.SponsorQuery;
import top.continew.admin.system.model.req.SponsorReq;
import top.continew.admin.system.model.resp.SponsorResp;
import top.continew.admin.system.model.resp.SponsorSimpleResp;
import top.continew.admin.system.service.SponsorService;
import top.continew.starter.extension.crud.service.BaseServiceImpl;

import java.util.List;
import java.util.stream.Collectors;

/**
 * 赞助商业务实现
 *
 * @author coderxslee
 * @since 2024/3/17 11:25
 */
@Service
@RequiredArgsConstructor
public class SponsorServiceImpl extends BaseServiceImpl<SponsorMapper, SponsorDO, SponsorResp, SponsorResp, SponsorQuery, SponsorReq> implements SponsorService {

    @Override
    public List<SponsorSimpleResp> listSponsorsByType(SponsorTypeEnum type) {
        // 查询指定类型且状态为启用的赞助商
        List<SponsorDO> sponsors = baseMapper.lambdaQuery()
            .eq(SponsorDO::getType, type)
            .eq(SponsorDO::getStatus, DisEnableStatusEnum.ENABLE)
            .orderByAsc(SponsorDO::getSort)
            .list();

        // 转换为简单响应对象
        return sponsors.stream().map(sponsor -> {
            SponsorSimpleResp resp = new SponsorSimpleResp();
            resp.setName(sponsor.getName());
            resp.setImg(sponsor.getImg());
            resp.setUrl(sponsor.getUrl());
            return resp;
        }).collect(Collectors.toList());
    }

    @Override
    public List<SponsorSimpleResp> listAllSponsors() {
        // 查询所有启用状态的赞助商
        List<SponsorDO> sponsors = baseMapper.lambdaQuery()
            .eq(SponsorDO::getStatus, DisEnableStatusEnum.ENABLE)
            .orderByAsc(SponsorDO::getType)
            .orderByAsc(SponsorDO::getSort)
            .list();

        // 转换为简单响应对象
        return sponsors.stream().map(sponsor -> {
            SponsorSimpleResp resp = new SponsorSimpleResp();
            resp.setName(sponsor.getName());
            resp.setImg(sponsor.getImg());
            resp.setUrl(sponsor.getUrl());
            return resp;
        }).collect(Collectors.toList());
    }
}