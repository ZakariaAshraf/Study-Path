import 'package:flutter/material.dart';
import 'package:study_path/core/utils/screen_util.dart';
import 'package:study_path/features/filter/presentation/screens/program_details_screen.dart';

import '../../features/filter/presentation/widgets/link_previewer.dart';
import '../../features/home/data/model/program_model.dart';

class UniversityCard extends StatelessWidget {
  final ProgramModel program;

  const UniversityCard({super.key, required this.program});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => ProgramDetailsScreen(program: program),));
      },
      child: Container(
        width: 180.w(context),
        height: 170.h(context),
        padding: EdgeInsets.only(left: 10,right: 10),
        // width: context.size?.width,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Stack(
              children: [
                LinkPreviewer(url: program.websiteLink ?? program.applyLink,imageHeight: 140,imageWidth: 230,),
                // Positioned(
                //   right: 10,
                //   top: 10,
                //   child: Container(
                //     // height: 40,
                //     // width: 64.w(context),
                //     padding: EdgeInsets.all(7),
                //     decoration: BoxDecoration(
                //       borderRadius: BorderRadius.circular(25),
                //       // shape: BoxShape.circle,
                //       color: Colors.white.withOpacity(0.1),
                //     ),
                //     child: Icon(
                //       Icons.favorite_border_outlined,
                //       color: Colors.black,
                //       size: 15,
                //     ),
                //   ), ),
                Positioned(
                  // right: 10,
                  bottom: 10,
                  left: 5,
                  child: Container(
                    // height: 40,
                    // width: 64.w(context),
                    padding: EdgeInsets.all(7),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      // shape: BoxShape.circle,
                      color: Colors.grey.withOpacity(0.3),
                    ),
                    // child: Text("${program.degreeType}",),
                    child: Text(program.degreeType=="Master" ?"MSC" : "BSC",style: theme.titleSmall!.copyWith(color: Colors.green)),
                  ), ),
              ],
            ),
            Text(program.programName, style: theme.titleMedium!.copyWith(fontSize: 14)),
            Text(program.universityName, style: theme.titleSmall!.copyWith(color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}
