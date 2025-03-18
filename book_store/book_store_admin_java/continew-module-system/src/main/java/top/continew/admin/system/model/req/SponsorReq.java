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

package top.continew.admin.system.model.req;

import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import lombok.Data;
import top.continew.admin.common.enums.DisEnableStatusEnum;
import top.continew.admin.system.enums.SponsorTypeEnum;
import top.continew.starter.extension.crud.validation.CrudValidationGroup;

import java.io.Serial;
import java.io.Serializable;

/**
 * 赞助商请求参数
 *
 * @author coderxslee
 * @since 2024/3/17 10:20
 */
@Data
@Schema(description = "赞助商请求参数")
public class SponsorReq implements Serializable {

    @Serial
    private static final long serialVersionUID = 1L;

    /**
     * 名称
     */
    @NotBlank(groups = {CrudValidationGroup.Add.class, CrudValidationGroup.Update.class}, message = "名称不能为空")
    @Size(groups = {CrudValidationGroup.Add.class,
        CrudValidationGroup.Update.class}, max = 100, message = "名称长度不能超过 {max} 个字符")
    @Schema(description = "名称", requiredMode = Schema.RequiredMode.REQUIRED, example = "风铃云信息科技")
    private String name;

    /**
     * 图片URL
     */
    @NotBlank(groups = {CrudValidationGroup.Add.class, CrudValidationGroup.Update.class}, message = "图片URL不能为空")
    @Size(groups = {CrudValidationGroup.Add.class,
        CrudValidationGroup.Update.class}, max = 512, message = "图片URL长度不能超过 {max} 个字符")
    @Schema(description = "图片URL", requiredMode = Schema.RequiredMode.REQUIRED, example = "/img/sponsor/ad/jssy-20250218.jpg")
    private String img;

    /**
     * 跳转链接
     */
    @NotBlank(groups = {CrudValidationGroup.Add.class, CrudValidationGroup.Update.class}, message = "跳转链接不能为空")
    @Size(groups = {CrudValidationGroup.Add.class,
        CrudValidationGroup.Update.class}, max = 512, message = "跳转链接长度不能超过 {max} 个字符")
    @Schema(description = "跳转链接", requiredMode = Schema.RequiredMode.REQUIRED, example = "https://www.aeoliancloud.com/")
    private String url;

    /**
     * 类型
     */
    @NotNull(groups = {CrudValidationGroup.Add.class, CrudValidationGroup.Update.class}, message = "类型不能为空")
    @Schema(description = "类型", requiredMode = Schema.RequiredMode.REQUIRED, example = "platinum")
    private SponsorTypeEnum type;

    /**
     * 描述
     */
    @Size(groups = {CrudValidationGroup.Add.class,
        CrudValidationGroup.Update.class}, max = 200, message = "描述长度不能超过 {max} 个字符")
    @Schema(description = "描述", requiredMode = Schema.RequiredMode.NOT_REQUIRED, example = "风铃云信息科技是一家专业的云服务提供商")
    private String description;

    /**
     * 排序
     */
    @Schema(description = "排序", requiredMode = Schema.RequiredMode.NOT_REQUIRED, example = "999")
    private Integer sort;

    /**
     * 状态
     */
    @Schema(description = "状态", requiredMode = Schema.RequiredMode.NOT_REQUIRED, example = "1")
    private DisEnableStatusEnum status;
}