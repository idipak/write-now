
import 'package:bhealth/utils/colors.dart';
import 'package:flutter/material.dart';

const defaultFontFamily = 'Mulish';

class AppTheme{
  static TextTheme lightTextTheme = const TextTheme().copyWith(
    bodySmall: const TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: kDarkGrey),
    bodyMedium: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: kDarkGrey),
    bodyLarge: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: kDarkGrey),
    titleSmall: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: kAppBlue),
    titleMedium: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: kAppBlue),
    titleLarge: const TextStyle(fontSize: 20, fontWeight: FontWeight.w400, color: kDarkGrey),
    labelLarge: const TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: kAppBlue),
    labelMedium: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: kAppBlue),
    labelSmall: const TextStyle(fontSize: 8, fontWeight: FontWeight.w400, color: kAppBlue),

  );

  static ThemeData light() {
    return ThemeData(
      useMaterial3: true,
      fontFamily: defaultFontFamily,
      scaffoldBackgroundColor: kWhit100,
      brightness: Brightness.light,
      colorScheme: ColorScheme.fromSeed(seedColor: kAppBlue),
      textTheme: lightTextTheme,
      primaryColor: kAppBlue,
      cardColor: Colors.white,
      appBarTheme: const AppBarTheme().copyWith(
          backgroundColor: Colors.transparent,
          elevation: 0,
        titleTextStyle: const TextStyle(fontSize: 20, color: kDarkGrey, fontWeight: FontWeight.w400)
      ),

      cardTheme: const CardTheme(
        color: Colors.white,
        elevation: 0,
        margin: EdgeInsets.only(bottom: 24)
      ),

      iconButtonTheme: const IconButtonThemeData(
        style: ButtonStyle(
          foregroundColor: MaterialStatePropertyAll(kAppBlue),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        )
      ),

      textButtonTheme: const TextButtonThemeData(
        style: ButtonStyle(
          textStyle: MaterialStatePropertyAll(TextStyle(fontSize: 12, fontWeight: FontWeight.w400))
        )
      ),

      bottomSheetTheme: const BottomSheetThemeData(
        showDragHandle: true,
        modalBackgroundColor: kWhit100,
        surfaceTintColor: Colors.transparent
      ),

      inputDecorationTheme: const InputDecorationTheme(
        hintStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: kGrey200)
      ),

      dialogTheme: DialogTheme(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        alignment: Alignment.center,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))
      )

    );
  }
}

const kFont12Grey = TextStyle(
  color: Color(0xFF2F3B42),
  fontSize: 12,
  fontFamily: defaultFontFamily,
  fontWeight: FontWeight.w400,
  letterSpacing: 0.25,
);

const kFont12Blue700 = TextStyle(
  color: kDarkBlue,
  fontSize: 12,
  fontFamily: defaultFontFamily,
  fontWeight: FontWeight.w700,
  letterSpacing: 0.10,
);

const kFont14Blue700 = TextStyle(
  color: kDarkBlue,
  fontSize: 12,
  fontFamily: defaultFontFamily,
  fontWeight: FontWeight.w700,
  letterSpacing: 0.10,
);

const kFont12Blue500 = TextStyle(
  color: Color(0xFF2F3B42),
  fontSize: 12,
  fontFamily: defaultFontFamily,
  fontWeight: FontWeight.w400,
  letterSpacing: 0.25,
);