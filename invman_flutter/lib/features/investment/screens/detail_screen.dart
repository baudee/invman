import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:invman_flutter/core/core.dart';
import 'package:invman_flutter/core/navigation/router.dart';
import 'package:invman_flutter/di.dart';
import 'package:invman_flutter/features/investment/investment.dart';

class InvestmentDetailScreen extends HookWidget {
  final int id;
  const InvestmentDetailScreen({super.key, required this.id});
  static String route([int? id]) => "/${id ?? ':id'}";

  @override
  Widget build(BuildContext context) {
    final controller = useMemoized(() => getIt<InvestmentDetailController>(param1: id));
    return BaseScreen(
      appBar: AppBar(
        title: controller.value.map(
          data: (investment) => Text(investment.name),
          error: (_) => null,
          loading: () => null,
        ),
        actions: [
          PopupMenuButton<int>(
            icon: const Icon(Icons.more_vert),
            onSelected: (value) async {
              switch (value) {
                case 0:
                  router.pushRelative(InvestmentEditScreen.route(id));
                  break;
                case 1:
                  final (success, message) = await controller.delete();
                  ToastUtils.message(message, success: success);
                  if (success) router.pop();
                  break;
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 0,
                child: ListTile(leading: Icon(Icons.edit), title: Text('Edit')),
              ),
              const PopupMenuItem(
                value: 1,
                child: ListTile(leading: Icon(Icons.delete), title: Text('Delete')),
              ),
            ],
          ),
        ],
      ),
      body: BaseStateComponent(
        state: controller,
        successBuilder: (investment) => InvestmentDetailComponent(investment: investment),
      ),
    );
  }
}
