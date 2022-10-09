import 'package:flutter/material.dart';

class FavoriteToggler extends StatelessWidget {
  const FavoriteToggler({
    super.key,
    required this.onPressedFavorite,
    required this.isFavorite,
  });

  final VoidCallback onPressedFavorite;
  final bool isFavorite;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressedFavorite,
      icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_outline),
    );
  }
}
