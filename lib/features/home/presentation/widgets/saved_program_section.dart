import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_path/core/widgets/university_card.dart';
import 'package:study_path/features/favorite/cubit/favourite_cubit.dart';
import 'package:study_path/features/favorite/views/favourite_screen.dart';
import 'package:study_path/features/home/data/model/program_model.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/widgets/default_message_card.dart';

class SavedProgramSection extends StatelessWidget {
  const SavedProgramSection({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme
        .of(context)
        .textTheme;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Saved Programs", style: theme.titleLarge),
              TextButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => FavouriteScreen(),));
                },
                child: Text(
                  "See All",
                  style: theme.titleMedium!.copyWith(color: Colors.blue),
                ),
              ),
            ],
          ),
        ),
        BlocBuilder<FavouriteCubit, FavouriteState>(
          builder: (context, state) {
            if (state is FavouriteInitial) {
              return const DefaultMessageCard(
                sign: '0_0',
                title: "You don't save any programmes",
                subTitle: "favorite",
              );
            } else if (state is FavouriteLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is FavouriteSuccess) {
              return SizedBox(
                height: 200, width: double.infinity,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: state.programmes.isEmpty ? 0 : 2,
                  // itemCount: 3,
                  itemBuilder: (context, index) => UniversityCard(program: state.programmes[index],),
                ),
              );
            }else {
              return Center(
                child: ElevatedButton(
                  onPressed: () => context.read<FavouriteCubit>().loadFavorites(),
                  child: const Text("Reload page"),
                ),
              );
            }
          },
        ),
      ],
    );
  }
}
