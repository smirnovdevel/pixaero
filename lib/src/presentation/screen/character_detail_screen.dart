import 'package:flutter/material.dart';
import 'package:pixaero/src/common/values.dart';
import 'package:pixaero/src/domain/entities/character_entity.dart';
import 'package:pixaero/src/presentation/widgets/character_cache_image.dart';

class CharacterDetailScreen extends StatelessWidget {
  final CharacterEntity character;

  const CharacterDetailScreen({Key? key, required this.character})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(character.name),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            const SizedBox(
              height: 24,
            ),
            //  отступ сверху
            const SizedBox(
              height: 12,
            ),
            CharacterCacheImage(
              width: 260,
              height: 260,
              imageUrl: character.image,
            ),

            const SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 12,
                  width: 12,
                  decoration: BoxDecoration(
                    color:
                        character.status == 'Alive' ? Colors.green : Colors.red,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                Text(
                  character.status,
                  style: const TextStyle(
                    color: kBlackColor,
                    fontSize: 16,
                  ),
                  maxLines: 1,
                ),
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            if (character.type.isNotEmpty)
              ...buildText('Type:', character.type),
            ...buildText('Gender:', character.gender),
            ...buildText(
                'Number of episodes: ', character.episode.length.toString()),
            ...buildText('Species:', character.species),
            ...buildText('Last known location:', character.location.name),
            ...buildText('Origin:', character.origin.name),
            ...buildText('Was created:', character.created.toString()),
          ],
        ),
      ),
    );
  }

  List<Widget> buildText(String text, String value) {
    return [
      Text(
        text,
        style: const TextStyle(
          color: kGrayColor,
        ),
      ),
      const SizedBox(
        height: 4,
      ),
      Text(
        value,
        style: const TextStyle(
          color: kBlackColor,
        ),
      ),
      const SizedBox(
        height: 12,
      ),
    ];
  }
}
