import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:teslo_shop/features/products/presentation/providers/product_provider.dart';

class ProductSreen extends ConsumerStatefulWidget {

  final String productId;

  const ProductSreen({super.key, required this.productId});

  @override
  ConsumerState createState() => ProductSreenState();
}

class ProductSreenState extends ConsumerState<ProductSreen> {

  @override
  void initState() {
    super.initState();

    ref.read(productProvider(widget.productId).notifier);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Producto'),
      ),
      body: Center(
        child: Text(widget.productId),
      )
    );
  }
}