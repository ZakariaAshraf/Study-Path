import 'package:flutter/material.dart';
import 'package:study_path/core/utils/screen_util.dart';

class CharacterItem extends StatelessWidget {
final CharacterModel character;
final bool isSelected;

  final void Function()? onTap;

  const CharacterItem({
    super.key,
    this.onTap, required this.character, required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;
    return Card(
      elevation: isSelected==true ? 4 : 0 ,
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.all(10),
          width: 400,
          height: 400,
          decoration: BoxDecoration(
            border:isSelected==true ? BoxBorder.all(color: Colors.red) : null,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            children: [
              Image.asset(
                character.imagePath,
                width: 150.w(context),
                height: 150.h(context),
              ),
              SizedBox(height: 10.h(context)),
              Text(
                character.imageName,
                style: theme.titleMedium!.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.sp(context),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CharacterModel{
  final String id;
  final String imagePath;
  final String imageName;
  CharacterModel( {required this.imagePath, required this.imageName,
    required this.id,
  });
}
