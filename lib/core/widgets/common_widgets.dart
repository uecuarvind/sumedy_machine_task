import 'dart:convert';
import 'dart:io';
import 'package:flutter_svg/svg.dart';
import 'package:gradient_borders/gradient_borders.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:machine_test/core/validators/input_validators.dart';
import 'package:shimmer/shimmer.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import '../../routes/app_router.dart';
import '../colors/colors.dart';
import '../constants/api_keys.dart';
import '../constants/icons_constant.dart';
import '../constants/image_constants.dart';
import '../constants/string_constants.dart';
import '../navigation/navigation_service.dart';
import '../themes/app_text_style.dart';

class CommonWidgets {
  static appBar({
    String? title,
    bool wantBackButton = true,
    bool centerTitle = false,
    List<Widget>? actions,
    Color? backgroundColor,
    bool manualBackButtonTap = false,
    void Function()? onTap
  }) {
    return AppBar(
      elevation: 0,
      shadowColor: AppColors.white,
      surfaceTintColor: AppColors.white,
      foregroundColor: AppColors.white,
      backgroundColor: backgroundColor ?? AppColors.white,
      scrolledUnderElevation: 0.0,
      automaticallyImplyLeading:wantBackButton ,
      leadingWidth: 50,
      leading: wantBackButton
          ? GestureDetector(
              onTap: manualBackButtonTap?onTap:() {
                NavigationService.pop();
              },
              child: Padding(
                padding: EdgeInsets.all(8),
                child: Center(
                  child: appIcons(
                    assetName: IconConstants.icBack,
                    height: 30.h,
                    width: 30.w,
                    fit: BoxFit.fill,
                    color: AppColors.black,
                  ),
                ),
              ),
            )
          : null,
      titleSpacing: wantBackButton?0:20.w,
      centerTitle: centerTitle ?? true,
      title: Text(title ?? '', style: TextStyle(
          color: AppColors.boldTextColor,
          fontFamily: 'Quicksand',
          fontSize: 16.sp,
          fontWeight: FontWeight.bold)),
      actions: actions,
        toolbarHeight:50.h
    );
  }

