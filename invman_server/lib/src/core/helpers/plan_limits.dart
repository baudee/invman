import 'package:invman_server/src/generated/protocol.dart';

const int freeInvestmentLimit = 3;

/// Returns the max allowed investments for [plan], or null for unlimited.
int? investmentLimit(AccountPlan plan) => switch (plan) {
  AccountPlan.free => freeInvestmentLimit,
  AccountPlan.pro => null,
};

/// Returns whether [plan] can use CSV import/export.
bool canImportExport(AccountPlan plan) => switch (plan) {
  AccountPlan.free => false,
  AccountPlan.pro => true,
};
