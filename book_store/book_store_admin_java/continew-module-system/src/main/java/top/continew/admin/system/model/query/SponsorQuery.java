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

package top.continew.admin.system.model.query;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;
import top.continew.admin.common.enums.DisEnableStatusEnum;
import top.continew.admin.system.enums.SponsorTypeEnum;
import top.continew.starter.extension.crud.model.query.PageQuery;

/**
 * 赞助商查询条件
 *
 * @author coderxslee
 * @since 2024/3/17 10:15
 */
@Data
@Schema(description = "赞助商查询条件")
public class SponsorQuery extends PageQuery {

    /**
     * 名称
     */
    @Schema(description = "名称", example = "风铃云信息科技")
    private String name;

    /**
     * 类型
     */
    @Schema(description = "类型", example = "platinum")
    private SponsorTypeEnum type;

    /**
     * 状态
     */
    @Schema(description = "状态", example = "1")
    private DisEnableStatusEnum status;
}