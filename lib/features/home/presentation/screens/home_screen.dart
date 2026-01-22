import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:study_path/core/cache/cache_helper.dart';
import 'package:study_path/core/widgets/custom_button.dart';
import 'package:study_path/features/home/presentation/widgets/saved_program_section.dart';
import 'package:study_path/features/home/presentation/widgets/user_info_section.dart';

import '../widgets/search_section.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;
    return Scaffold(
      body: ListView(
        children: [
          UserInfoSection(),
          SizedBox(height: 10),
          SearchSection(),
          SizedBox(height: 10),
          // CustomButton(title: "title", onTap: () async{
          //   await CacheHelper.clearAllData();
          // },),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                border: BoxBorder.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(20),
              ),
              child: ListTile(
                leading: IconButton(
                  icon: Icon(Icons.school_outlined),
                  onPressed: () {},
                  color: Colors.purple,
                ),
                subtitle: Text(
                  "Direct Scholarship Applications! Stay tuned",
                  style: theme.bodySmall!.copyWith(
                    fontSize: 15,
                  ),
                ),
                title: Text(
                  "COMING SOON",
                  style: theme.titleMedium!.copyWith(
                    color: Colors.purple,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(child: SavedProgramSection()),
        ],
      ),
    );
  }
}
