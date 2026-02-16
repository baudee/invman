# Withdrawal Fees Inline Editing

## Summary

Consolidate fee management directly into the withdrawal rule edit page. Fees will no longer have a separate endpoint or dedicated screens — they become a nested part of the rule entity.

## Current State

- Rules and fees are managed separately
- User creates a rule first, then adds fees one by one in a separate screen
- Separate endpoints: `WithdrawalRuleEndpoint` and `WithdrawalFeeEndpoint`
- Separate services, repositories, and controllers for each

## Target State

- Fees are managed inline within the rule edit form
- Single save persists both rule and fees together
- Fee endpoint and related frontend code removed
- Cleaner API surface and simpler UX

## Design Decisions

| Decision | Choice |
|----------|--------|
| Fees per rule | Typically 2-3 |
| Save behavior | Single save button for rule + fees |
| Fee endpoint | Remove completely |
| UI pattern | Modal/bottom sheet for fee editing, tiles in rule form |
| New rules | Allow adding fees before first save (local state) |
| Delete confirmation | None — removed from list immediately, persisted on save |

## Backend Changes

### Rule Service (`withdrawal_rule_service.dart`)

Modify `save()` to handle nested fees in a single transaction:

1. Insert or update the rule
2. Diff incoming fees with existing ones in DB:
   - Fees with `id == null` → insert
   - Fees with matching `id` → update
   - Existing fees not in incoming list → delete
3. Return saved rule with updated fee IDs

### Files to Change

| Action | File |
|--------|------|
| Modify | `withdrawal/business/withdrawal_rule_service.dart` |
| Modify | `withdrawal/endpoints/withdrawal_rule_endpoint.dart` |
| Delete | `withdrawal/endpoints/withdrawal_fee_endpoint.dart` |
| Delete | `withdrawal/business/withdrawal_fee_service.dart` |

## Frontend Changes

### State Management

`WithdrawalRuleEditController` manages both rule fields and fees:

```
Fields:
- nameController (existing)
- currencyChangePercentageController (existing)
- fees: Signal<List<WithdrawalFee>> (local state)
```

On submit: attach `fees` to rule, save. Backend diffs and handles persistence.

### UI Flow

1. User opens rule edit screen (new or existing)
2. Rule fields + fee tiles visible below
3. Tap "Add" or existing tile → modal bottom sheet opens
4. Edit fee in modal → close → back to rule screen with updated list
5. Tap "Save" on rule screen → everything persists

### Validation

| Field | Rule |
|-------|------|
| Rule name | Required, non-empty |
| Currency change percentage | >= 0 |
| Fee percent | >= 0 |
| Fee fixed | >= 0 |
| Fee minimum | >= 0 |

### Files to Change

| Action | File |
|--------|------|
| Modify | `features/withdrawal/rule/controllers/edit_controller.dart` |
| Modify | `features/withdrawal/rule/screens/edit_screen.dart` |
| Create | `features/withdrawal/fee/components/edit_modal.dart` |
| Delete | `features/withdrawal/fee/screens/edit_screen.dart` |
| Delete | `features/withdrawal/fee/screens/detail_screen.dart` |
| Delete | `features/withdrawal/fee/controllers/edit_controller.dart` |
| Delete | `features/withdrawal/repositories/withdrawal_fee_repository.dart` |

## Error Handling

- Field-level validation errors shown inline
- Modal validation prevents closing with invalid data
- Backend transaction failure → error returned, nothing persisted
- Network/server errors shown as snackbar, form data preserved
