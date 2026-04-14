import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/colors/colors.dart';
import '../../../../core/constants/image_constants.dart';
import '../../../../core/constants/string_constants.dart';
import '../../../../core/navigation/navigation_service.dart';
import '../../../../core/widgets/common_widgets.dart';
import '../../../../routes/app_router.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<StatefulWidget> createState() => _SplashState();
}

class _SplashState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();

    // Trigger auth check
    context.read<AuthBloc>().add(CheckAuthEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFEF2F2),

      /// ✅ Listen to AuthBloc (GLOBAL)
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {

          if (state is Authenticated) {
            // ✅ User logged in
            NavigationService.pushReplacementNamed(AppRoutes.tasks);
          }

          if (state is UnAuthenticated) {
            // ❌ User not logged in
            NavigationService.pushReplacementNamed(AppRoutes.login);
          }

          if (state is AuthError) {
            // Optional: show error
            NavigationService.pushReplacementNamed(AppRoutes.login);
          }
        },

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            /// App Logo
            Center(
              child: CommonWidgets.appIcons(
                assetName: ImageConstants.imgErrorImage,
                height: 130.h,
                width: 300.w,
              ),
            ),

            const SizedBox(height: 20),

            /// Loading Indicator
            const CircularProgressIndicator(),

            const Spacer(),

            /// Footer
            SafeArea(
              minimum: EdgeInsets.symmetric(vertical: 10.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    StringConstants.poweredBy,
                    style: TextStyle(
                      color: AppColors.boldTextColor,
                      fontFamily: 'Quicksand',
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SvgPicture.asset(
                    ImageConstants.imgLightThemeYunicornLogo,
                    width: 80.w,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}