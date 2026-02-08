import 'package:cached_network_image/cached_network_image.dart';
import 'package:demo_2/feature/cat_feature/domain/entity/cat_entity.dart';
import 'package:flutter/material.dart';

class CustomCatWidget {
  Widget getCatTile(CatEntity cat, int index) {
    return Stack(
      children: [
        Card(
          margin: const EdgeInsets.only(bottom: 12),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: CachedNetworkImage(
              imageUrl: cat.url,
              // map this properly in model
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
              errorWidget: (_, __, ___) => const Icon(Icons.error),
            ),
          ),
        ),
        Container(
          height: 20,
          width: 20,
          color: Colors.white,
          child: Text("${index + 1}"),
        ),
      ],
    );
  }
}
