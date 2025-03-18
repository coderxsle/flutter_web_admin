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

package top.continew.admin.system.model.entity;

import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;
import top.continew.admin.common.enums.DisEnableStatusEnum;
import top.continew.admin.common.model.entity.BaseDO;
import top.continew.admin.system.enums.SponsorTypeEnum;

import java.io.Serial;

/**
 * 赞助商实体
 *
 * @author coderxslee
 * @since 2024/3/17 10:10
 */
@Data
@TableName("sys_sponsor")
public class SponsorDO extends BaseDO {

    @Serial
    private static final long serialVersionUID = 1L;

    /**
     * 名称
     */
    private String name;

    /**
     * 图片URL
     */
    private String img;

    /**
     * 跳转链接
     */
    private String url;

    /**
     * 类型
     */
    private SponsorTypeEnum type;

    /**
     * 描述
     */
    private String description;

    /**
     * 排序
     */
    private Integer sort;

    /**
     * 状态
     */
    private DisEnableStatusEnum status;
}