  /// BackGround frame
  static Widget customBackgroundFrame({
    double? height,
    double? width,
    EdgeInsetsGeometry? buttonMargin,
    EdgeInsetsGeometry? contentPadding,
    double? borderRadius,
    Color? splashColor,
    bool showLoading = false,
    required VoidCallback onPressed,
    Widget? child,
    required BuildContext context,
  }) {
    return Container(
      height: height ?? 50.h,
      width: width ?? 50.h,
      margin: buttonMargin,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius ?? 8.r),
        gradient: LinearGradient(
          colors: [Color(0xFF34C8E8), Color(0xFF4E4AF2)],
        ),
      ),
      clipBehavior: Clip.hardEdge,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius ?? 9.r),
          border: GradientBoxBorder(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFFFFFFFF).withOpacity(0.5),
                Color(0xFF000000).withOpacity(0.5),
              ],
            ),
            width: 3.w,
          ),
        ),
        clipBehavior: Clip.hardEdge,
        child: showLoading
            ? Center(
                child: const CircularProgressIndicator(color: AppColors.white),
              )
            : GestureDetector(
                onTap: onPressed,
                child: Container(
                  height: height ?? 50.h,
                  width: width ?? 50.h,
                  alignment: Alignment.center,
                  child: child,
                ),
              ),
      ),
    );
  }

  ///For Full Size Use In Column Not In ROW
  static Widget commonElevatedButton({
    Key? buttonKey,
    Key? loadingKey,
    double? height,
    double? width,
    EdgeInsetsGeometry? buttonMargin,
    EdgeInsetsGeometry? contentPadding,
    double? borderRadius,
    Color? splashColor,
    bool showLoading = false,
    Color? buttonColor,
    TextStyle? textStyle,
    double? elevation,
    required VoidCallback onPressed,
    Widget? child,
    Decoration? decoration,
    BoxBorder? border,
    required BuildContext context,
  }) {
    return Container(
      height: height ?? 40.h,
      width: width ?? double.infinity,
      margin: buttonMargin,
      alignment: Alignment.center,
      decoration:
          decoration ??
          BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius ?? 8.r),
            color: buttonColor ?? AppColors.primary,
          ),
      clipBehavior: Clip.hardEdge,
      child: showLoading
          ? Container(
              key: loadingKey,
              alignment: Alignment.center,
              decoration:
                  decoration ??
                  BoxDecoration(
                    borderRadius: BorderRadius.circular(8.r),
                    color: buttonColor ?? AppColors.primary,
                  ),
              child: const CircularProgressIndicator(color: AppColors.white),
            )
          : GestureDetector(
              key: buttonKey,
              onTap: onPressed,
              child: Container(
                height: height ?? 60.h,
                width: width ?? double.infinity,
                alignment: Alignment.center,
                decoration:
                    decoration ??
                    BoxDecoration(
                      borderRadius: BorderRadius.circular(8.r),
                      color: buttonColor ?? AppColors.primary,
                    ),
                child: child,
              ),
            ),
    );
  }

  /// For outlined button (used for secondary actions)
  static Widget commonOutlinedButton({
    Key? buttonKey,
    double? height,
    double? width,
    EdgeInsetsGeometry? buttonMargin,
    double? borderRadius,
    Color? borderColor,
    Color? textColor,
    Color? splashColor,
    bool showLoading = false,
    required VoidCallback onPressed,
    Widget? child,
    required BuildContext context,
  }) {
    return Container(
      height: height ?? 50.h,
      width: width ?? double.infinity,
      margin: buttonMargin,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius ?? 8.r),
        border: Border.all(
          color: borderColor ?? AppColors.primary,
          width: 1.5,
        ),
      ),
      child: GestureDetector(
        key: buttonKey,
        onTap: onPressed,
        child: Container(
          height: height ?? 50.h,
          width: width ?? double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius ?? 8.r),
            color: Colors.transparent,
          ),
          child: showLoading
              ? const CircularProgressIndicator(color: AppColors.primary)
              : DefaultTextStyle(
            style: AppTextStyle.titleStyle16bw.copyWith(
              color: textColor ?? AppColors.primary,
            ),
            child: child ?? const SizedBox(),
          ),
        ),
      ),
    );
  }

  ///For Full Size Use In Column Not In ROW
  static Widget commonGradientButton({
    double? height,
    double? width,
    EdgeInsetsGeometry? buttonMargin,
    EdgeInsetsGeometry? contentPadding,
    double? borderRadius,
    bool wantContentSizeButton = false,
    bool isLoading = false,
    Color? buttonColor,
    TextStyle? textStyle,
    double? elevation,
    required VoidCallback onPressed,
    Widget? child,
    BoxBorder? border,
  }) {
    return GestureDetector(
      onTap: () {
        onPressed();
      },
      child: Container(
        height: wantContentSizeButton ? height : 50.h,
        width: wantContentSizeButton ? width : double.infinity,
        margin: buttonMargin,
        alignment: Alignment.center,
        decoration: kGradientBoxDecoration(
          borderRadius: borderRadius,
          showGradientBorder: true,
        ),
        child: isLoading
            ? const Center(
                child: CircularProgressIndicator(color: AppColors.primary),
              )
            : child ?? const Text(''),
      ),
    );
  }

  static imageView({
    double? width,
    double? height,
    double? radius,
    required String image,
    String? defaultNetworkImage,
    BoxFit? fit,
    BorderRadiusGeometry? borderRadius,
  }) {
    return SizedBox(
      height: height ?? 64.h,
      width: width ?? double.infinity,
      child: ClipRRect(
        borderRadius: borderRadius ?? BorderRadius.circular(radius ?? 8.r),
        child: CachedNetworkImage(
          imageUrl: image,
          fit: fit ?? BoxFit.cover,
          errorWidget: (context, error, stackTrace) {
            return Container(
              height: height ?? 64.h,
              width: width ?? double.infinity,
              color: Theme.of(context).colorScheme.onSecondary.withOpacity(.2),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(radius ?? 8.r),
                child: defaultNetworkImage != null
                    ? appIcons(assetName: defaultNetworkImage)
                    : Icon(Icons.error, color: AppColors.primary),
              ),
            );
          },
          progressIndicatorBuilder: (context, url, downloadProgress) {
            return SizedBox(
              height: height ?? 64.h,
              width: width ?? double.infinity,
              child: Shimmer.fromColors(
                baseColor: Theme.of(
                  context,
                ).colorScheme.onSecondary.withOpacity(.4),
                highlightColor: Theme.of(context).colorScheme.onSecondary,
                child: Container(
                  color: Theme.of(
                    context,
                  ).colorScheme.onSecondary.withOpacity(.4),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  static Widget dataNotFound() {
    return Center(child: Image.asset(ImageConstants.imageNoDataFound));
  }

  static BoxDecoration kGradientBoxDecoration({
    double? borderRadius,
    bool showGradientBorder = false,
    Color? defaultColor,
  }) {
    return BoxDecoration(
      gradient: showGradientBorder
          ? LinearGradient(
              colors: [
                const Color(0xffFF4292),
                const Color(0xffFF4292).withOpacity(0.7),
                const Color(0xff5588FE).withOpacity(0.6),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            )
          : LinearGradient(
              colors: [
                defaultColor ?? Colors.grey,
                defaultColor ?? Colors.grey,
              ],
            ),
      borderRadius: BorderRadius.circular(borderRadius ?? 15.r),
    );
  }

  static Widget appIcons({
    required String assetName,
    double? width,
    double? height,
    double? borderRadius,
    Color? color,
    BoxFit? fit,
  }) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius ?? 4.r),
      child: Image.asset(
        assetName == '' ? IconConstants.icLogo : assetName,
        height: height ?? 24.h,
        width: width ?? 24.w,
        color: color,
        fit: fit ?? BoxFit.fill,
        errorBuilder: (context, error, stackTrace) {
          return SizedBox(height: height ?? 24.h, width: width ?? 24.w);
        },
      ),
    );
  }

  static Widget verticalSpace({double? height}) {
    return SizedBox(height: height ?? 10.h);
  }

  static Widget horizontalSpace({double? width}) {
    return SizedBox(width: width ?? 10.w);
  }

  static Widget customProgressBar({
    required bool inAsyncCall,
    double? width,
    Widget? child,
    Color? backgroundColor,
    bool overlapped = false,
    double? height,
  }) {
    return Container(
      height: height ?? double.infinity,
      width: width ?? double.infinity,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: inAsyncCall
            ? backgroundColor ?? backgroundColor
            : backgroundColor,
      ),
      clipBehavior: Clip.hardEdge,
      child: inAsyncCall
          ? overlapped
                ? Stack(
                    alignment: Alignment.center,
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          const CircularProgressIndicator(
                            color: AppColors.primary,
                          ),
                          appIcons(
                            assetName: IconConstants.icLogo,
                            width: 30.w,
                            height: 30.h,
                            fit: BoxFit.fill,
                          ),
                        ],
                      ),
                      Opacity(opacity: 0.3, child: child ?? const SizedBox()),
                    ],
                  )
                : Stack(
                    alignment: Alignment.center,
                    children: [
                      const CircularProgressIndicator(color: AppColors.primary),
                      appIcons(
                        assetName: IconConstants.icLogo,
                        width: 30.w,
                        height: 30.h,
                        fit: BoxFit.fill,
                      ),
                    ],
                  )
          : child ?? const SizedBox(),
    );
  }

  static InputDecoration inputDecoration({
    String? hintText,
    String? labelText,
    String? errorText,
    EdgeInsetsGeometry? contentPadding,
    Color? fillColor,
    TextStyle? hintStyle,
    TextStyle? labelStyle,
    TextStyle? errorStyle,
    Widget? suffixIcon,
    Widget? prefixIcon,
    bool? filled,
  }) {
    return InputDecoration(
      errorText: errorText,
      counterText: '',
      errorStyle: AppTextStyle.titleStyle16pct,
      suffixIcon: suffixIcon,
      prefixIcon: prefixIcon,
      hintText: hintText,
      labelText: labelText,
      labelStyle: AppTextStyle.titleStyle14b,
      fillColor: AppColors.primary,
      // filled: filled ?? false,
      contentPadding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 16.w),
      hintStyle: AppTextStyle.titleStyle14b,
      disabledBorder: border(color: AppColors.lightTextColor),
      border: border(color: AppColors.primary),
      errorBorder: border(color: AppColors.errorColor),
      enabledBorder: border(color: AppColors.primary),
      focusedErrorBorder: border(),
      focusedBorder: border(),
    );
  }

  static border({Color? color}) {
    return OutlineInputBorder(
      borderSide: BorderSide(color: color ?? AppColors.primary, width: 2.w),
      borderRadius: BorderRadius.circular(14.r),
    );
  }

  static Widget gradientText(String? text, double? fontSize) {
    return GradientText(
      text ?? '',
      gradientDirection: GradientDirection.ltr,
      style: TextStyle(fontSize: fontSize ?? 16.0.sp),
      colors: [
        const Color(0xffFF4292),
        const Color(0xffFF4292).withOpacity(0.7),
        const Color(0xff5588FE).withOpacity(0.6),
      ],
    );
  }

  /* static Widget commonTextField(
      {Key? key,
      double? elevation,
      String? hintText,
      String? labelText,
      String? errorText,
      EdgeInsetsGeometry? contentPadding,
      TextEditingController? controller,
      int? maxLines,
      double? cursorHeight,
      double? horizontalPadding,
      double? prefixIconHorizontal,
      bool wantBorder = false,
      ValueChanged<String>? onChanged,
      FormFieldValidator<String>? validator,
      Color? fillColor,
      Color? initialBorderColor,
      double? initialBorderWidth,
      TextInputType? keyboardType,
      double? borderRadius,
      double? maxHeight,
      TextStyle? hintStyle,
      TextStyle? style,
      TextStyle? labelStyle,
      TextStyle? errorStyle,
      List<TextInputFormatter>? inputFormatters,
      TextCapitalization textCapitalization = TextCapitalization.none,
      bool autofocus = false,
      bool readOnly = false,
      bool hintTextColor = false,
      Widget? suffixIcon,
      Widget? prefixIcon,
      AutovalidateMode? autoValidateMode,
      int? maxLength,
      GestureTapCallback? onTap,
      bool obscureText = false,
      FocusNode? focusNode,
      Decoration? decoration,
      bool? filled,
      bool isCard = false}) {
    return Padding(
      padding: contentPadding ?? EdgeInsets.symmetric(vertical: 10.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            labelText ?? '',
            style: labelStyle ??
                AppTextStyle.titleStyle14w,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 1.5.w, vertical: 0.h),
             padding: EdgeInsets.zero,
            decoration: decoration ??
                BoxDecoration(
                    color: fillColor ,
                    borderRadius: BorderRadius.circular(borderRadius ?? 0.r),
                  border: Border(
                    bottom: BorderSide(
                          color: isCard
                              ? AppColors.primary
                              : AppColors.white,
                      width: 1.h,
                    ),
                  ),
                    // border: Border.all(
                    //     color: isCard
                    //         ? AppColors.primary
                    //         : AppColors.white,
                    //     width: 1.w)
                ),
            child: Row(
              children: [
                prefixIcon ?? const SizedBox(),
                Flexible(
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal:prefixIcon!=null?3.w:0,vertical: 0 ),
                    child: TextFormField(
                      key: key,
                      focusNode: focusNode,
                      obscureText: obscureText,
                      onTap: onTap,
                      maxLines: maxLines ?? 1,
                      maxLength: maxLength,
                      cursorHeight: cursorHeight,
                      cursorColor: AppColors.primary,
                      autovalidateMode: autoValidateMode ?? AutovalidateMode.onUserInteraction,
                      controller: controller,
                      onChanged: onChanged ??
                          (value) {
                            value = value.trim();
                            if (value.isEmpty ||
                                value.replaceAll(" ", "").isEmpty) {
                              controller?.text = "";
                            }
                          },
                      validator: validator,
                      keyboardType:
                          defaultTargetPlatform == TargetPlatform.iOS
                              ? const TextInputType.numberWithOptions(
                                  decimal: true, signed: true)
                              : keyboardType ?? TextInputType.text,
                      readOnly: readOnly,
                      autofocus: autofocus,
                      inputFormatters: inputFormatters,
                      textCapitalization: textCapitalization,
                      style: style ?? AppTextStyle.titleStyle16bw,
                      decoration: InputDecoration(
                        errorText: errorText,
                        counterText: '',
                        errorStyle: errorStyle ??
                            AppTextStyle.titleStyleError(),
                        hintText: hintText,
                        hintStyle: hintStyle ?? AppTextStyle.titleStyle14w,
                        fillColor:
                            fillColor ?? AppColors.primary,
                        filled: filled ?? false,
                        contentPadding:EdgeInsets.zero,
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                suffixIcon ?? const SizedBox(),
              ],
            ),
          ),
        ],
      ),
    );
  }*/

  static Widget commonTextField({
    Key? key,
    double? elevation,
    String? hintText,
    String? labelText,
    String? errorText,
    EdgeInsetsGeometry? contentPadding,
    TextEditingController? controller,
    int? maxLines,
    double? cursorHeight,
    double? horizontalPadding,
    double? prefixIconHorizontal,
    bool wantBorder = false,
    ValueChanged<String>? onChanged,
    FormFieldValidator<String>? validator,
    Color? fillColor,
    Color? initialBorderColor,
    double? initialBorderWidth,
    TextInputType? keyboardType,
    double? borderRadius,
    double? maxHeight,
    TextStyle? hintStyle,
    TextStyle? style,
    TextStyle? labelStyle,
    TextStyle? errorStyle,
    List<TextInputFormatter>? inputFormatters,
    TextCapitalization textCapitalization = TextCapitalization.none,
    bool autofocus = false,
    bool readOnly = false,
    bool hintTextColor = false,
    Widget? suffixIcon,
    Widget? prefixIcon,
    AutovalidateMode? autoValidateMode,
    int? maxLength,
    GestureTapCallback? onTap,
    bool obscureText = false,
    FocusNode? focusNode,
    Decoration? decoration,
    TextInputAction? textInputAction,
    bool? filled,
    bool isCard = false,
    bool enabled = true,
  }) {
    return Padding(
      padding: contentPadding ?? EdgeInsets.symmetric(vertical: 0.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (labelText != null)
            Text(
              labelText ?? '',
              style: labelStyle ?? AppTextStyle.titleStyle14b,
            ),
          if (labelText != null) SizedBox(height: 8),
          Row(
            children: [
              Flexible(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: prefixIcon != null ? 3.w : 0,
                    vertical: 0,
                  ),
                  child: TextFormField(
                    key: key,
                    focusNode: focusNode,
                    obscureText: obscureText,
                    onTap: onTap,
                    maxLines: maxLines ?? 1,
                    maxLength: maxLength,
                    cursorHeight: cursorHeight,
                    cursorColor: AppColors.primary,
                    // autovalidateMode:
                    //     autoValidateMode ?? AutovalidateMode.onUserInteraction,
                    controller: controller,
                    onChanged:
                        onChanged ??
                        (value) {
                          value = value.trim();
                          if (value.isEmpty ||
                              value.replaceAll(" ", "").isEmpty) {
                            controller?.text = "";
                          }
                        },
                    validator: validator,
                    keyboardType: defaultTargetPlatform == TargetPlatform.iOS
                        ? const TextInputType.numberWithOptions(
                            decimal: true,
                            signed: true,
                          )
                        : keyboardType ?? TextInputType.text,
                    readOnly: readOnly,
                    autofocus: autofocus,
                    inputFormatters: inputFormatters,
                    textCapitalization: textCapitalization,
                    style: style ?? TextStyle(
                        color: AppColors.boldTextColor,
                        fontFamily: 'Quicksand',
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500),
                    enabled: enabled,
                    textInputAction: textInputAction,
                    decoration: InputDecoration(
                      errorText: errorText,
                      counterText: '',
                      errorStyle: errorStyle ?? AppTextStyle.titleStyleError(),
                      hintText: hintText,
                      hintStyle: hintStyle ?? AppTextStyle.titleStyle14b,
                      fillColor: fillColor ?? AppColors.secondary,
                      filled: filled ?? true,
                      prefixIcon: prefixIcon,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 15.w,
                        vertical: 5.h,
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 1,
                          color: AppColors.primary,
                        ),
                        borderRadius: BorderRadius.circular(8.0.r),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 1,
                          color: AppColors.primary,
                        ),
                        borderRadius: BorderRadius.circular(8.0.r),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 1, color: AppColors.grey),
                        borderRadius: BorderRadius.circular(8.0.r),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 1,
                          color: AppColors.errorColor,
                        ),
                        borderRadius: BorderRadius.circular(8.0.r),
                      ),
                      disabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 1, color: AppColors.grey),
                        borderRadius: BorderRadius.circular(8.0.r),
                      ),
                      suffixIconColor: AppColors.grey,
                      suffixIcon: suffixIcon ?? const SizedBox(),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  static countryCodePicker({
    ValueChanged<CountryCode>? onChanged,
    String? initialSelection,
  }) {
    return CountryCodePicker(
      boxDecoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: AppColors.primary, width: 8.w),
      ),
      searchDecoration: InputDecoration(
        contentPadding: EdgeInsets.zero,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14.r),
          borderSide: BorderSide(width: 8.w, color: AppColors.primary),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14.r),
          borderSide: BorderSide(width: 8.w, color: AppColors.primary),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14.r),
          borderSide: BorderSide(width: 8.w, color: AppColors.primary),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14.r),
          borderSide: BorderSide(width: 8.w, color: AppColors.errorColor),
        ),
      ),
      padding: EdgeInsets.zero,
      margin: EdgeInsets.zero,
      showFlagMain: true,
      hideMainText: false,
      flagWidth: 24.w,
      onChanged: onChanged,
      initialSelection: initialSelection ?? 'IN',
      showCountryOnly: true,
      showDropDownButton: true,
      showOnlyCountryWhenClosed: false,
      alignLeft: false,
      textStyle: AppTextStyle.titleStyle14bb,
    );
  }

  static Widget commonOtpView({
    Key? key,
    MainAxisAlignment mainAxisAlignment = MainAxisAlignment.spaceEvenly,
    PinCodeFieldShape? shape,
    TextInputType keyboardType = TextInputType.number,
    List<TextInputFormatter>? inputFormatters,
    TextEditingController? controller,
    ValueChanged<String>? onChanged,
    ValueChanged<String>? onCompleted,
    int length = 4,
    double? height,
    double? width,
    double? borderRadius,
    double? borderWidth,
    String? hintCharacter,
    bool readOnly = false,
    bool autoFocus = false,
    bool enableActiveFill = true,
    bool enablePinAutofill = true,
    bool autoDismissKeyboard = true,
    TextStyle? textStyle,
    Color? cursorColor,
    Color? inactiveColor,
    Color? inactiveFillColor,
    Color? activeColor,
    Color? activeFillColor,
    Color? selectedColor,
    Color? selectedFillColor,
    bool obscureText = false,
    AutovalidateMode? autoValidateMode,
    FormFieldValidator<String>? validator,
  }) => PinCodeTextField(
    key: key,
    length: length,
    validator: validator,
    obscureText: obscureText,
    mainAxisAlignment: mainAxisAlignment,
    hintCharacter: hintCharacter ?? '*',
    hintStyle: AppTextStyle.titleStyle20bb.copyWith(
      color: AppColors.grey,
      fontSize: 30,
    ),
    autovalidateMode: autoValidateMode ?? AutovalidateMode.disabled,
    // obscureText: true,
    appContext: NavigationService.navigatorKey.currentContext!,
    cursorColor: cursorColor ?? AppColors.white,
    autoFocus: autoFocus,
    keyboardType: keyboardType,
    inputFormatters:
        inputFormatters ??
        <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
    readOnly: readOnly,
    textStyle: textStyle ?? AppTextStyle.titleStyle20b,
    autoDisposeControllers: false,
    enabled: true,
    animationType: AnimationType.fade,
    pinTheme: PinTheme(
      inactiveColor: inactiveColor ?? Colors.grey.withOpacity(0.8),
      inactiveFillColor: inactiveFillColor ?? Colors.transparent,
      activeColor: activeColor ?? Colors.grey.withOpacity(0.8),
      activeFillColor: activeColor ?? Colors.transparent,
      selectedColor: selectedColor ?? AppColors.white,
      selectedFillColor: selectedFillColor ?? Colors.transparent,
      shape: shape ?? PinCodeFieldShape.box,
      fieldWidth: width ?? 45.w,
      fieldHeight: height ?? 45.h,
      borderWidth: borderWidth ?? 3.w,
      borderRadius: BorderRadius.circular(borderRadius ?? 8.r),
    ),
    enableActiveFill: enableActiveFill,
    controller: controller,
    onChanged: onChanged,
    enablePinAutofill: enablePinAutofill,
    onCompleted: onCompleted,
    autoDismissKeyboard: autoDismissKeyboard,
  );

  static Widget profileStackWidget({
    required List<String> profileImageUrls,
    double avatarSize = 50.0,
    double spacing = 10.0,
  }) {
    List<Widget> stackLayers = List<Widget>.generate(profileImageUrls.length, (
      index,
    ) {
      return Padding(
        padding: EdgeInsets.fromLTRB(index.toDouble() * spacing, 0, 0, 0),
        child: CommonWidgets.imageView(
          image: profileImageUrls[index],
          height: avatarSize,
          width: avatarSize,
          borderRadius: BorderRadius.circular(avatarSize / 2),
          defaultNetworkImage: 'https://iconape.com/wp-content/files/nb/368023/svg/person-logo-icon-png-svg.png',
        ),
      );
    });

    return Stack(children: stackLayers);
  }




  static Future<bool> internetConnectionCheckerMethod() async {
    try {
      final result = await http.get(Uri.parse('https://www.google.com/'));
      if (result.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } on SocketException catch (_) {
      return false;
    }
  }

  static ScaffoldFeatureController<SnackBar, SnackBarClosedReason>
  snackBarView({String title = '', bool success = false}) {
    var snackBar = SnackBar(
      content: Text(title, style: AppTextStyle.titleStyle14bb),
      backgroundColor: success ? Colors.green : Colors.redAccent,
    );
    return ScaffoldMessenger.of(
      NavigationService.navigatorKey.currentContext!,
    ).showSnackBar(snackBar);
  }

  ///For Check  Api Response
  static Future<bool> responseCheckMethod({
    http.Response? response,
    bool wantSnackBar = true,
    required bool ignore401StatusCode ,
  }) async {
    Map<String, dynamic> responseMap = jsonDecode(response?.body ?? "");
    if (wantSnackBar) {
      if (responseMap[ApiKeyConstants.message] != null) {
        snackBarView(
          title: responseMap[ApiKeyConstants.message],
          success: true,
        );
      }
      if (responseMap[ApiKeyConstants.error] != null) {
        snackBarView(title: responseMap[ApiKeyConstants.error]);
      }
    }
    if (response != null &&
        (response.statusCode == 200 || response.statusCode == 201)) {
      return true;
    } else if (response != null && response.statusCode == 401) {
      if(!ignore401StatusCode){
        NavigationService.pushAndRemoveUntil(AppRoutes.login);
      }
      return ignore401StatusCode?true:false;
    } else {
      return false;
    }
  }



  static void showAlertDialog({
    String title = 'Logout',
    String content = 'Would you like to logout?',
    VoidCallback? onPressedYes,
  }) {
    showCupertinoModalPopup<void>(
      context: NavigationService.navigatorKey.currentContext!,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: Text(title),
        content: Text(content),
        actions: <CupertinoDialogAction>[
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () => NavigationService.pop(),
            child: Text(StringConstants.no),
          ),
          CupertinoDialogAction(
            isDestructiveAction: true,
            onPressed: onPressedYes,
            child: Text(StringConstants.yes),
          ),
        ],
      ),
    );
  }
  //
  //
  /// --- SVG Loader ---
  static Widget svgIcon(String assetPath, {double? height,double? width, Color? color,BoxFit? fit}) {
    return SvgPicture.asset(
      assetPath,
      height: height ?? 20,
      width: width ?? 20,
      colorFilter:
      color != null ? ColorFilter.mode(color, BlendMode.srcIn) : null,
      fit: fit??BoxFit.fill,
    );
  }

  static void networkConnectionShowSnackBar() {
    snackBarView(title: "Check Your Internet Connection", success: false);
  }

  static void serverDownShowSnackBar() {
    snackBarView(title: "Server Down", success: false);
  }

  static Widget progressBar({
    bool isLoading = false,
    Widget? child,
    double? height,
    double? width,
  }) {
    return Container(
      height: height ?? 50.h,
      width: width ?? double.infinity,
      alignment: Alignment.center,
      child: isLoading
          ? Center(
              child: CircularProgressIndicator(
                color: AppColors.primary,
                strokeWidth: 4.w,
              ),
            )
          : child,
    );
  }
}

enum ErrorAnimationType { shake, clear }
