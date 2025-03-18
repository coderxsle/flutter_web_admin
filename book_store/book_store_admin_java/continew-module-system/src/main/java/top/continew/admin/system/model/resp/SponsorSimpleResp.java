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

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;

import java.io.Serial;
import java.io.Serializable;

/**
 * 赞助商简单响应参数（用于公开接口）
 *
 * @author coderxslee
 * @since 2024/3/17 11:00
 */
@Data
@Schema(description = "赞助商简单响应参数")
public class SponsorSimpleResp implements Serializable {

    @Serial
    private static final long serialVersionUID = 1L;

    /**
     * 名称
     */
    @Schema(description = "名称", example = "风铃云信息科技")
    private String name;

    /**
     * 图片URL
     */
    @Schema(description = "图片URL", example = "/img/sponsor/ad/jssy-20250218.jpg")
    private String img;

    /**
     * 跳转链接
     */
    @Schema(description = "跳转链接", example = "https://www.aeoliancloud.com/")
    private String url;
}