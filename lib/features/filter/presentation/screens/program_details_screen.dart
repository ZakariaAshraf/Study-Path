import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_path/core/utils/screen_util.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../core/utils/extenstions.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../favorite/cubit/favourite_cubit.dart';
import '../../../home/data/model/program_model.dart';
import '../widgets/feature_tile.dart';
import '../widgets/link_previewer.dart';

class ProgramDetailsScreen extends StatelessWidget {
  final ProgramModel program;

  const ProgramDetailsScreen({super.key, required this.program});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(program.programName), centerTitle: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Stack(
                children: [
                  LinkPreviewer(
                    url: program.websiteLink ?? program.applyLink,
                    // imageHeight: 200,
                    // imageWidth: 200,
                  ),
                  if (program.moiAccepted)
                    Positioned(
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
                    ),
                  Positioned(
                    right: 10,
                    top: 10,
                    child: BlocBuilder<FavouriteCubit, FavouriteState>(
                      builder: (context, state) {
                        final isFavorite = context
                            .read<FavouriteCubit>()
                            .isFavorite(program.id ?? "");
                        return InkWell(
                          onTap: () async {
                            await context.read<FavouriteCubit>().addToFavourite(
                              program,
                            );
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    isFavorite
                                        ? l10n.removedFromBookmarks
                                        : l10n.addedToSavedPrograms,
                                  ),
                                  duration: const Duration(seconds: 1),
                                ),
                              );
                            }
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
                            child: Icon(
                              isFavorite
                                  ? Icons.bookmark
                                  : Icons.bookmark_border,
                              color: isFavorite ? Colors.white : Colors.black,
                              size: 25,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8.h(context)),
              Text(program.universityName, style: theme.titleLarge),
              SizedBox(height: 5.h(context)),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(Icons.pin_drop, color: Colors.red),
                  SizedBox(width: 10.w(context)),
                  Text(
                    program.country,
                    style: theme.bodyMedium!.copyWith(color: Colors.grey),
                  ),
                ],
              ),
              SizedBox(height: 8.h(context)),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        padding: const EdgeInsets.all(8.0),
                        width: 110.w(context),
                        height: 140.h(context),
                        // margin: EdgeInsets.only(left: 7),
                        decoration: BoxDecoration(
                          border: BoxBorder.all(color: Colors.grey.shade300),
                          // color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.transparent,
                              child: Icon(
                                CupertinoIcons.money_dollar,
                                color: Colors.green,
                              ),
                            ),
                            SizedBox(height: 10.h(context)),
                            Text(
                              "TUITION",
                              style: theme.bodySmall!.copyWith(
                                fontSize: 14.sp(context),
                              ),
                            ),
                            SizedBox(height: 2.h(context)),
                            Text(
                              "${program.tuitionFees ?? l10n.notAvailable}",
                              style: theme.titleMedium!.copyWith(
                                fontSize: 17.sp(context),
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        padding: const EdgeInsets.all(8.0),
                        // width: 110.w(context),
                        height: 140.h(context),
                        // margin: EdgeInsets.only(left: 7),
                        decoration: BoxDecoration(
                          border: BoxBorder.all(color: Colors.grey.shade300),
                          // color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.transparent,
                              child: Icon(
                                CupertinoIcons.globe,
                                color: Colors.blueAccent,
                              ),
                            ),
                            SizedBox(height: 10.h(context)),
                            Text(
                              l10n.language,
                              style: theme.bodySmall!.copyWith(
                                fontSize: 14.sp(context),
                              ),
                            ),
                            SizedBox(height: 2.h(context)),
                            Text(
                              program.language ?? l10n.countryLanguage,
                              style: theme.titleMedium!.copyWith(
                                fontSize: 17.sp(context),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        padding: const EdgeInsets.all(8.0),
                        // width: 110.w(context),
                        height: 140.h(context),
                        // margin: EdgeInsets.only(left: 7),
                        decoration: BoxDecoration(
                          border: BoxBorder.all(color: Colors.grey.shade300),
                          // color: Colors.grey.shade600 ,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.transparent,
                              child: Icon(
                                CupertinoIcons.time_solid,
                                color: Colors.orange,
                              ),
                            ),
                            SizedBox(height: 10.h(context)),
                            Text(
                              l10n.duration,
                              style: theme.bodySmall!.copyWith(
                                fontSize: 14.sp(context),
                              ),
                            ),
                            SizedBox(height: 2.h(context)),
                            Text(
                              program.duration ?? l10n.notAvailable,
                              style: theme.titleMedium!.copyWith(
                                fontSize: 17.sp(context),
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 8.h(context)),
              _buildAboutSection(
                city: program.city,
                deadline: program.deadline,
                intake: program.intake,
                isPublicUniversity: program.isPublicUniversity,
                context: context,
              ),
              SizedBox(height: 8.h(context)),
              _buildAdmissionRequirementsSection(
                context: context,
                country: program.country,
                germanLevel: program.germanLevel,
                ieltsRequirement: program.ieltsRequirement,
                toeflRequirement: program.toeflRequirement,
                moiPolicy: program.moiPolicy,
                requiresAPS: program.requiresAps,
                requiresBlockedAccount: program.requiresBlockedAccount,
                moiAccepted: program.moiAccepted,
              ),
              SizedBox(height: 30.h(context)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 1,
                    child: CustomButton(
                      textStyle: theme.titleMedium!.copyWith(
                        color: Colors.black,
                      ),
                      title: l10n.officialWebsite,
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
                      textStyle: theme.titleMedium!.copyWith(
                        color: Colors.white,
                      ),
                      title: l10n.viewPortal,
                      onTap: () async {
                        await launchUrls(program.applyLink);
                      },
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAboutSection({
    String? deadline,
    String? city,
    String? intake,
    bool? isPublicUniversity,
    required BuildContext context,
  }) {
    var theme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text("About University", style: theme.titleLarge),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  // Icon(Icons.location_city,color: Colors.blueAccent,),
                  Text(
                    "📍 ",
                    style: theme.bodySmall!.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 17.sp(context),
                    ),
                  ),
                  Text(
                    "City:",
                    style: theme.bodySmall!.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 15.sp(context),
                    ),
                  ),
                  SizedBox(width: 3.w(context)),
                  Text(city ?? "Not available check website"),
                ],
              ),
              Row(
                children: [
                  // Icon(CupertinoIcons.time,color: Colors.red,),
                  Text(
                    "📅 ",
                    style: theme.bodySmall!.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 17.sp(context),
                    ),
                  ),
                  Text(
                    "Deadline:",
                    style: theme.bodySmall!.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 15.sp(context),
                    ),
                  ),
                  SizedBox(width: 6.w(context)),
                  Text(deadline ?? "Not available check website"),
                ],
              ),
              Row(
                children: [
                  // Icon(CupertinoIcons.wind,color: Colors.green,),
                  Text(
                    "🎓 ",
                    style: theme.bodySmall!.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 17.sp(context),
                    ),
                  ),
                  Text(
                    "Intake:",
                    style: theme.bodySmall!.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 15.sp(context),
                    ),
                  ),
                  SizedBox(width: 6.w(context)),
                  Text(intake ?? "Not available check website"),
                ],
              ),
              if (isPublicUniversity != null)
                Row(
                  children: [
                    // Icon(isPublicUniversity ?Icons.public:Icons.public_off,color: Colors.blue,),
                    Text(
                      "University:",
                      style: theme.bodySmall!.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 15.sp(context),
                      ),
                    ),
                    SizedBox(width: 6.w(context)),
                    Text(
                      isPublicUniversity
                          ? "Public University"
                          : "Private University",
                    ),
                  ],
                ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAdmissionRequirementsSection({
    double? ieltsRequirement,
    double? toeflRequirement,
    String? germanLevel,
    bool? requiresBlockedAccount,
    bool? requiresAPS,
    bool? moiAccepted,
    String? moiPolicy,
    String? country,
    required BuildContext context,
  }) {
    final l10n = AppLocalizations.of(context)!;
    var theme = Theme.of(context).textTheme;
    String languageSubtitle;
    if (country == "Austria") {
      if (ieltsRequirement != null && toeflRequirement != null) {
        languageSubtitle =
            "IELTS: $ieltsRequirement or TOEFL: $toeflRequirement";
      } else if (ieltsRequirement != null) {
        languageSubtitle = "IELTS: $ieltsRequirement";
      } else if (toeflRequirement != null) {
        languageSubtitle = "TOEFL: $toeflRequirement";
      } else {
        languageSubtitle = "English requirements not available";
      }
    } else {
      languageSubtitle = germanLevel ?? "German level not available";
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(l10n.admissionRequirements, style: theme.titleLarge),
        Column(
          children: [
            FeatureTile(
              title: "Language Level",
              subTitle: languageSubtitle,
              iconData: Icons.translate,
              iconColor: Colors.blueAccent,
            ),
            SizedBox(height: 4.h(context)),
            country == "German"
                ? FeatureTile(
                    iconColor: Colors.green,
                    iconData: Icons.account_balance_wallet_outlined,
                    title: "Requires block account",
                    subTitle: requiresBlockedAccount == true ? "Yes" : "No",
                  )
                : SizedBox.shrink(),
            SizedBox(height: 4.h(context)),
            country == "German"
                ? FeatureTile(
                    iconColor: Colors.red,
                    iconData: Icons.policy_outlined,
                    title: "Requires APS certificate",
                    subTitle: "${requiresAPS ?? "Not available"}",
                  )
                : SizedBox.shrink(),
            SizedBox(height: 4.h(context)),
            if (moiAccepted == true)
              FeatureTile(
                iconColor: Colors.redAccent,
                iconData: Icons.policy_outlined,
                title: "MOI policy",
                subTitle: moiPolicy ?? "Not available",
              ),
          ],
        ),
      ],
    );
  }
}
