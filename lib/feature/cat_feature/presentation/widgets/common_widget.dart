import 'package:demo_2/feature/cat_feature/domain/entity/cat_entity.dart';
import 'package:flutter/material.dart';

class CustomCatWidget {
  Widget getCatTile(CatEntity cat) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.network(
          cat.url, // map this properly in model
          height: 200,
          width: double.infinity,
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => const Icon(Icons.error),
        ),
      ),
    );
  }
}
