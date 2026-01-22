import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_path/core/utils/screen_util.dart';
import 'package:study_path/features/authenticate/presentation/pages/choose_your_character_screen.dart';
import 'package:study_path/features/authenticate/presentation/pages/phone_number_validation.dart';
import 'package:study_path/features/authenticate/presentation/pages/sign_in.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../manager/auth_cubit.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController nationalityController = TextEditingController();

  bool areFieldsFilled() {
    return nameController.text.isNotEmpty &&
        emailController.text.isNotEmpty &&
        passwordController.text.isNotEmpty &&
        phoneController.text.isNotEmpty;
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    phoneController.dispose();
    nationalityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final l10n = AppLocalizations.of(context);
    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(
              children: [
                SizedBox(
                  height: 130,
                  width: 138,
                  child: const Icon(Icons.school, size: 60),
                ),
                Text(
                  "Join Application",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 30.0.sp(context),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 10.h(context)),
                Text(
                  '''Find your dream Master's program in Europe''',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black26,
                    fontSize: 18.0.sp(context),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 20.h(context)),

                CustomTextField(
                  controller: nameController,
                  hintText: "Full Name", // l10n!.fullName
                ),
                const SizedBox(height: 15),
                CustomTextField(
                  controller: emailController,
                  hintText: "Email", // l10n.email
                ),
                const SizedBox(height: 15),
                CustomTextField(
                  isPassword: true,
                  controller: passwordController,
                  hintText: "Password", // l10n.password
                ),
                const SizedBox(height: 15),
                CustomTextField(
                  controller: phoneController,
                  hintText: "Phone Number", // l10n.phoneNumber
                ),
                const SizedBox(height: 30),

                Center(
                  child: CustomButton(
                    title: 'Register',
                    onTap: () {
                      if (areFieldsFilled()) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ChooseYourCharacterScreen(
                              email: emailController.text,
                              password: passwordController.text,
                              phoneNumber: phoneController.text,
                              name: nameController.text,
                            ),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              "Please fill all fields",
                              style: TextStyle(color: Colors.white),
                            ),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    },
                  ),
                ),
                const SizedBox(height: 30),
                Center(
                  child: const Text(
                    "or continue with",
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Already have an account? ", // l10n.alreadyHaveAccount
                      style: TextStyle(color: Colors.grey),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SignIn(),
                          ),
                          (route) => true,
                        );
                      },
                      child: const Text(
                        "Login", // l10n.login
                        style: TextStyle(color: Color(0xff1F4C6B)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
