import 'package:demo_2/core/di/sevice_locator.dart';
 import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';

import 'feature/product_feature/presentation/bloc/product_bloc.dart';
import 'feature/product_feature/presentation/screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox("product_box");
  await ServiceLocator.initDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider(create: (_) => sl<ProductBloc>(), child: HomeScreen()),
    );
  }
}
