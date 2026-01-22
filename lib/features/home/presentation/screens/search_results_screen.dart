import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_path/core/widgets/university_item.dart';

import '../../../../core/widgets/default_message_card.dart';
import '../cubit/programs_cubit.dart';

class SearchResultsScreen extends StatelessWidget {
  const SearchResultsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: Text("Search Results"),
      ),
      body: BlocBuilder<ProgramsCubit, ProgramsState>(
          builder: (context, state) {
            if (state is ProgramsLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is ProgramsLoaded) {
              return ListView.builder(
                itemCount: state.programs.length,
                itemBuilder: (context, index) {
                  final program = state.programs[index];
                  return UniversityItem(program: program);
                },
              );
            }else if (state is ProgramsLoadEmpty) {
              return const DefaultMessageCard(
                sign: '0_0',
                title: "Your list is empty",
                subTitle: "",
              );
            }else if (state is ProgramsError) {
              return const DefaultMessageCard(
                sign: ':(',
                title: "Your list is empty",
                subTitle: "",
              );
            }
            return Container();
          },
      ),
    );
  }
}
