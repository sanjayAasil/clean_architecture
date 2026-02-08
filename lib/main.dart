import 'package:demo_2/core/di/sevice_locator.dart';
import 'package:demo_2/feature/cat_feature/presentation/bloc/cat_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'feature/product_feature/presentation/bloc/product_bloc.dart';
import 'feature/product_feature/presentation/screens/home_screen.dart';

void main() async {
  print("main: init");
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox("product_box");
  await Hive.openBox("cats");
  await ServiceLocator.initDependencies();
  runApp(const MyApp());
  print('main: end');
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => sl<ProductBloc>()),
        BlocProvider(create: (_) => sl<CatBloc>()),
      ],
      child: MaterialApp(debugShowCheckedModeBanner: false, home: HomeScreen()),
    );
  }
}
