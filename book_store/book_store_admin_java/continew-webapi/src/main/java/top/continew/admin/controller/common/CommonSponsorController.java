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

package top.continew.admin.controller.common;

import cn.dev33.satoken.annotation.SaIgnore;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;
import top.continew.admin.system.enums.SponsorTypeEnum;
import top.continew.admin.system.model.resp.SponsorSimpleResp;
import top.continew.admin.system.service.SponsorService;

import java.util.List;

/**
 * 赞助商公开 API
 *
 * @author coderxslee
 * @since 2024/3/17 11:40
 */
@Tag(name = "赞助商公开 API")
@RestController
@RequiredArgsConstructor
public class CommonSponsorController {

    private final SponsorService sponsorService;

    /**
     * 获取白金赞助商列表
     *
     * @return 白金赞助商列表
     */
    @SaIgnore
    @GetMapping("/sponsor/platinum")
    @Operation(summary = "获取白金赞助商列表")
    public List<SponsorSimpleResp> listPlatinumSponsors() {
        return sponsorService.listSponsorsByType(SponsorTypeEnum.PLATINUM);
    }

    /**
     * 获取金牌赞助商列表
     *
     * @return 金牌赞助商列表
     */
    @SaIgnore
    @GetMapping("/sponsor/gold")
    @Operation(summary = "获取金牌赞助商列表")
    public List<SponsorSimpleResp> listGoldSponsors() {
        return sponsorService.listSponsorsByType(SponsorTypeEnum.GOLD);
    }

    /**
     * 获取银牌赞助商列表
     *
     * @return 银牌赞助商列表
     */
    @SaIgnore
    @GetMapping("/sponsor/silver")
    @Operation(summary = "获取银牌赞助商列表")
    public List<SponsorSimpleResp> listSilverSponsors() {
        return sponsorService.listSponsorsByType(SponsorTypeEnum.SILVER);
    }
}