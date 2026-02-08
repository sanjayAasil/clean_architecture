import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/common/debouncer.dart';
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
  final Debouncer _debouncer = Debouncer(milliseconds: 300);

  int page = 0;
  bool isFetching = false;

  @override
  void initState() {
    super.initState();
    _fetchInitial();
    controller.addListener(_onScroll);
  }

  void _fetchInitial() {
    page = 0;
    context.read<CatBloc>().add(GetCatEvent(page: page));
  }

  void _onScroll() {
    if (!controller.hasClients || isFetching) return;

    final threshold = controller.position.maxScrollExtent - 200;

    if (controller.position.pixels >= threshold) {
      _debouncer.run(() {
        if (!isFetching) {
          isFetching = true;
          page++;

          context.read<CatBloc>().add(
            GetCatEvent(page: page, isLoadMore: true),
          );
        }
      });
    }
  }

  @override
  void dispose() {
    controller.dispose();
    _debouncer.dispose();
    super.dispose();
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
              page = 0;
              isFetching = false;

              context.read<CatBloc>().add(GetCatEvent(page: page));
            },

            child: const Text('Refresh'),
          ),
        ],
      ),
      body: BlocBuilder<CatBloc, CatState>(
        builder: (context, state) {
          print("hyfuyfyyf $state");
          if (state is CatLoaded) {
            isFetching = state.isLoadingMore;

            return GridView.builder(
              controller: controller,
              padding: const EdgeInsets.all(12),
              itemCount: state.cats.length + (state.isLoadingMore ? 1 : 0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
              ),
              itemBuilder: (context, index) {
                if (index == state.cats.length) {
                  return const Center(
                    child: CircularProgressIndicator(color: Colors.red),
                  );
                }

                final cat = state.cats[index];
                return CustomCatWidget().getCatTile(cat, index);
              },
            );
          }

          return SizedBox();
        },
      ),
    );
  }
}
