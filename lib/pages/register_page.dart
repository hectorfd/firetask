import 'package:firebase_auth/firebase_auth.dart';
import 'package:firetask/models/user_model.dart';
import 'package:firetask/pages/home_page.dart';
import 'package:firetask/services/my_service_firestore.dart';
import 'package:firetask/ui/general/colors.dart';
import 'package:firetask/ui/widgets/button_custom_widget.dart';
import 'package:firetask/ui/widgets/general_widgets.dart';
import 'package:firetask/ui/widgets/textfield_normal_widget.dart';
import 'package:firetask/ui/widgets/textfield_password_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final keyForm = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _fullNameController = TextEditingController();

  MyServiceFirestore userService = MyServiceFirestore(collection: "users");

  _registerUser() async {
    try {
      if (keyForm.currentState!.validate()) {
        UserCredential userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text,
        );

        if (userCredential.user != null) {

          UserModel userModel = UserModel(
            fullName: _fullNameController.text,
            email: _emailController.text,
          );
          userService.addUser(userModel).then((value) {
            if(value.isNotEmpty){
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> HomePage()), (route) => false);
            }
          });
        }
      }
    } on FirebaseAuthException catch (error) {
      if (error.code == "weak-password") {
        //
        showSnackBarError(context, "La contraseña es muy débil");
      } else if (error.code == "email-already-in-use") {
        //
        showSnackBarError(
            context, "El correo electrónico ya está siendo usado");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: keyForm,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back, color: Colors.black),
                      onPressed: () {
                        Navigator.pop(context); 
                      },
                    ),
                  ],
                ),
                caja30(),
                SvgPicture.asset(
                  'assets/images/register.svg',
                  height: 180.0,
                ),
                caja30(),
                Text(
                  "Regístrate",
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w600,
                    color: primary,
                  ),
                ),
                caja20(),
                TextfieldNormalWidget(
                  hintText: "Nombre completo",
                  icon: Icons.email,
                  controller: _fullNameController,
                ),
                caja10(),
                caja6(),
                TextfieldNormalWidget(
                  hintText: "Correo electrónico",
                  icon: Icons.email,
                  controller: _emailController,
                ),
                caja10(),
                caja6(),
                TextFieldPasswordWidget(
                  controller: _passwordController,
                ),
                caja20(),
                ButtonCustomWidget(
                  text: "Regístrate ahora",
                  icon: "check",
                  color: primary,
                  onPressed: () {
                    _registerUser();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}