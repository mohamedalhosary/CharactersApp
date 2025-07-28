// 1. Updated Character Screen with responsive design and new colors
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_breaking/business_logic/cubit/characters_cubit.dart';
import 'package:flutter_breaking/business_logic/cubit/characters_state.dart';
import 'package:flutter_breaking/core/constants/colors.dart';
import 'package:flutter_breaking/data/models/characters.dart';
import 'package:flutter_breaking/presentaiton/widgets/character_item.dart';

class CharacterScreen extends StatefulWidget {
  const CharacterScreen({super.key});

  @override
  State<CharacterScreen> createState() => _CharacterScreenState();
}

class _CharacterScreenState extends State<CharacterScreen> {
  final ScrollController _scrollController = ScrollController();
  bool _isLoading = false;
  String _searchText = '';
  String _statusFilter = 'All';

  @override
  void initState() {
    super.initState();
    _loadInitialCharacters();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _loadInitialCharacters() {
    BlocProvider.of<CharactersCubit>(context).getAllCharacters();
  }

  void _scrollListener() {
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent * 0.8 &&
        !_isLoading) {
      _loadMoreCharacters();
    }
  }

  void _loadMoreCharacters() {
    setState(() => _isLoading = true);
    BlocProvider.of<CharactersCubit>(context).getAllCharacters().then((_) {
      if (mounted) setState(() => _isLoading = false);
    });
  }

  void _applyFilters() {
    BlocProvider.of<CharactersCubit>(
      context,
    ).filterCharacters(search: _searchText, status: _statusFilter);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.background,
      appBar: AppBar(
        title: const Text(
          'Breaking Bad Characters',
          style: TextStyle(color: MyColors.textOnPrimary),
        ),
        backgroundColor: MyColors.primary,
        actions: [_buildStatusFilter()],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              _buildSearchField(),
              const SizedBox(height: 12),
              Expanded(child: _buildCharacterList()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusFilter() {
    return PopupMenuButton<String>(
      icon: Icon(Icons.filter_list, color: MyColors.textOnPrimary),
      onSelected: (value) {
        setState(() => _statusFilter = value);
        _applyFilters();
      },
      itemBuilder: (context) => [
        PopupMenuItem(
          value: 'All',
          child: Text('All', style: TextStyle(color: MyColors.textPrimary)),
        ),
        PopupMenuItem(
          value: 'Alive',
          child: Text('Alive', style: TextStyle(color: MyColors.success)),
        ),
        PopupMenuItem(
          value: 'Dead',
          child: Text('Dead', style: TextStyle(color: MyColors.error)),
        ),
        PopupMenuItem(
          value: 'Unknown',
          child: Text('Unknown', style: TextStyle(color: MyColors.warning)),
        ),
      ],
    );
  }

  Widget _buildSearchField() {
    return TextField(
      decoration: InputDecoration(
        hintText: 'Search...',
        prefixIcon: Icon(Icons.search, color: MyColors.textSecondary),
        filled: true,
        fillColor: MyColors.surface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16),
      ),
      onChanged: (value) {
        setState(() => _searchText = value);
        _applyFilters();
      },
    );
  }

  Widget _buildCharacterList() {
    return BlocBuilder<CharactersCubit, CharactersState>(
      builder: (context, state) {
        if (state is CharactersLoading) {
          return _buildLoadingIndicator();
        } else if (state is CharactersLoaded) {
          return _buildCharacterGrid(state.filteredCharacters);
        } else if (state is CharactersError) {
          return _buildErrorWidget(state.message);
        } else {
          return _buildLoadingIndicator();
        }
      },
    );
  }

  Widget _buildCharacterGrid(List<Character> characters) {
    if (characters.isEmpty) {
      return Center(
        child: Text(
          'No characters found',
          style: TextStyle(color: MyColors.textSecondary),
        ),
      );
    }

    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        if (notification is ScrollEndNotification &&
            _scrollController.position.pixels >=
                _scrollController.position.maxScrollExtent * 0.8) {
          _loadMoreCharacters();
        }
        return false;
      },
      child: GridView.builder(
        controller: _scrollController,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: _calculateCrossAxisCount(context),
          childAspectRatio: 0.7,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
        ),
        itemCount: characters.length + (_isLoading ? 1 : 0),
        itemBuilder: (context, index) {
          if (index >= characters.length) {
            return Center(
              child: CircularProgressIndicator(color: MyColors.primary),
            );
          }
          return CharacterItem(character: characters[index]);
        },
      ),
    );
  }

  int _calculateCrossAxisCount(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width > 800) return 4;
    if (width > 600) return 3;
    return 2;
  }

  Widget _buildLoadingIndicator() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(color: MyColors.primary),
          const SizedBox(height: 16),
          Text(
            'Loading characters...',
            style: TextStyle(color: MyColors.primary, fontSize: 16),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorWidget(String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, size: 48, color: MyColors.error),
          const SizedBox(height: 16),
          Text(message, style: TextStyle(color: MyColors.error)),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: _loadInitialCharacters,
            style: ElevatedButton.styleFrom(backgroundColor: MyColors.primary),
            child: Text(
              'Retry',
              style: TextStyle(color: MyColors.textOnPrimary),
            ),
          ),
        ],
      ),
    );
  }
}
