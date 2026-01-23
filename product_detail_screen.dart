import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../main.dart'; // gives access to Item & CartModel

class ProductDetailScreen extends StatelessWidget {
  final Item item;

  const ProductDetailScreen({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    // Wrap the whole page in a Theme so THIS product controls colors/fonts.
    return Theme(
      data: Theme.of(context).copyWith(
        scaffoldBackgroundColor: item.detailBackgroundColor,
        appBarTheme: AppBarTheme(
          backgroundColor: item.cardColor,
          foregroundColor: item.textColor, // title + back button color
        ),
        textTheme: Theme.of(context).textTheme.apply(
          bodyColor: item.textColor,
          displayColor: item.textColor,
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: Text(item.name),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AspectRatio(
                aspectRatio: 1 / 1,
                child: Image.asset(
                  item.imageAsset,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.name,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      item.priceText,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      item.description,
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton(
                        onPressed: () {
                          context.read<CartModel>().add(item);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Added to cart')),
                          );
                        },
                        child: const Text('Add to Cart'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
