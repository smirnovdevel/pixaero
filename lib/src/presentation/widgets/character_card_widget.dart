import 'package:flutter/material.dart';
import 'package:pixaero/src/common/values.dart';
import 'package:pixaero/src/domain/entities/character_entity.dart';
import 'package:pixaero/src/presentation/screen/character_detail_screen.dart';
import 'package:pixaero/src/presentation/widgets/character_cache_image.dart';

class CharacterCard extends StatelessWidget {
  final CharacterEntity character;

  const CharacterCard({Key? key, required this.character}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CharacterDetailScreen(character: character),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          // color: kCellBackground,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            const SizedBox(
              width: 10.0,
            ),
            CharacterCacheImage(
              width: 120,
              height: 120,
              imageUrl: character.image,
            ),
            const SizedBox(
              width: 22.0,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 12,
                  ),
                  Text(
                    character.name,
                    style: const TextStyle(
                      fontSize: 20,
                      color: kBlackColor,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Row(
                    children: [
                      Container(
                        height: 10,
                        width: 10,
                        decoration: BoxDecoration(
                          color: character.status == 'Alive'
                              ? Colors.green
                              : Colors.red,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Expanded(
                        child: Text(
                          '${character.status} - ${character.species}',
                          style: const TextStyle(color: kBlackColor),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  const Text(
                    'Last known location:',
                    style: TextStyle(color: kBlackColor),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    character.location.name,
                    style: const TextStyle(color: kBlackColor),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 12,
            ),
          ],
        ),
      ),
    );
  }
}
