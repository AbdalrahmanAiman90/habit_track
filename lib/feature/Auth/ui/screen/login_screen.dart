import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:habit_track/core/global/global_widget/app_stuts.dart';
import 'package:habit_track/core/theme/screen_size.dart';
import 'package:habit_track/core/theme/style.dart';
import 'package:habit_track/feature/Auth/cubit/cubit/auth_cubit.dart';
import 'package:habit_track/feature/Auth/ui/screen/register_screen.dart';

import 'package:habit_track/feature/Auth/ui/widget/custom_button.dart';
import 'package:habit_track/feature/Auth/ui/widget/custom_text.dart';
import 'package:habit_track/feature/Auth/ui/widget/googal_button.dart';
import 'package:habit_track/feature/Auth/ui/widget/password_field.dart';
import 'package:habit_track/feature/Auth/ui/widget/remmber_me.dart';
import 'package:habit_track/feature/home/ui/screen/home_screen.dart';
import 'package:habit_track/feature/home/ui/screen/navbar.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../../../core/theme/color.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleLogin() {
    if (_formKey.currentState!.validate()) {
      String email = _emailController.text;
      String password = _passwordController.text;
      print("Email: $email");
      print("Password: $password");
      context.read<AuthCubit>().logIN(
          emial: _emailController.text, password: _passwordController.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthFaileLogin) {
            context.loaderOverlay.hide();
            AppStuts.showCustomSnackBar(
                context, state.errorMassage, Icons.close, false);
          } else if (state is AuthLogInSucsses) {
            context.loaderOverlay.hide();
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const BottomNavBar()),
            );
          } else {
            context.loaderOverlay.show(
              widgetBuilder: (progress) {
                return AppStuts.myLoading();
              },
            );
          }
        },
        child: Padding(
          padding: EdgeInsets.only(top: 50.h, left: 20.w, right: 20.w),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey, // Add Form widget
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Log In",
                        style: TextAppStyle.mainTittel,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const RegisterScreen(),
                            ),
                          );
                        },
                        child: Padding(
                          padding: EdgeInsets.only(top: 30.h),
                          child: Row(
                            children: [
                              Text(
                                "Sign Up",
                                style: TextAppStyle.subTittel,
                              ),
                              AppScreenUtil.width(6),
                              const Icon(
                                Icons.arrow_forward_ios,
                                color: AppColor.subText,
                                size: 18,
                              )
                            ],
                          ),
                        ),
                      ),

                    ],
                  ),
                  AppScreenUtil.hight(35),
                  //!emial
                  CustomText(
                    hintName: 'Email',
                    controller: _emailController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      return null;
                    },
                  ),
                  AppScreenUtil.hight(30),
                  //!passwword
                  PasswordField(
                    hintName: 'Password',
                    controller: _passwordController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      return null;
                    },
                  ),
                  AppScreenUtil.hight(15),
                  RememberMeForgotPasswordRow(),
                  AppScreenUtil.hight(40),
                  //!button
                  CustomButton(
                    buttonName: 'Login',
                    onPressed: _handleLogin,
                  ),
                  AppScreenUtil.hight(30),
                  Text(
                    'Or log in with: ',
                    style: TextAppStyle.subTittel,
                  ),
                  AppScreenUtil.hight(15),
                  //!button
                  GoogalButton()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
