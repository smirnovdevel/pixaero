import 'package:dartz/dartz.dart';
import 'package:pixaero/src/core/error/exception.dart';
import 'package:pixaero/src/core/error/failure.dart';
import 'package:pixaero/src/core/platform/network_info.dart';
import 'package:pixaero/src/data/datasources/character_local_data_source.dart';
import 'package:pixaero/src/data/datasources/character_remote_data_source.dart';
import 'package:pixaero/src/data/models/character_model.dart';
import 'package:pixaero/src/domain/entities/character_entity.dart';
import 'package:pixaero/src/domain/repositories/character_repository.dart';

class CharacterRepositoryImpl implements CharacterRepository {
  final CharacterRemoteDataSource remoteDataSource;
  final CharacterLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  CharacterRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<CharacterEntity>>> getAllCharacters(
      int page) async {
    return await _getCharacters(() {
      return remoteDataSource.getAllCharacters(page);
    });
  }

  @override
  Future<Either<Failure, List<CharacterEntity>>> searchCharacter(
      String query) async {
    return await _getCharacters(() {
      return remoteDataSource.searchCharacter(query);
    });
  }

  Future<Either<Failure, List<CharacterEntity>>> _getCharacters(
      Future<List<CharacterModel>> Function() getCharacters) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteCharacters = await getCharacters();
        localDataSource.charactersToCache(remoteCharacters);
        return Right(remoteCharacters);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localCharacter =
            await localDataSource.getLastCharactersFromCache();
        return Right(localCharacter);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }
}
