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
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
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
     * 获取赞助商列表
     *
     * @param type 赞助商类型，不传则返回所有类型
     * @return 赞助商列表
     */
    @SaIgnore
    @PostMapping("/sponsor/list")
    @Operation(summary = "获取赞助商列表")
    public List<SponsorSimpleResp> listSponsors(@RequestParam(required = false) @Parameter(description = "赞助商类型，可选值：PLATINUM-白金，GOLD-金牌，SILVER-银牌") SponsorTypeEnum type) {
        if (type != null) {
            return sponsorService.listSponsorsByType(type);
        }
        return sponsorService.listAllSponsors();
    }

}