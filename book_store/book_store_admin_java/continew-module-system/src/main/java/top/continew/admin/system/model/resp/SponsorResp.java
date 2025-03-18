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

package top.continew.admin.system.model.resp;

import com.alibaba.excel.annotation.ExcelProperty;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;
import top.continew.admin.common.enums.DisEnableStatusEnum;
import top.continew.admin.common.model.resp.BaseResp;
import top.continew.admin.system.enums.SponsorTypeEnum;

import java.io.Serial;

/**
 * 赞助商响应参数
 *
 * @author coderxslee
 * @since 2024/3/17 10:55
 */
@Data
@Schema(description = "赞助商响应参数")
public class SponsorResp extends BaseResp {

    @Serial
    private static final long serialVersionUID = 1L;

    /**
     * 名称
     */
    @ExcelProperty("名称")
    @Schema(description = "名称", example = "风铃云信息科技")
    private String name;

    /**
     * 图片URL
     */
    @ExcelProperty("图片URL")
    @Schema(description = "图片URL", example = "/img/sponsor/ad/jssy-20250218.jpg")
    private String img;

    /**
     * 跳转链接
     */
    @ExcelProperty("跳转链接")
    @Schema(description = "跳转链接", example = "https://www.aeoliancloud.com/")
    private String url;

    /**
     * 类型
     */
    @ExcelProperty("类型")
    @Schema(description = "类型", example = "platinum")
    private SponsorTypeEnum type;

    /**
     * 类型说明
     */
    @ExcelProperty("类型说明")
    @Schema(description = "类型说明", example = "白金赞助商")
    private String typeString;

    /**
     * 描述
     */
    @ExcelProperty("描述")
    @Schema(description = "描述", example = "风铃云信息科技是一家专业的云服务提供商")
    private String description;

    /**
     * 排序
     */
    @ExcelProperty("排序")
    @Schema(description = "排序", example = "999")
    private Integer sort;

    /**
     * 状态
     */
    @ExcelProperty("状态")
    @Schema(description = "状态", example = "1")
    private DisEnableStatusEnum status;

    /**
     * 状态说明
     */
    @ExcelProperty("状态说明")
    @Schema(description = "状态说明", example = "启用")
    private String statusString;
}