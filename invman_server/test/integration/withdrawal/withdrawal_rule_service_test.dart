import 'package:invman_server/src/di.dart';
import 'package:invman_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';
import 'package:test/test.dart';

import '../test_tools/serverpod_test_tools.dart';

void main() {
  // Configure dependency injection before tests
  setUpAll(() {
    configureDependencies();
  });

  withServerpod(
    'WithdrawalRuleService nested fee save',
    rollbackDatabase: RollbackDatabase.afterAll,
    (sessionBuilder, endpoints) {
      late UuidValue userId;
      late TestSessionBuilder authenticatedSession;

      setUpAll(() async {
        // Create an actual auth user in the database using ORM directly
        final session = sessionBuilder.build();
        final authUser = AuthUser(scopeNames: {});
        final savedUser = await AuthUser.db.insertRow(session, authUser);
        userId = savedUser.id!;
        await session.close();

        authenticatedSession = sessionBuilder.copyWith(
          authentication: AuthenticationOverride.authenticationInfo(
            userId.toString(),
            {},
          ),
        );
      });

      group('insert new rule without fees first', () {
        test('should create rule without fees', () async {
          final rule = WithdrawalRule(
            userId: userId,
            name: 'Test Rule No Fees',
            currencyChangePercentage: 5.0,
          );

          final savedRule = await endpoints.withdrawalRule.save(
            authenticatedSession,
            rule,
          );

          expect(savedRule.id, isNotNull);
          expect(savedRule.name, 'Test Rule No Fees');
        });
      });

      group('insert new rule with fees', () {
        test('should create rule and fees with IDs', () async {
          final rule = WithdrawalRule(
            userId: userId,
            name: 'Test Rule',
            currencyChangePercentage: 5.0,
            fees: [
              WithdrawalFee(ruleId: 0, percent: 2.5, fixed: 1.0, minimum: 0.5),
              WithdrawalFee(ruleId: 0, percent: 1.0, fixed: 0.5, minimum: 0.25),
            ],
          );

          final savedRule = await endpoints.withdrawalRule.save(
            authenticatedSession,
            rule,
          );

          expect(savedRule.id, isNotNull);
          expect(savedRule.name, 'Test Rule');
          expect(savedRule.fees, isNotNull);
          expect(savedRule.fees!.length, 2);
          expect(savedRule.fees![0].id, isNotNull);
          expect(savedRule.fees![1].id, isNotNull);
          expect(savedRule.fees![0].ruleId, savedRule.id);
          expect(savedRule.fees![1].ruleId, savedRule.id);
        });
      });

      group('update existing rule, add new fee', () {
        test('should add new fee while keeping existing', () async {
          // Create rule with 1 fee
          final rule = WithdrawalRule(
            userId: userId,
            name: 'Rule With One Fee',
            currencyChangePercentage: 3.0,
            fees: [
              WithdrawalFee(ruleId: 0, percent: 1.0, fixed: 0.0, minimum: 0.0),
            ],
          );

          final savedRule = await endpoints.withdrawalRule.save(
            authenticatedSession,
            rule,
          );

          final existingFee = savedRule.fees!.first;

          // Update with existing fee + new fee
          final updatedRule = savedRule.copyWith(
            fees: [
              existingFee,
              WithdrawalFee(
                ruleId: savedRule.id!,
                percent: 2.0,
                fixed: 1.0,
                minimum: 0.5,
              ),
            ],
          );

          final result = await endpoints.withdrawalRule.save(
            authenticatedSession,
            updatedRule,
          );

          expect(result.fees!.length, 2);
          expect(result.fees!.any((f) => f.id == existingFee.id), isTrue);
          expect(result.fees!.any((f) => f.percent == 2.0), isTrue);
        });
      });

      group('update existing rule, update fee values', () {
        test('should update fee with new values', () async {
          // Create rule with 1 fee
          final rule = WithdrawalRule(
            userId: userId,
            name: 'Rule To Update Fee',
            currencyChangePercentage: 2.0,
            fees: [
              WithdrawalFee(ruleId: 0, percent: 1.0, fixed: 0.0, minimum: 0.0),
            ],
          );

          final savedRule = await endpoints.withdrawalRule.save(
            authenticatedSession,
            rule,
          );

          final existingFee = savedRule.fees!.first;

          // Update the fee values
          final updatedFee = existingFee.copyWith(
            percent: 5.0,
            fixed: 2.0,
            minimum: 1.0,
          );

          final updatedRule = savedRule.copyWith(fees: [updatedFee]);

          final result = await endpoints.withdrawalRule.save(
            authenticatedSession,
            updatedRule,
          );

          expect(result.fees!.length, 1);
          expect(result.fees!.first.id, existingFee.id);
          expect(result.fees!.first.percent, 5.0);
          expect(result.fees!.first.fixed, 2.0);
          expect(result.fees!.first.minimum, 1.0);
        });
      });

      group('update existing rule, delete fee', () {
        test('should delete fee not in incoming list', () async {
          // Create rule with 2 fees
          final rule = WithdrawalRule(
            userId: userId,
            name: 'Rule To Delete Fee',
            currencyChangePercentage: 1.0,
            fees: [
              WithdrawalFee(ruleId: 0, percent: 1.0, fixed: 0.0, minimum: 0.0),
              WithdrawalFee(ruleId: 0, percent: 2.0, fixed: 0.0, minimum: 0.0),
            ],
          );

          final savedRule = await endpoints.withdrawalRule.save(
            authenticatedSession,
            rule,
          );

          expect(savedRule.fees!.length, 2);

          final keepFee = savedRule.fees!.first;

          // Save with only first fee
          final updatedRule = savedRule.copyWith(fees: [keepFee]);

          final result = await endpoints.withdrawalRule.save(
            authenticatedSession,
            updatedRule,
          );

          expect(result.fees!.length, 1);
          expect(result.fees!.first.id, keepFee.id);
        });
      });

      group('update existing rule, delete all fees', () {
        test('should delete all fees with empty list', () async {
          // Create rule with 2 fees
          final rule = WithdrawalRule(
            userId: userId,
            name: 'Rule To Clear Fees',
            currencyChangePercentage: 1.0,
            fees: [
              WithdrawalFee(ruleId: 0, percent: 1.0, fixed: 0.0, minimum: 0.0),
              WithdrawalFee(ruleId: 0, percent: 2.0, fixed: 0.0, minimum: 0.0),
            ],
          );

          final savedRule = await endpoints.withdrawalRule.save(
            authenticatedSession,
            rule,
          );

          expect(savedRule.fees!.length, 2);

          // Save with empty fees list
          final updatedRule = savedRule.copyWith(fees: []);

          final result = await endpoints.withdrawalRule.save(
            authenticatedSession,
            updatedRule,
          );

          expect(result.fees, isEmpty);
        });
      });

      group('mixed operations in one save', () {
        test('should handle add, update, and delete together', () async {
          // Create rule with 3 fees (A, B, C)
          final rule = WithdrawalRule(
            userId: userId,
            name: 'Rule Mixed Ops',
            currencyChangePercentage: 1.0,
            fees: [
              WithdrawalFee(
                ruleId: 0,
                percent: 1.0,
                fixed: 0.0,
                minimum: 0.0,
              ), // A
              WithdrawalFee(
                ruleId: 0,
                percent: 2.0,
                fixed: 0.0,
                minimum: 0.0,
              ), // B
              WithdrawalFee(
                ruleId: 0,
                percent: 3.0,
                fixed: 0.0,
                minimum: 0.0,
              ), // C
            ],
          );

          final savedRule = await endpoints.withdrawalRule.save(
            authenticatedSession,
            rule,
          );

          expect(savedRule.fees!.length, 3);

          final feeA = savedRule.fees![0];
          final feeAId = feeA.id;

          // Update A (change percent), delete B and C, add D
          final updatedFeeA = feeA.copyWith(percent: 10.0);
          final newFeeD = WithdrawalFee(
            ruleId: savedRule.id!,
            percent: 4.0,
            fixed: 0.0,
            minimum: 0.0,
          );

          final updatedRule = savedRule.copyWith(fees: [updatedFeeA, newFeeD]);

          final result = await endpoints.withdrawalRule.save(
            authenticatedSession,
            updatedRule,
          );

          expect(result.fees!.length, 2);

          // A should be updated
          final resultA = result.fees!.firstWhere((f) => f.id == feeAId);
          expect(resultA.percent, 10.0);

          // D should be new
          final resultD = result.fees!.firstWhere((f) => f.id != feeAId);
          expect(resultD.percent, 4.0);
          expect(resultD.id, isNotNull);
        });
      });

      group('validation: negative percent', () {
        test('should throw badRequest for negative percent', () async {
          final rule = WithdrawalRule(
            userId: userId,
            name: 'Invalid Rule',
            currencyChangePercentage: 1.0,
            fees: [
              WithdrawalFee(ruleId: 0, percent: -1.0, fixed: 0.0, minimum: 0.0),
            ],
          );

          expect(
            () => endpoints.withdrawalRule.save(authenticatedSession, rule),
            throwsA(isA<ServerException>()),
          );
        });
      });

      group('validation: negative fixed', () {
        test('should throw badRequest for negative fixed', () async {
          final rule = WithdrawalRule(
            userId: userId,
            name: 'Invalid Rule',
            currencyChangePercentage: 1.0,
            fees: [
              WithdrawalFee(ruleId: 0, percent: 0.0, fixed: -1.0, minimum: 0.0),
            ],
          );

          expect(
            () => endpoints.withdrawalRule.save(authenticatedSession, rule),
            throwsA(isA<ServerException>()),
          );
        });
      });

      group('validation: negative minimum', () {
        test('should throw badRequest for negative minimum', () async {
          final rule = WithdrawalRule(
            userId: userId,
            name: 'Invalid Rule',
            currencyChangePercentage: 1.0,
            fees: [
              WithdrawalFee(ruleId: 0, percent: 0.0, fixed: 0.0, minimum: -1.0),
            ],
          );

          expect(
            () => endpoints.withdrawalRule.save(authenticatedSession, rule),
            throwsA(isA<ServerException>()),
          );
        });
      });

      group('rule without fees', () {
        test('should save rule with null fees', () async {
          final rule = WithdrawalRule(
            userId: userId,
            name: 'Rule No Fees',
            currencyChangePercentage: 1.0,
          );

          final savedRule = await endpoints.withdrawalRule.save(
            authenticatedSession,
            rule,
          );

          expect(savedRule.id, isNotNull);
          expect(savedRule.fees, isEmpty);
        });
      });

      group('security: fee ID spoofing', () {
        test('should reject fee ID from another rule', () async {
          // Create first rule with a fee (victim)
          final victimRule = WithdrawalRule(
            userId: userId,
            name: 'Victim Rule',
            currencyChangePercentage: 1.0,
            fees: [
              WithdrawalFee(ruleId: 0, percent: 5.0, fixed: 1.0, minimum: 0.5),
            ],
          );

          final savedVictimRule = await endpoints.withdrawalRule.save(
            authenticatedSession,
            victimRule,
          );

          final victimFeeId = savedVictimRule.fees!.first.id;

          // Create second rule (attacker)
          final attackerRule = WithdrawalRule(
            userId: userId,
            name: 'Attacker Rule',
            currencyChangePercentage: 2.0,
          );

          final savedAttackerRule = await endpoints.withdrawalRule.save(
            authenticatedSession,
            attackerRule,
          );

          // Attempt to update attacker's rule with victim's fee ID
          final maliciousUpdate = savedAttackerRule.copyWith(
            fees: [
              WithdrawalFee(
                id: victimFeeId, // Spoofed fee ID from another rule
                ruleId: savedAttackerRule.id!,
                percent: 99.0,
                fixed: 99.0,
                minimum: 99.0,
              ),
            ],
          );

          expect(
            () => endpoints.withdrawalRule.save(
              authenticatedSession,
              maliciousUpdate,
            ),
            throwsA(isA<ServerException>()),
          );
        });
      });
    },
  );
}
