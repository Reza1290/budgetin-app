import 'dart:convert';

import 'package:budgetin/main.dart';
import 'package:budgetin/models/database.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:drift/drift.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:uuid/v4.dart';

class TrackerService {
  static const String trackerEndpoint = '/api/v1/products/34/track';

  Future track(
    String target, {
    Map content = const {},
    bool withDeviceInfo = false,
  }) async {
    try {
      final environment = dotenv.get('APP_ENV');
      final user = await getUser();

      final productId = dotenv.get('PRODUCT_ID');
      final endpoint = trackerEndpoint.replaceFirst('{PRODUCT_ID}', productId);
      final url = getUrl(endpoint);

      if (withDeviceInfo) {
        content = {}
          ..addAll(content)
          ..addAll({
            'device_info': await getDeviceInfo(),
          });
      }

      content = {}
        ..addAll(content)
        ..addAll({
          "app_info": await getAppInfo(),
        });

      final response = await (Dio()).post(
        url,
        data: {
          'environment': environment,
          'target': target,
          'content': jsonEncode(content),
          'user': jsonEncode(user),
        },
      );
      print(response.data);
      print(response.statusCode);
    } catch (e) {
      print(e);
    }
  }

  Future<Map> getUser() async {
    UserTracker user = await db!.getUser() ??
        UserTracker(id: 0, name: ':D', uuid: '', createdAt: DateTime.now());
    if (user.uuid == '') {
      user = await db!.storeUser(UserTrackersCompanion(
          uuid: Value(UuidV4().generate()), name: Value('test')));
    }
    return {
      'id': user.uuid,
      'name': user.name ?? 'Budi GAMING :D"',
      'email': 'budgetinjayaoffline@gmail.com',
    };
  }

  String getUrl(String endpoint) {
    final baseUrl = dotenv.get('BASE_URL');

    return baseUrl + endpoint;
  }

  Future<Map> getAppInfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    return {
      'app_name': packageInfo.appName,
      'package_name': packageInfo.packageName,
      'version': packageInfo.version,
      'build_number': packageInfo.buildNumber,
    };
  }

  dynamic getDeviceInfo() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;

    return androidInfo.data;
  }
}
