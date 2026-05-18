import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:invman_client/invman_client.dart';
import 'package:invman_flutter/config/generated/l10n.dart';
import 'package:invman_flutter/core/core.dart';
import 'package:invman_flutter/core/navigation/navigation.dart';
import 'package:invman_flutter/di.dart';
import 'package:invman_flutter/features/account/account.dart';
import 'package:invman_flutter/features/transfer/components/transfer_import_group_card.dart';
import 'package:invman_flutter/features/transfer/controllers/transfer_import_controller.dart';
import 'package:signals_flutter/signals_flutter.dart';

class TransferImportPreviewScreen extends HookWidget {
  const TransferImportPreviewScreen({super.key});

  static const pathSegment = 'import-transfers';
  static String route() => '${AccountRootScreen.route()}/$pathSegment';

  @override
  Widget build(BuildContext context) {
    final controller = useMemoized(() => getIt<TransferImportController>());
    useEffect(
      () =>
          () => controller.reset(),
      const [],
    );

    return BaseScreen(
      usePadding: false,
      appBar: AppBar(title: Text(S.of(context).transferImport_title)),
      body: _Body(controller: controller),
      floatingActionButton: _ConfirmButton(controller: controller),
    );
  }
}

class _Body extends HookWidget {
  final TransferImportController controller;
  const _Body({required this.controller});

  @override
  Widget build(BuildContext context) {
    final rows = controller.rows.watch(context);
    final globalErrorKey = controller.globalErrorKey.watch(context);
    final globalErrorContext = controller.globalErrorContext.watch(context);
    final unresolved = controller.unresolvedCount.watch(context);

    if (globalErrorKey != null && rows.isEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: UIConstants.appHorizontalPadding),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.error_outline, size: 48),
              const SizedBox(height: UIConstants.spacingSm),
              Text(
                translateGlobalError(globalErrorKey, globalErrorContext) ?? '',
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    }

    if (rows.isEmpty) {
      return Center(child: Text(S.of(context).transferImport_emptyPreview));
    }

    final groups = controller.groupedIndices();
    final groupKeys = useMemoized(
      () => List.generate(groups.length, (_) => GlobalKey()),
      [groups.length],
    );

    int? firstErrorGroupIndex;
    for (var i = 0; i < groups.length; i++) {
      final hasError = groups[i].any((idx) {
        final r = rows[idx];
        return r.investmentErrorKey != null || r.rowErrorKey != null;
      });
      if (hasError) {
        firstErrorGroupIndex = i;
        break;
      }
    }

    return Column(
      children: [
        if (unresolved > 0)
          _UnresolvedBanner(
            count: unresolved,
            onTap: firstErrorGroupIndex == null
                ? null
                : () {
                    final ctx = groupKeys[firstErrorGroupIndex!].currentContext;
                    if (ctx != null) {
                      Scrollable.ensureVisible(
                        ctx,
                        duration: const Duration(milliseconds: 300),
                        alignment: 0.1,
                      );
                    }
                  },
          ),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.fromLTRB(
              UIConstants.appHorizontalPadding,
              UIConstants.spacingSm,
              UIConstants.appHorizontalPadding,
              96,
            ),
            itemCount: groups.length,
            itemBuilder: (_, i) => TransferImportGroupCard(
              key: groupKeys[i],
              controller: controller,
              rowIndices: groups[i],
            ),
          ),
        ),
      ],
    );
  }
}

class _UnresolvedBanner extends StatelessWidget {
  final int count;
  final VoidCallback? onTap;
  const _UnresolvedBanner({required this.count, this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Material(
      color: theme.colorScheme.errorContainer,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(UIConstants.spacingSm),
          child: Row(
            children: [
              Icon(Icons.warning_amber_rounded, color: theme.colorScheme.onErrorContainer),
              const SizedBox(width: UIConstants.spacingSm),
              Expanded(
                child: Text(
                  S.of(context).transferImport_unresolvedBanner(count),
                  style: TextStyle(color: theme.colorScheme.onErrorContainer),
                ),
              ),
              if (onTap != null) Icon(Icons.arrow_downward_rounded, color: theme.colorScheme.onErrorContainer),
            ],
          ),
        ),
      ),
    );
  }
}

class _ConfirmButton extends StatelessWidget {
  final TransferImportController controller;
  const _ConfirmButton({required this.controller});

  @override
  Widget build(BuildContext context) {
    final canConfirm = controller.canConfirm.watch(context);
    final submitting = controller.submitting.watch(context);

    return FloatingActionButton.extended(
      onPressed: canConfirm
          ? () async {
              final error = await controller.confirm();
              if (!context.mounted) return;
              if (error == null) {
                ToastUtils.message(S.of(context).account_importSuccess);
                router.pop();
              } else {
                ToastUtils.message(error, success: false);
              }
            }
          : null,
      backgroundColor: canConfirm ? null : Theme.of(context).disabledColor,
      icon: submitting
          ? const SizedBox(
              width: 16,
              height: 16,
              child: CircularProgressIndicator(strokeWidth: 2),
            )
          : const Icon(Icons.check),
      label: Text(S.of(context).transferImport_confirm),
    );
  }
}
