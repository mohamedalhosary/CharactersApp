// 3. Updated Character Item Widget
import 'package:flutter/material.dart';
import 'package:flutter_breaking/core/constants/colors.dart';
import 'package:flutter_breaking/data/models/characters.dart';
import 'package:flutter_breaking/presentaiton/screens/character_details.dart';

class CharacterItem extends StatelessWidget {
  final Character character;

  const CharacterItem({super.key, required this.character});

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: character.id,
      child: Material(
        borderRadius: BorderRadius.circular(12),
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    CharacterDetailsScreen(character: character),
              ),
            );
          },
          borderRadius: BorderRadius.circular(12),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: MyColors.primary.withOpacity(0.1),
                  spreadRadius: 2,
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Stack(
                children: [
                  _buildCharacterImage(),
                  _buildGradientOverlay(),
                  _buildCharacterInfo(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCharacterImage() {
    return Positioned.fill(
      child: character.image.isNotEmpty
          ? Image.network(
              character.image,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Center(
                  child: CircularProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes!
                        : null,
                    color: MyColors.secondary,
                  ),
                );
              },
              errorBuilder: (context, error, stackTrace) => Container(
                color: MyColors.surface,
                child: Icon(
                  Icons.person,
                  size: 50,
                  color: MyColors.textSecondary,
                ),
              ),
            )
          : Container(
              color: MyColors.surface,
              child: Icon(
                Icons.person,
                size: 50,
                color: MyColors.textSecondary,
              ),
            ),
    );
  }

  Widget _buildGradientOverlay() {
    return Positioned.fill(
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [MyColors.primary.withOpacity(0.8), Colors.transparent],
            stops: const [0.0, 0.5],
          ),
        ),
      ),
    );
  }

  Widget _buildCharacterInfo() {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              character.name,
              style: const TextStyle(
                color: MyColors.textOnPrimary,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Container(
                  width: 8,
                  height: 8,
                  margin: const EdgeInsets.only(right: 4),
                  decoration: BoxDecoration(
                    color: _getStatusColor(character.status),
                    shape: BoxShape.circle,
                  ),
                ),
                Text(
                  '${character.status} - ${character.species}',
                  style: TextStyle(
                    color: MyColors.textOnPrimary.withOpacity(0.8),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'alive':
        return MyColors.success;
      case 'dead':
        return MyColors.error;
      default:
        return MyColors.warning;
    }
  }
}
