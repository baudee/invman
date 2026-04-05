// ignore_for_file: avoid_print

import 'dart:io';
import 'dart:typed_data';

import 'package:minio/minio.dart';

const _s3Endpoint = 's3.swiss-backup04.infomaniak.com';
const _s3Bucket = 'default';

Minio createS3Client(String accessKey, String secretKey) {
  return Minio(
    endPoint: _s3Endpoint,
    accessKey: accessKey,
    secretKey: secretKey,
    useSSL: true,
  );
}

/// Downloads all files from [s3Prefix] into [localDir].
/// Skips keys that end with '/' (directory markers).
Future<void> downloadS3Dir(Minio client, String s3Prefix, String localDir) async {
  final dir = Directory(localDir);
  if (!dir.existsSync()) dir.createSync(recursive: true);

  final keys = <String>[];
  await for (final chunk in client.listObjects(_s3Bucket, prefix: s3Prefix, recursive: true)) {
    for (final obj in chunk.objects) {
      if (obj.key != null) keys.add(obj.key!);
    }
  }

  for (final key in keys) {
    if (key.endsWith('/')) continue;

    final fileName = key.split('/').last;
    if (fileName.isEmpty) continue;

    final localPath = '$localDir/$fileName';
    final stream = await client.getObject(_s3Bucket, key);
    final bytes = await stream.fold<List<int>>([], (a, b) => a..addAll(b));
    await File(localPath).writeAsBytes(bytes);
    print('  Downloaded s3://$_s3Bucket/$key → $localPath');
  }
}

/// Uploads all files in [localDir] to S3 under [s3Prefix].
Future<void> uploadDir(Minio client, String localDir, String s3Prefix) async {
  final dir = Directory(localDir);
  if (!dir.existsSync()) return;

  for (final entity in dir.listSync()) {
    if (entity is! File) continue;

    final fileName = entity.path.split('/').last;
    final key = '$s3Prefix/$fileName';
    final bytes = Uint8List.fromList(await entity.readAsBytes());

    await client.putObject(
      _s3Bucket,
      key,
      Stream.value(bytes),
      size: bytes.length,
    );
    print('  Uploaded $localDir/$fileName → s3://$_s3Bucket/$key');
  }
}
