import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_app/FrontEnd/elements/components/asset_image_widget.dart';
import 'package:my_app/FrontEnd/elements/components/button.dart';
import 'package:my_app/FrontEnd/elements/components/my_text_field.dart';
import 'package:my_app/PinjamNada/cubit/auth/auth_cubit.dart';
import 'package:my_app/PinjamNada/cubit/user/user_cubit.dart';
import 'package:my_app/PinjamNada/dto/login.dart';
import 'package:my_app/PinjamNada/services/data_service.dart';
import 'package:my_app/main.dart';
import 'package:my_app/utils/constants.dart';
import 'package:my_app/utils/secure_storage_util.dart';
import 'dart:convert';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void sendLogin(
      BuildContext context, AuthCubit authCubit, UserCubit userCubit) async {
    final email = _usernameController.text;
    final password = _passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      debugPrint("Email or password cannot be empty");
      return;
    }

    final response = await DataService.sendLoginData(email, password);
    if (response.statusCode == 200) {
      debugPrint("Login successful");
      final data = jsonDecode(response.body);
      final loggedIn = Login.fromJson(data);
      await SecureStorageUtil.storage
          .write(key: tokenStoreName, value: loggedIn.accessToken);

      // Call DataService.getUserInfo with the obtained accessToken
      final userInfoResponse =
          await DataService.getUserInfo(loggedIn.accessToken);
      if (userInfoResponse != null && userInfoResponse.statusCode == 200) {
        final userInfo = jsonDecode(userInfoResponse.body);
        final roles = userInfo['roles'];
        final userID = userInfo['user_logged'];
        final username = userInfo['username'];

        final profileInfoResponse =
            await DataService.getUserAdditionalInfo(userID);
        if (profileInfoResponse.statusCode == 200) {
          final profileInfo = jsonDecode(profileInfoResponse.body);
          final email = profileInfo['data']['email'];
          final full_name = profileInfo['data']['full_name'];
          final phone = profileInfo['data']['phone'];
          final profile_picture = profileInfo['data']['profile_picture'];
    
      
    


          // Call UserCubit's login method to update state
          userCubit.login(roles, userID, username, email, full_name, phone, profile_picture);

          // userCubit.updateProfile(email: email, full_name: full_name, phone: phone,profile_picture: profile_picture);

          // Navigate to the next screen
          Navigator.pushReplacementNamed(context, "/navi");
          debugPrint("Access token: ${loggedIn.accessToken}");
        } else {
          // Handle the case where getUserInfo failed or returned non-200 status
          if (userInfoResponse != null) {
            debugPrint(
                "Failed to fetch user info ${userInfoResponse.statusCode}");
          } else {
            debugPrint("Failed to fetch user info. Response was null.");
          }
        }
      } else {
        debugPrint("Login failed ${response.statusCode}");
      }
    } else {
      debugPrint("Login failed ${response.statusCode}");
    }
  }

  @override
  Widget build(BuildContext context) {
    final authCubit = BlocProvider.of<AuthCubit>(context);
    final userCubit = BlocProvider.of<UserCubit>(context);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                SizedBox(height: 40),
                AssetImageWidget(
                  imagePath: 'assets/images/logoPinjamNadaHitam.png',
                  width: 200,
                  height: 200,
                  fit: BoxFit.cover,
                ),
                Text(
                  namaApp,
                  style: GoogleFonts.manrope(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20),
                MyTextField(
                  controller: _usernameController,
                  hintText: 'Enter your username',
                  obscureText: false,
                ),
                SizedBox(height: 10),
                MyTextField(
                  controller: _passwordController,
                  hintText: 'Enter your password',
                  obscureText: true,
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    SizedBox(width: 20),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/register');
                      },
                      child: Text('Register Now'),
                    ),
                  ],
                ),
                ButtonSatu(
                  childColor: secondary,
                  buttonText: 'Login',
                  onPressed: () {
                    sendLogin(context, authCubit, userCubit);
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