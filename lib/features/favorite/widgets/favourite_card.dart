import 'package:flutter/material.dart';
import 'package:study_path/features/home/data/model/program_model.dart';

class FavouriteCard extends StatelessWidget {
  final ProgramModel programme;
  const FavouriteCard({super.key, required this.programme});

  @override
  Widget build(BuildContext context) {
    var theme =Theme.of(context).textTheme;
    return InkWell(
      // onTap: () =>  Navigator.push(context, MaterialPageRoute(builder: (context) => MealDetailsView(mealId: programme.idMeal),)),
      child: Container(
        height: 150,
        width:150,
        decoration: const BoxDecoration(
          border: Border.symmetric(vertical: BorderSide(color: Color(0xffFFBF78)),horizontal:  BorderSide(color: Color(0xffFFBF78))),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(programme.websiteLink ?? "" ,
                width: 130, height: 130),
            const SizedBox(
              width: 20,
            ),
            SizedBox(
              width:150,
              child: Text(
                programme.programName,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
