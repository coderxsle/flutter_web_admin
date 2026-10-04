import 'package:serverpod/serverpod.dart';

import 'action_route.dart';
import 'envelope_builder.dart';

/// 资源动作定义。路径是相对于资源挂载点的路径。
class RestAction {
  const RestAction({
    required this.path,
    required this.methods,
    required this.handler,
    this.requireAuth = true,
    EnvelopeBuilder? envelope,
    this.successStatus = 200,
  }) : _envelope = envelope;

  final String path;
  final Set<Method> methods;
  final Future<Object?> Function(Session session, Request request) handler;
  final bool requireAuth;
  final EnvelopeBuilder? _envelope;
  final int successStatus;

  EnvelopeBuilder get envelope => _envelope ?? const PlainEnvelopeBuilder();

  ActionRoute toRoute({EnvelopeBuilder? defaultEnvelope}) => ActionRoute(
    methods: methods,
    path: path,
    envelope: _envelope ?? defaultEnvelope ?? const PlainEnvelopeBuilder(),
    requireAuth: requireAuth,
    successStatus: successStatus,
    handler: handler,
  );
}

RestAction get(
  String path,
  Future<Object?> Function(Session session, Request request) handler, {
  bool requireAuth = true,
  EnvelopeBuilder? envelope,
  int successStatus = 200,
}) => RestAction(
  path: path,
  methods: const {Method.get},
  handler: handler,
  requireAuth: requireAuth,
  envelope: envelope,
  successStatus: successStatus,
);

RestAction post(
  String path,
  Future<Object?> Function(Session session, Request request) handler, {
  bool requireAuth = true,
  EnvelopeBuilder? envelope,
  int successStatus = 200,
}) => RestAction(
  path: path,
  methods: const {Method.post},
  handler: handler,
  requireAuth: requireAuth,
  envelope: envelope,
  successStatus: successStatus,
);

RestAction put(
  String path,
  Future<Object?> Function(Session session, Request request) handler, {
  bool requireAuth = true,
  EnvelopeBuilder? envelope,
  int successStatus = 200,
}) => RestAction(
  path: path,
  methods: const {Method.put},
  handler: handler,
  requireAuth: requireAuth,
  envelope: envelope,
  successStatus: successStatus,
);

RestAction delete(
  String path,
  Future<Object?> Function(Session session, Request request) handler, {
  bool requireAuth = true,
  EnvelopeBuilder? envelope,
  int successStatus = 200,
}) => RestAction(
  path: path,
  methods: const {Method.delete},
  handler: handler,
  requireAuth: requireAuth,
  envelope: envelope,
  successStatus: successStatus,
);
