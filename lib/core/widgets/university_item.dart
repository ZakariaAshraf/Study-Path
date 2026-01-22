import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_path/core/utils/screen_util.dart';
import 'package:study_path/core/widgets/custom_button.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../features/favorite/cubit/favourite_cubit.dart';
import '../../features/filter/presentation/screens/university_details_screen.dart';
import '../../features/filter/presentation/widgets/link_previewer.dart';
import '../../features/home/data/model/program_model.dart';
import '../utils/app_colors.dart';
import '../utils/extenstions.dart';

class UniversityItem extends StatelessWidget {
  final ProgramModel program;

  const UniversityItem({super.key, required this.program});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => UniversityDetailsScreen(program: program),));
      },
      child: Container(
        padding: EdgeInsets.all(12),
        // width: context.size?.width,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Stack(
              children: [
                LinkPreviewer(url: program.websiteLink ?? program.applyLink),
                ?program.moiAccepted
                    ? Positioned(
                        left: 10,
                        top: 10,
                        child: Container(
                          // height: 40,
                          // width: 64.w(context),
                          padding: EdgeInsets.all(7),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            // shape: BoxShape.circle,
                            color: Colors.black.withOpacity(0.2),
                          ),
                          child: Row(
                            children: [
                              Text(
                                "MOI accepted",
                                style: theme.bodyMedium!.copyWith(
                                  color: Colors.green,
                                ),
                              ),
                              SizedBox(width: 5),
                              Icon(
                                Icons.key_outlined,
                                color: Colors.green,
                                size: 30,
                              ),
                            ],
                          ),
                        ),
                      )
                    : null,
                Positioned(
                  right: 10,
                  top: 10,
                  child: BlocBuilder<FavouriteCubit, FavouriteState>(
                    builder: (context, state) {
                      final isFavorite = context
                          .read<FavouriteCubit>()
                          .isFavorite(program.id ?? "");
                      return InkWell(
                        onTap: () {
                          context.read<FavouriteCubit>().addToFavourite(program);
                          isFavorite
                              ? ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text("removed from saved meals"),
                                  ),
                                )
                              : ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text("added to saved meals"),
                                  ),
                                );
                        },
                        child: Container(
                          // height: 40,
                          // width: 64.w(context),
                          padding: EdgeInsets.all(7),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            // shape: BoxShape.circle,
                            color: Colors.white.withOpacity(0.1),
                          ),
                          child: Icon(isFavorite ?Icons.bookmark :
                          Icons.bookmark_border,
                            color: isFavorite
                            ? AppColors.primary
                            : Colors.black,
                            size: 25,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Positioned(
                  right: 10,
                  bottom: 10,
                  child: Container(
                    // height: 40,
                    // width: 64.w(context),
                    padding: EdgeInsets.all(7),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      // shape: BoxShape.circle,
                      color: Colors.white.withOpacity(0.1),
                    ),
                    // child: Text("${program.degreeType}",),
                    child: Text(
                      "MSC",
                      style: theme.titleMedium!.copyWith(color: Colors.black),
                    ),
                  ),
                ),
              ],
            ),
            Text(program.programName, style: theme.titleLarge),
            Text(
              program.universityName,
              style: theme.titleMedium!.copyWith(color: Colors.grey),
            ),
            // SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 1,
                    child: CustomButton(
                      title: "Official Website",
                      isInvert: false,
                      onTap: () async {
                        await launchUrls(
                          program.websiteLink ?? program.applyLink,
                        );
                      },
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(width: 12.w(context)),
                  Expanded(
                    flex: 1,
                    child: CustomButton(
                      title: "View Portal",
                      onTap: () async {
                        await launchUrls(program.applyLink);
                      },
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Image.network(
//   height: 250,
//   width: double.maxFinite,
//   // alignment: Alignment.center,
//   "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQVNer1ZryNxWVXojlY9Hoyy1-4DVNAmn7lrg&s",
//   fit: BoxFit.cover,
// ),
