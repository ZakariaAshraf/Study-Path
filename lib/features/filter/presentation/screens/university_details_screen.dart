import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:study_path/core/utils/screen_util.dart';

import '../../../../core/utils/extenstions.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../home/data/model/program_model.dart';
import '../widgets/link_previewer.dart';

class UniversityDetailsScreen extends StatelessWidget {
  final ProgramModel program;

  const UniversityDetailsScreen({super.key, required this.program});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(title: Text("University Details"), centerTitle: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              LinkPreviewer(
                url: program.websiteLink ?? program.applyLink,
                imageHeight: 200,
                imageWidth: 200,
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
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CircleAvatar(
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
                            Text("${program.tuitionFees ?? "NOT AVAILABLE"}", style: theme.titleMedium!.copyWith(fontSize: 15),overflow: TextOverflow.ellipsis,),
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
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              child: Icon(
                                CupertinoIcons.globe,
                                color: Colors.blueAccent,
                              ),
                            ),
                            SizedBox(height: 10.h(context)),
                            Text(
                              "LANGUAGE",
                              style: theme.bodySmall!.copyWith(
                                fontSize: 14.sp(context),
                              ),
                            ),
                            SizedBox(height: 2.h(context)),
                            Text(
                              program.moiAccepted ? "English" : "Country Language",
                              style: theme.titleMedium!.copyWith(fontSize: 15),
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
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              child: Icon(
                                CupertinoIcons.time_solid,
                                color: Colors.orange,
                              ),
                            ),
                            SizedBox(height: 10.h(context)),
                            Text(
                              "DURATION",
                              style: theme.bodySmall!.copyWith(
                                fontSize: 14.sp(context),
                              ),
                            ),
                            SizedBox(height: 2.h(context)),
                            Text("${program.tuitionFees ?? "NOT AVAILABLE"}",style: theme.titleMedium!.copyWith(fontSize: 15),overflow: TextOverflow.ellipsis,),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 8.h(context)),
              Text("Admission Requirements", style: theme.titleLarge),
              SizedBox(height: 30.h(context)),
              Row(
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
            ],
          ),
        ),
      ),
    );
  }
}
