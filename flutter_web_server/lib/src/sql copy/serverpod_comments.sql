BEGIN;

-- serverpod_auth_core_user 表注释
COMMENT ON TABLE "serverpod_auth_core_user" IS '认证用户主体表，存储用户的认证身份信息';
COMMENT ON COLUMN "serverpod_auth_core_user"."id" IS '用户唯一标识符（UUID v7）';
COMMENT ON COLUMN "serverpod_auth_core_user"."scopeNames" IS '用户被授予的权限范围列表，用于 API 端点访问控制（如 admin）';
COMMENT ON COLUMN "serverpod_auth_core_user"."blocked" IS '是否被封禁，true 表示该用户无法登录';
COMMENT ON COLUMN "serverpod_auth_core_user"."createdAt" IS '用户创建时间（UTC）';

-- =============================================
-- serverpod_auth_core_jwt_refresh_token
-- =============================================
COMMENT ON TABLE "serverpod_auth_core_jwt_refresh_token" IS 'JWT 刷新令牌表，存储 JWT 会话对应的 refresh token，令牌轮换时旧记录会被新记录替换';
COMMENT ON COLUMN "serverpod_auth_core_jwt_refresh_token"."id" IS '刷新令牌唯一标识符（UUID v7）';
COMMENT ON COLUMN "serverpod_auth_core_jwt_refresh_token"."authUserId" IS '关联的认证用户 ID，外键引用 serverpod_auth_core_user.id，用户删除时级联删除';
COMMENT ON COLUMN "serverpod_auth_core_jwt_refresh_token"."scopeNames" IS '该令牌对应的权限范围列表（JSON 格式）';
COMMENT ON COLUMN "serverpod_auth_core_jwt_refresh_token"."extraClaims" IS '附加的自定义 JWT Claims 数据（可为空）';
COMMENT ON COLUMN "serverpod_auth_core_jwt_refresh_token"."method" IS '生成该令牌所使用的登录方式（如 email、google 等）';
COMMENT ON COLUMN "serverpod_auth_core_jwt_refresh_token"."fixedSecret" IS '固定密钥（二进制），用于令牌验证';
COMMENT ON COLUMN "serverpod_auth_core_jwt_refresh_token"."rotatingSecretHash" IS '轮换密钥的哈希值，令牌轮换时更新';
COMMENT ON COLUMN "serverpod_auth_core_jwt_refresh_token"."lastUpdatedAt" IS '令牌最后更新时间（UTC）';
COMMENT ON COLUMN "serverpod_auth_core_jwt_refresh_token"."createdAt" IS '令牌创建时间（UTC）';

-- =============================================
-- serverpod_auth_core_profile
-- =============================================
COMMENT ON TABLE "serverpod_auth_core_profile" IS '用户个人资料表，存储用户的基本信息（用户名、全名、邮箱等）';
COMMENT ON COLUMN "serverpod_auth_core_profile"."id" IS '个人资料唯一标识符（UUID v7）';
COMMENT ON COLUMN "serverpod_auth_core_profile"."authUserId" IS '关联的认证用户 ID，外键引用 serverpod_auth_core_user.id，用户删除时级联删除，且每个用户只有一条资料记录（唯一索引）';
COMMENT ON COLUMN "serverpod_auth_core_profile"."userName" IS '用户名（可为空）';
COMMENT ON COLUMN "serverpod_auth_core_profile"."fullName" IS '用户全名（可为空）';
COMMENT ON COLUMN "serverpod_auth_core_profile"."email" IS '用户邮箱地址（可为空）';
COMMENT ON COLUMN "serverpod_auth_core_profile"."createdAt" IS '资料创建时间（UTC）';
COMMENT ON COLUMN "serverpod_auth_core_profile"."imageId" IS '关联的头像图片 ID，外键引用 serverpod_auth_core_profile_image.id（可为空）';

-- =============================================
-- serverpod_auth_core_profile_image
-- =============================================
COMMENT ON TABLE "serverpod_auth_core_profile_image" IS '用户头像图片表，存储用户头像的存储路径和访问地址';
COMMENT ON COLUMN "serverpod_auth_core_profile_image"."id" IS '头像图片唯一标识符（UUID v7）';
COMMENT ON COLUMN "serverpod_auth_core_profile_image"."userProfileId" IS '关联的用户资料 ID，外键引用 serverpod_auth_core_profile.id，资料删除时级联删除';
COMMENT ON COLUMN "serverpod_auth_core_profile_image"."createdAt" IS '图片上传时间（UTC）';
COMMENT ON COLUMN "serverpod_auth_core_profile_image"."storageId" IS '存储服务的存储桶/存储空间标识符';
COMMENT ON COLUMN "serverpod_auth_core_profile_image"."path" IS '图片在存储服务中的路径';
COMMENT ON COLUMN "serverpod_auth_core_profile_image"."url" IS '图片的公开访问 URL';

-- =============================================
-- serverpod_auth_core_session
-- =============================================
COMMENT ON TABLE "serverpod_auth_core_session" IS '登录会话表，存储数据库支持的用户会话信息，用于验证用户登录状态';
COMMENT ON COLUMN "serverpod_auth_core_session"."id" IS '会话唯一标识符（UUID v7）';
COMMENT ON COLUMN "serverpod_auth_core_session"."authUserId" IS '关联的认证用户 ID，外键引用 serverpod_auth_core_user.id，用户删除时级联删除';
COMMENT ON COLUMN "serverpod_auth_core_session"."scopeNames" IS '该会话对应的权限范围列表（JSON 格式）';
COMMENT ON COLUMN "serverpod_auth_core_session"."createdAt" IS '会话创建时间（UTC）';
COMMENT ON COLUMN "serverpod_auth_core_session"."lastUsedAt" IS '会话最后使用时间（UTC）';
COMMENT ON COLUMN "serverpod_auth_core_session"."expiresAt" IS '会话固定过期时间（UTC），为空表示不设固定过期';
COMMENT ON COLUMN "serverpod_auth_core_session"."expireAfterUnusedFor" IS '会话闲置超时时长（单位：秒），超过此时长未使用则过期，为空表示不限制';
COMMENT ON COLUMN "serverpod_auth_core_session"."sessionKeyHash" IS '会话密钥的哈希值（二进制），用于验证会话合法性';
COMMENT ON COLUMN "serverpod_auth_core_session"."sessionKeySalt" IS '会话密钥的盐值（二进制），用于哈希计算';
COMMENT ON COLUMN "serverpod_auth_core_session"."method" IS '生成该会话所使用的登录方式（如 email、google 等）';


COMMIT;
