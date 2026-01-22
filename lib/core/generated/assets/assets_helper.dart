String getCharacterAssetPath(String characterId) {
  switch (characterId) {
    case 'male_student':
      return "assets/icons/mstudent.png";
    case 'female_student':
      return "assets/icons/fstudent.png";
    case 'male_grad':
      return "assets/icons/mgrad.png";
    case 'female_grad':
      return "assets/icons/fgrad.png";
    default:
      return "assets/icons/default_avatar.png"; // صورة احتياطية
  }
}