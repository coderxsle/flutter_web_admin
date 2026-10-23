import 'package:flutter_web_server/src/services/zhongyi/zhongyi_patient_service.dart';
import 'package:flutter_web_server/src/services/zhongyi/zhongyi_permissions.dart';
import 'package:flutter_web_server/src/services/zhongyi/zhongyi_prescription_template_service.dart';
import 'package:flutter_web_server/src/web/routes/api/serverpod_envelope.dart';
import 'package:flutter_web_server/src/web/routes/api/zhongyi/zhongyi_route_utils.dart';
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_crud/serverpod_crud.dart';

const _envelope = ServerpodEnvelopeBuilder();

/// 患者档案 REST 路由（详情仅按需返回敏感资料，所有接口要求登录）。
Map<String, ActionRoute> patientActionRoutes() => {
  '/api/lxs_zhongyi/patient/list': ActionRoute(
    methods: const {Method.get},
    envelope: _envelope,
    requiredPermissions: const [ZhongyiPermissions.module, ZhongyiPermissions.patientList],
    handler: (session, request) {
      final page = zhongyiPagination(request);
      return ZhongyiPatientService.list(
        session,
        page: page.page,
        pageSize: page.pageSize,
        keyword: request.queryString('keyword'),
        name: request.queryString('name'),
        phone: request.queryString('phone'),
        gender: request.queryString('gender'),
      );
    },
  ),
  '/api/lxs_zhongyi/patient/detail/:id': ActionRoute(
    methods: const {Method.get},
    envelope: _envelope,
    requiredPermissions: const [ZhongyiPermissions.module, ZhongyiPermissions.patientList],
    handler: (session, request) => ZhongyiPatientService.detail(session, request.pathId()),
  ),
  '/api/lxs_zhongyi/patient/create': ActionRoute(
    methods: const {Method.post},
    envelope: _envelope,
    requiredPermissions: const [ZhongyiPermissions.module, ZhongyiPermissions.patientCreate],
    successStatus: 201,
    handler: (session, request) async => ZhongyiPatientService.create(session, await request.jsonObjectBody()),
  ),
  '/api/lxs_zhongyi/patient/update/:id': ActionRoute(
    methods: const {Method.post},
    envelope: _envelope,
    requiredPermissions: const [ZhongyiPermissions.module, ZhongyiPermissions.patientUpdate],
    handler: (session, request) async =>
        ZhongyiPatientService.update(session, request.pathId(), await request.jsonObjectBody()),
  ),
  '/api/lxs_zhongyi/patient/delete': ActionRoute(
    methods: const {Method.post},
    envelope: _envelope,
    requiredPermissions: const [ZhongyiPermissions.module, ZhongyiPermissions.patientDelete],
    handler: (session, request) async => ZhongyiPatientService.delete(session, await zhongyiRequiredIdList(request)),
  ),
};

/// 处方模板 REST 路由。
Map<String, ActionRoute> prescriptionTemplateActionRoutes() => {
  '/api/lxs_zhongyi/prescription-template/list': ActionRoute(
    methods: const {Method.get},
    envelope: _envelope,
    requiredPermissions: const [ZhongyiPermissions.module, ZhongyiPermissions.prescriptionList],
    handler: (session, request) {
      final page = zhongyiPagination(request);
      return ZhongyiPrescriptionTemplateService.list(
        session,
        page: page.page,
        pageSize: page.pageSize,
        name: request.queryString('name'),
      );
    },
  ),
  '/api/lxs_zhongyi/prescription-template/detail/:id': ActionRoute(
    methods: const {Method.get},
    envelope: _envelope,
    requiredPermissions: const [ZhongyiPermissions.module, ZhongyiPermissions.prescriptionList],
    handler: (session, request) => ZhongyiPrescriptionTemplateService.detail(session, request.pathId()),
  ),
  '/api/lxs_zhongyi/prescription-template/create': ActionRoute(
    methods: const {Method.post},
    envelope: _envelope,
    requiredPermissions: const [ZhongyiPermissions.module, ZhongyiPermissions.prescriptionCreate],
    successStatus: 201,
    handler: (session, request) async =>
        ZhongyiPrescriptionTemplateService.create(session, await request.jsonObjectBody()),
  ),
  '/api/lxs_zhongyi/prescription-template/update/:id': ActionRoute(
    methods: const {Method.post},
    envelope: _envelope,
    requiredPermissions: const [ZhongyiPermissions.module, ZhongyiPermissions.prescriptionUpdate],
    handler: (session, request) async =>
        ZhongyiPrescriptionTemplateService.update(session, request.pathId(), await request.jsonObjectBody()),
  ),
  '/api/lxs_zhongyi/prescription-template/delete': ActionRoute(
    methods: const {Method.post},
    envelope: _envelope,
    requiredPermissions: const [ZhongyiPermissions.module, ZhongyiPermissions.prescriptionDelete],
    handler: (session, request) async =>
        ZhongyiPrescriptionTemplateService.delete(session, await zhongyiRequiredIdList(request)),
  ),
  '/api/lxs_zhongyi/prescription-template/:id/status': ActionRoute(
    methods: const {Method.post},
    envelope: _envelope,
    requiredPermissions: const [ZhongyiPermissions.module, ZhongyiPermissions.prescriptionStatus],
    handler: (session, request) async =>
        ZhongyiPrescriptionTemplateService.setStatus(session, request.pathId(), await request.jsonObjectBody()),
  ),
};
