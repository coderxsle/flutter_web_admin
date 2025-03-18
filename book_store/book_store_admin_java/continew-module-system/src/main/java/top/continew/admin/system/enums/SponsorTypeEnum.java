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

package top.continew.admin.system.enums;

import lombok.Getter;
import lombok.RequiredArgsConstructor;
import top.continew.starter.core.enums.BaseEnum;

/**
 * 赞助商类型枚举
 *
 * @author coderxslee
 * @since 2024/3/17 10:05
 */
@Getter
@RequiredArgsConstructor
public enum SponsorTypeEnum implements BaseEnum<String> {

    /**
     * 白金赞助商
     */
    PLATINUM("platinum", "白金赞助商"),

    /**
     * 金牌赞助商
     */
    GOLD("gold", "金牌赞助商"),

    /**
     * 银牌赞助商
     */
    SILVER("silver", "银牌赞助商");

    private final String value;
    private final String description;
}