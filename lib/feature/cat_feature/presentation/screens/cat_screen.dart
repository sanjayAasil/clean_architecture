import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/cat_bloc.dart';
import '../bloc/cat_event.dart';
import '../bloc/cat_state.dart';
import '../widgets/common_widget.dart';

class CatScreen extends StatefulWidget {
  const CatScreen({super.key});

  @override
  State<CatScreen> createState() => _CatScreenState();
}

class _CatScreenState extends State<CatScreen> {
  final ScrollController controller = ScrollController();

  @override
  void initState() {
    controller.addListener(() {
      if (controller.position.atEdge) {
        if (controller.position.pixels != 0) {
          // ✅ Reached bottom
          print("Reached end of the list");
          context.read<CatBloc>();
        }
      }
    });
    super.initState();
    context.read<CatBloc>().add(GetCatEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cats"),
        centerTitle: true,
        actions: [
          ElevatedButton(
            onPressed: () {
              context.read<CatBloc>().add(GetCatEvent());
            },
            child: const Text('Refresh'),
          ),
        ],
      ),
      body: BlocBuilder<CatBloc, CatState>(
        builder: (context, state) {
          if (state is CatLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is CatLoaded) {
            if (state.cats.isEmpty) {
              return const Center(child: Text("No cats found"));
            }

            return ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: state.cats.length,
              controller: controller,
              itemBuilder: (context, index) {
                final cat = state.cats[index];
                return CustomCatWidget().getCatTile(cat);
              },
            );
          }

          if (state is CatError) {
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
