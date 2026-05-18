import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:invman_client/invman_client.dart';
import 'package:invman_flutter/core/core.dart';

@lazySingleton
class TransferImportRepository {
  final Client client;

  TransferImportRepository(this.client);

  Future<Either<String, TransferImportPreview>> parsePreview(String csvContent) async {
    return safeCall(() async {
      final preview = await client.dataTransfer.parseImportPreview(csvContent);
      return right(preview);
    });
  }

  Future<Either<String, void>> confirm(List<TransferImportRow> rows) async {
    return safeCall(() async {
      await client.dataTransfer.confirmImport(rows);
      return right(null);
    });
  }

  Future<Either<String, String>> downloadTemplate() async {
    return safeCall(() async {
      final csv = await client.dataTransfer.downloadTemplate();
      return right(csv);
    });
  }
}
