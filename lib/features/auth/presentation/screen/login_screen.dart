
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:machine_test/core/colors/colors.dart';
import 'package:machine_test/core/constants/image_constants.dart';
import 'package:machine_test/core/constants/icons_constant.dart';
import 'package:machine_test/core/constants/string_constants.dart';
import 'package:machine_test/core/constants/length.dart';
import 'package:machine_test/core/themes/app_text_style.dart';
import 'package:machine_test/core/validators/input_validators.dart';
import 'package:machine_test/core/widgets/common_widgets.dart';
import 'package:machine_test/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:machine_test/features/auth/presentation/bloc/auth_state.dart';

import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {


    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {

      },
      builder: (context, state) {

        return Scaffold(
          backgroundColor: AppColors.white,
          body: SafeArea(
            left: true,right: true,bottom: true,top: false,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  CommonWidgets.appIcons(assetName:ImageConstants.imgLoginImage,height: 310.h,
                      width: AppLength.screenFullHeight(),
                      fit: BoxFit.cover
                  ),
                  CommonWidgets.verticalSpace(height: 15.h),
                  CommonWidgets.appIcons(assetName:ImageConstants.imgYunicornEmpulse,height: 75.h,
                      width: 190.w,
                      fit: BoxFit.cover),

                  CommonWidgets.verticalSpace(height: 30.h),

                  Form(
                    key: _formKey,
                    child: Padding(
                      padding:  EdgeInsets.symmetric(horizontal: 20.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            StringConstants.login,
                            style: AppTextStyle.titleStyle24bb,
                          ),

                          CommonWidgets.verticalSpace(height: 8.h),
                          Text(
                            "Your space to grow, connect, and celebrate.",
                            style: AppTextStyle.titleStyle14b,
                          ),
                          CommonWidgets.verticalSpace(height: 16.h),

                          CommonWidgets.commonTextField(
                            controller: _emailController,

                            prefixIcon: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: CommonWidgets.svgIcon(IconConstants.icEmail,height: 16.h,width: 16.w),
                            ),
                            hintText: StringConstants.email,
                            validator: InputValidators.validateEmail,
                            textInputAction: TextInputAction.next,
                          ),

                          CommonWidgets.verticalSpace(height: 16.h),

                          CommonWidgets.commonTextField(
                            controller: _passwordController,
                            hintText: StringConstants.password,
                            prefixIcon: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: CommonWidgets.svgIcon(IconConstants.icPassword,height: 16.h,width: 16.w),
                            ),
                            validator: InputValidators.validatePassword,
                            keyboardType: TextInputType.visiblePassword,
                          ),

                          CommonWidgets.verticalSpace(height: 24.h),

                          CommonWidgets.commonElevatedButton(
                            onPressed: () {
                              FocusScope.of(context).unfocus();
                              if (_formKey.currentState!.validate()) {
                                context.read<AuthBloc>().add(
                                  LoginEvent(_emailController.text, _passwordController.text),
                                );
                              }
                            },
                            context: context,
                            height: 48.h,
                            width: AppLength.screenFullWidth(),
                            showLoading:state==AuthLoading(),
                            child: Text(
                              StringConstants.login,
                              style: AppTextStyle.titleStyle16bw,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
