import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:pixaero/src/core/error/failure.dart';
import 'package:pixaero/src/core/usecases/usecase.dart';
import 'package:pixaero/src/domain/entities/character_entity.dart';
import 'package:pixaero/src/domain/repositories/character_repository.dart';

class GetAllCharacters
    extends UseCase<List<CharacterEntity>, PageCharacterParams> {
  final CharacterRepository characterRepository;

  GetAllCharacters(this.characterRepository);

  @override
  Future<Either<Failure, List<CharacterEntity>>> call(
      PageCharacterParams params) async {
    return await characterRepository.getAllCharacters(params.page);
  }
}

class PageCharacterParams extends Equatable {
  final int page;

  const PageCharacterParams({required this.page});

  @override
  List<Object> get props => [page];
}
