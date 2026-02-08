import 'package:demo_2/feature/cat_feature/presentation/screens/cat_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/product_bloc.dart';
import '../bloc/product_event.dart';
import '../bloc/product_state.dart';
import '../widgets/custom_widgets/custom_home_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ProductBloc>().add(GetProductsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Products"),
        centerTitle: true,
        actions: [
          ElevatedButton(
            onPressed: () {
              context.read<ProductBloc>().add(GetProductsEvent());
            },
            child: Text('refresh'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(
                context,
              ).push(MaterialPageRoute(builder: (context) => CatScreen()));
            },
            child: Text('Next page'),
          ),
        ],
      ),
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          if (state is ProductLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is ProductLoaded) {
            if (state.products.isEmpty) {
              return const Center(child: Text("No products found"));
            }

            return ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: state.products.length,
              itemBuilder: (context, index) {
                final product = state.products[index];
                return CustomHomeWidget().getProductTile(product);
              },
            );
          }

          if (state is ProductError) {
            return Center(
              child: Text(
                state.error,
                style: const TextStyle(color: Colors.red),
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
