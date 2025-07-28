// 2. Updated Character Details Screen
import 'package:flutter/material.dart';
import 'package:flutter_breaking/core/constants/colors.dart';
import 'package:flutter_breaking/data/models/characters.dart';

class CharacterDetailsScreen extends StatelessWidget {
  final Character character;

  const CharacterDetailsScreen({super.key, required this.character});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: MyColors.background,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: size.height * 0.35,
            pinned: true,
            backgroundColor: MyColors.primary,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                character.name,
                style: TextStyle(
                  color: MyColors.textOnPrimary,
                  fontWeight: FontWeight.bold,
                  shadows: [
                    Shadow(
                      color: Colors.black.withOpacity(0.8),
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
              ),
              background: Hero(
                tag: character.id,
                child: Image.network(
                  character.image,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    color: MyColors.surface,
                    child: Icon(
                      Icons.person,
                      size: 100,
                      color: MyColors.textSecondary,
                    ),
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Card(
                color: MyColors.surface,
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildStatusBadge(context),
                      const SizedBox(height: 20),
                      _buildInfoSection(context, 'Basic Information', [
                        _buildInfoItem(
                          context,
                          'Species',
                          character.species,
                          Icons.category,
                        ),
                        _buildInfoItem(
                          context,
                          'Type',
                          character.type.isEmpty ? 'Unknown' : character.type,
                          Icons.info,
                        ),
                        _buildInfoItem(
                          context,
                          'Gender',
                          character.gender,
                          Icons.transgender,
                        ),
                      ]),
                      const SizedBox(height: 20),
                      _buildInfoSection(context, 'Locations', [
                        _buildInfoItem(
                          context,
                          'Origin',
                          character.origin.name,
                          Icons.public,
                        ),
                        _buildInfoItem(
                          context,
                          'Location',
                          character.location.name,
                          Icons.place,
                        ),
                      ]),
                      const SizedBox(height: 20),
                      _buildInfoSection(context, 'Other Information', [
                        _buildInfoItem(
                          context,
                          'Episodes',
                          character.episode.length.toString(),
                          Icons.movie,
                        ),
                        _buildInfoItem(
                          context,
                          'Created',
                          _formatDate(character.created),
                          Icons.calendar_today,
                        ),
                      ]),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusBadge(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: _getStatusColor(character.status),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        character.status.toUpperCase(),
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.2,
        ),
      ),
    );
  }

  Widget _buildInfoSection(
    BuildContext context,
    String title,
    List<Widget> children,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: MyColors.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Divider(color: MyColors.divider, thickness: 1),
        const SizedBox(height: 10),
        ...children,
      ],
    );
  }

  Widget _buildInfoItem(
    BuildContext context,
    String title,
    String value,
    IconData icon,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20, color: MyColors.secondary),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: MyColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyLarge?.copyWith(color: MyColors.textPrimary),
                ),
              ],
            ),
          ),
        ],
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

  String _formatDate(String dateString) {
    try {
      final date = DateTime.parse(dateString);
      return '${date.day}/${date.month}/${date.year}';
    } catch (e) {
      return dateString;
    }
  }
}
