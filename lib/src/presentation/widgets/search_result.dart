import 'package:flutter/material.dart';
import 'package:pixaero/src/domain/entities/character_entity.dart';
import 'package:pixaero/src/presentation/screen/character_detail_screen.dart';
import 'package:pixaero/src/presentation/widgets/character_cache_image.dart';

class SearchResult extends StatelessWidget {
  final CharacterEntity characterResult;

  const SearchResult({Key? key, required this.characterResult})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                CharacterDetailScreen(character: characterResult),
          ),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        elevation: 2.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 300,
              width: double.infinity,
              child: CharacterCacheImage(
                imageUrl: characterResult.image,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                characterResult.name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 26.0,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                characterResult.location.name,
                style: const TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 16.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
