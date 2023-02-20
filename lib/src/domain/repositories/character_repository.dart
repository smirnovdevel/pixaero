import 'package:dartz/dartz.dart';
import 'package:pixaero/src/core/error/failure.dart';
import 'package:pixaero/src/domain/entities/character_entity.dart';

abstract class CharacterRepository {
  Future<Either<Failure, List<CharacterEntity>>> getAllCharacters(int page);
  Future<Either<Failure, List<CharacterEntity>>> searchCharacter(String query);
}
