import 'package:invman_server/src/generated/protocol.dart';

extension UserPermissionsExtensions on UserPermissions {
  static UserPermissions fromPlan(SubscriptionPlan plan) {
    return switch (plan) {
      SubscriptionPlan.premium => UserPermissions(investmentsLimit: null),
      SubscriptionPlan.free => UserPermissions(investmentsLimit: 3),
    };
  }
}
