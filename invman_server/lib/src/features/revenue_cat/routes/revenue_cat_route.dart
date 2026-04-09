import 'dart:convert';

import 'package:invman_server/src/di.dart';
import 'package:invman_server/src/features/revenue_cat/business/revenue_cat_service.dart';
import 'package:invman_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

class RevenueCatRoute extends Route {
  RevenueCatRoute() : super(methods: {Method.post}, path: '/');

  @override
  Future<Response> handleCall(Session session, Request request) async {
    final authValues = request.headers['authorization'];
    final authHeader = authValues?.first;
    final expectedSecret = Serverpod.instance.getPassword('revenueCatWebhookSecret');

    if (authHeader == null || authHeader != expectedSecret) {
      return Response.unauthorized();
    }

    final Map<String, dynamic> payload;
    try {
      final body = await request.readAsString();
      payload = jsonDecode(body) as Map<String, dynamic>;
    } catch (_) {
      return Response.badRequest();
    }

    try {
      await getIt<RevenueCatService>().handleWebhook(session, payload);
    } on ServerException catch (e) {
      if (e.errorCode == ErrorCode.badRequest) return Response.badRequest();
      return Response.internalServerError();
    } catch (_) {
      return Response.internalServerError();
    }

    return Response.ok();
  }
}
