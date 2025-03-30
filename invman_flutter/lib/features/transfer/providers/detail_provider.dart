import 'package:invman_client/invman_client.dart';
import 'package:invman_flutter/core/models/models.dart';
import 'package:invman_flutter/features/transfer/transfer.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'detail_provider.g.dart';

@Riverpod(keepAlive: true)
class TransferDetail extends _$TransferDetail {
  @override
  ModelDetailState<Transfer> build(int id) {
    load(id);
    return Initial();
  }

  Future<void> load(int id) async {
    state = Loading();

    final result = await ref.read(transferServiceProvider).retrieve(id);

    result.fold((error) {
      state = Failure(error);
    }, (transfer) {
      state = Success(transfer);
    });
  }
}
