import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_path/core/widgets/university_card.dart';
import '../../../core/widgets/default_message_card.dart';
import '../cubit/favourite_cubit.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({super.key});

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Bookmarks"), centerTitle: true),
      body: BlocBuilder<FavouriteCubit, FavouriteState>(
        builder: (context, state) {
          if (state is FavouriteInitial) {
            return const DefaultMessageCard(
              sign: '0_0',
              title: "You don't like anything ",
              subTitle: "favorite",
            );
          } else if (state is FavouriteLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is FavouriteSuccess) {
            return Expanded(
              child: GridView.builder(
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  return UniversityCard(program:state.programmes[index]);
                },
                itemCount: state.programmes.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 5,

                  childAspectRatio: 0.75,
                ),
              ),
            );
          } else {
            return Center(
              child: ElevatedButton(
                onPressed: () => context.read<FavouriteCubit>().loadFavorites(),
                child: const Text("Reload page"),
              ),
            );
          }
        },
      ),
    );
  }
}
