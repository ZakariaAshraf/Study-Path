import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_path/core/utils/screen_util.dart';
import 'package:study_path/core/widgets/custom_button.dart';
import 'package:study_path/features/home/presentation/screens/search_results_screen.dart';

import '../../../home/presentation/cubit/programs_cubit.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  List<String> degreeTypes = ["Bachelor", "Master", "PhD"];

  // List<String> destinations = ["Bachelor", "Master's", "PhD"];
  List<String> languages = ["English", "German", "France", "Arabic"];
  String? _selectedDestination;

  bool _moiValue = false;
  String? _selectedLanguage;
  String? _selectedDegree;
  String? _selectedField;

  @override
  void initState() {
    // _selected = List.generate(languages.length, (_) => false);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Program Filter"),
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                _selectedDestination = null;
                _selectedField = null;
                _selectedDegree = null;
                _selectedLanguage = null;
                _moiValue = false;
              });
            },
            child: Text("Reset",),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text("Filters", style: theme.titleLarge!.copyWith(fontSize: 30)),
              SizedBox(height: 30),
              Text("Where do you want to study ?", style: theme.titleLarge),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(style: BorderStyle.none),
                  ),
                ),
                hint: Row(
                  children: [
                    Icon(CupertinoIcons.globe),
                    SizedBox(width: 10),
                    Text("Select Destination"),
                  ],
                ),
                items: [
                  DropdownMenuItem(value: "German", child: Text("German")),
                  DropdownMenuItem(value: "Austria", child: Text("Austria")),
                  DropdownMenuItem(
                    value: "Other European Countries",
                    child: Text("Other European Countries"),
                  ),
                ],
                onChanged: (String? value) {
                  // هام جداً: تحديث الحالة عند الاختيار
                  setState(() {
                    _selectedDestination = value;
                  });
                },              ),
              SizedBox(height: 20),
              Text("Academics", style: theme.titleLarge),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(style: BorderStyle.none),
                  ),
                ),
                hint: Row(
                  children: [
                    Icon(Icons.school_outlined),
                    SizedBox(width: 10),
                    Text("Field of study"),
                  ],
                ),
                items: [
                  DropdownMenuItem(
                    value: "Computer Science",
                    child: Text("Computer Science"),
                  ),
                  DropdownMenuItem(value: "Business", child: Text("Business")),
                ],
                onChanged: (String? value) {
                  _selectedField = value;
                },
              ),
              SizedBox(height: 20),
              Text(
                "degree type",
                style: theme.titleMedium!.copyWith(color: Colors.grey),
              ),
              SizedBox(
                height: 60,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    SizedBox(width: 8.w(context)),
                    ...degreeTypes.map((dest) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                        child: FilterChip(
                          selectedColor: Colors.black,
                          backgroundColor: Colors.white,
                          side: BorderSide.none,
                          showCheckmark: false,
                          label: Text(
                            dest,
                            style: TextStyle(
                              color: _selectedDegree == dest
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                          selected: _selectedDegree == dest,
                          onSelected: (selected) {
                            setState(() {
                              _selectedDegree = selected ? dest : null;
                            });
                            if (selected) {}
                          },
                          labelStyle: TextStyle(
                            decoration: _selectedDegree == dest
                                ? TextDecoration.none
                                : TextDecoration.none,
                            fontSize: _selectedDegree == dest
                                ? 18.sp(context)
                                : 13.sp(context),
                            color: _selectedDegree == dest
                                ? Colors.white
                                : Colors.black,
                          ),
                        ),
                      );
                    }),
                    SizedBox(width: 8.w(context)),
                  ],
                ),
              ),
              Text("Requirements", style: theme.titleLarge),
              SizedBox(height: 10),
              Text(
                "LANGUAGE OF INSTRUCTIONS",
                style: theme.titleMedium!.copyWith(color: Colors.grey),
              ),
              SizedBox(
                height: 60,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    SizedBox(width: 8.w(context)),
                    ...languages.map((dest) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                        child: FilterChip(
                          selectedColor: Colors.black,
                          backgroundColor: Colors.white,
                          side: BorderSide.none,
                          label: Text(
                            dest,
                            style: TextStyle(
                              color: _selectedLanguage == dest
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                          selected: _selectedLanguage == dest,
                          onSelected: (selected) {
                            setState(() {
                              _selectedLanguage = selected ? dest : null;
                            });
                            if (selected) {}
                          },
                          labelStyle: TextStyle(
                            decoration: _selectedLanguage == dest
                                ? TextDecoration.none
                                : TextDecoration.none,
                            fontSize: _selectedLanguage == dest
                                ? 18.sp(context)
                                : 13.sp(context),
                            color: _selectedLanguage == dest
                                ? Colors.white
                                : Colors.black,
                          ),
                        ),
                      );
                    }),
                    SizedBox(width: 8.w(context)),
                  ],
                ),
              ),
              ?_selectedLanguage == "English"
                  ? Column(
                      children: [
                        Text(
                          "Language details",
                          style: theme.titleMedium!.copyWith(
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(height: 5),
                        Row(
                          children: [
                            Expanded(
                              child: RadioListTile<bool>(
                                title: RichText(
                                  text: TextSpan(
                                    style: theme.bodyLarge,
                                    text: "MOI",
                                    children: [
                                      TextSpan(
                                        text: "\nprevious study certificate",
                                        style: theme.bodyMedium!.copyWith(
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                value: true,
                                groupValue: _moiValue,
                                contentPadding: EdgeInsets.zero,
                                activeColor: Colors.black,
                                onChanged: (bool? value) {
                                  setState(() {
                                    _moiValue = value!;
                                  });
                                },
                              ),
                            ),
                            Expanded(
                              child: RadioListTile<bool>(
                                title: RichText(
                                  text: TextSpan(
                                    style: theme.bodyLarge,
                                    text: "English Certificate",
                                    children: [
                                      TextSpan(
                                        text: "\ncertificates like IELTS..etc",
                                        style: theme.bodyMedium!.copyWith(
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                value: false,
                                groupValue: _moiValue,
                                contentPadding: EdgeInsets.zero,
                                activeColor: Colors.black,
                                onChanged: (bool? value) {
                                  setState(() {
                                    _moiValue = value!;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    )
                  : null,
              SizedBox(height: 40),
              CustomButton(
                title: "Show Programs",
                onTap: () async {
                  if (_selectedDestination == null || _selectedField == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Please fill missing fields"),
                        backgroundColor: Colors.red,
                      ),
                    );
                    return;
                  }
                  var data = await context.read<ProgramsCubit>().getPrograms(
                    country: _selectedDestination ?? "",
                    onlyMoi: _moiValue,
                    studyField: _selectedField ?? "",
                    degreeType: _selectedDegree ?? "",
                  );
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SearchResultsScreen()),
                  );
                },
                color: Colors.black,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
