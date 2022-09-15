//Service locator instance
import 'dart:convert';

import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/network/api_client.dart';
import 'datasource/auth_local_data_source.dart';
import 'datasource/auth_remote_data_source.dart';
import 'repository/auth_repository.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // # repositories
  sl.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(localDataSource: sl(), remoteDataSource: sl()));

  // # data sources
  sl.registerLazySingleton<AuthLocalDataSource>(
      () => AuthLocalDataSourceImpl(prefs: sl()));
  sl.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemotedataSourceImpl(client: sl()));

  // # clients
  sl.registerLazySingleton(() => ApiService(client: sl<BaseClient>()));

  sl.registerLazySingleton<BaseClient>(() => MockClient((request) async {
        if (request.url.toString().contains('login')) {
          return Response(
              jsonEncode({
                'data': {
                  'first_name': 'Paul',
                  'last_name': 'Higgs',
                  'access_token': 'asdasdsdfgsdfs',
                  'refresh_token': 'sdfsdfdsfsfd'
                }
              }),
              200);
        } else if (request.url.toString().contains('logout')) {
          return Response(jsonEncode({'success': true}), 200);
        }
        return Response(jsonEncode({'error': 'not found'}), 404);
      }));

  // # shared preferences
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
}
