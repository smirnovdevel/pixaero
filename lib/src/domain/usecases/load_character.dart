import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:pixaero/src/core/error/failure.dart';
import 'package:pixaero/src/core/usecases/usecase.dart';
import 'package:pixaero/src/domain/entities/character_entity.dart';
import 'package:pixaero/src/domain/repositories/character_repository.dart';

class LoadCharacter
    extends UseCase<List<CharacterEntity>, LoadCharacterParams> {
  final CharacterRepository characterRepository;

  LoadCharacter(this.characterRepository);

  @override
  Future<Either<Failure, List<CharacterEntity>>> call(
      LoadCharacterParams params) async {
    return await characterRepository.getAllCharacters(params.page);
  }
}

class LoadCharacterParams extends Equatable {
  final int page;

  const LoadCharacterParams({required this.page});

  @override
  List<Object> get props => [page];
}
