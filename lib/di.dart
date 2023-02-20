import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:pixaero/src/domain/usecases/get_all_characters.dart';
import 'package:pixaero/src/domain/usecases/search_character.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;

import 'src/bloc/character_list_cubit/character_list_cubit.dart';
import 'src/bloc/search_bloc/search_bloc.dart';
import 'src/core/platform/network_info.dart';
import 'src/data/datasources/character_local_data_source.dart';
import 'src/data/datasources/character_remote_data_source.dart';
import 'src/data/repositories/character_repository_impl.dart';
import 'src/domain/repositories/character_repository.dart';

final di = GetIt.instance;

Future<void> init() async {
  // BLoC / Cubit
  di.registerFactory(
    () => CharacterListCubit(getAllCharacters: di<GetAllCharacters>()),
  );
  di.registerFactory(
    () => CharacterSearchBloc(searchCharacter: di()),
  );

  // UseCases
  di.registerLazySingleton(() => GetAllCharacters(di()));
  di.registerLazySingleton(() => SearchCharacter(di()));

  // Repository
  di.registerLazySingleton<CharacterRepository>(
    () => CharacterRepositoryImpl(
      remoteDataSource: di(),
      localDataSource: di(),
      networkInfo: di(),
    ),
  );

  di.registerLazySingleton<CharacterRemoteDataSource>(
    () => CharacterRemoteDataSourceImpl(
      client: di(),
    ),
  );

  di.registerLazySingleton<CharacterLocalDataSource>(
    () => CharacterLocalDataSourceImpl(sharedPreferences: di()),
  );

  // Core
  di.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImp(di()),
  );

  // External
  final sharedPreferences = await SharedPreferences.getInstance();
  di.registerLazySingleton(() => sharedPreferences);
  di.registerLazySingleton(() => http.Client());
  di.registerLazySingleton(() => InternetConnectionChecker());
}
