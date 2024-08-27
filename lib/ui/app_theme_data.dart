import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:task_management/ui/app_colors.dart';

class AppThemeData {
  static final ThemeData lightTheme = ThemeData(
    primaryColor: AppColors.lightItem,
    primaryColorDark: AppColors.darkItem,
    primaryColorLight: AppColors.blueColor,
    dropdownMenuTheme: const DropdownMenuThemeData(
      menuStyle: MenuStyle(
        backgroundColor: WidgetStatePropertyAll(
          AppColors.lightItem,
        ),
      ),
    ),
    secondaryHeaderColor: AppColors.sunColor,
    dividerColor: AppColors.greyColor,
    scaffoldBackgroundColor: AppColors.lightBackGround,
    appBarTheme: const AppBarTheme(color: AppColors.blueColor),
    elevatedButtonTheme: const ElevatedButtonThemeData(
        style: ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(AppColors.blueColor))),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      showSelectedLabels: false,
      showUnselectedLabels: false,
      unselectedItemColor: AppColors.greyColor,
      selectedItemColor: AppColors.blueColor,
      backgroundColor: AppColors.lightItem,
    ),
    bottomAppBarTheme: const BottomAppBarTheme(
      color: AppColors.lightItem,
      shape: CircularNotchedRectangle(),
      elevation: 0,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      iconSize: 30,
      backgroundColor: AppColors.blueColor,
      elevation: 0,
      foregroundColor: AppColors.whiteColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
        side: const BorderSide(width: 4, color: AppColors.whiteColor),
      ),
    ),
    textTheme: TextTheme(
      titleLarge: GoogleFonts.poppins(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: AppColors.whiteColor,
      ),
      titleMedium: GoogleFonts.poppins(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: AppColors.blackColor,
      ),
      titleSmall: GoogleFonts.inter(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: AppColors.blackColor,
      ),
      labelMedium: GoogleFonts.inter(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: AppColors.blackColor,
      ),
      bodyMedium: GoogleFonts.inter(
        fontSize: 16,
        color: AppColors.blackColor,
      ),
      bodySmall: GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: AppColors.greyColor,
      ),
      labelLarge: GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: AppColors.whiteColor,
      ),
      labelSmall: GoogleFonts.inter(
        fontSize: 13,
        fontWeight: FontWeight.w600,
        color: AppColors.whiteColor,
      ),
      displaySmall: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: AppColors.redColor,
      ),
      headlineMedium: GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: AppColors.whiteColor,
      ),
      headlineSmall: GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: AppColors.blackColor,
      ),
      displayMedium: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: AppColors.blackColor,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: const BorderSide(color: AppColors.greyColor),
      ),
      labelStyle: const TextStyle(color: AppColors.greyColor),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: const BorderSide(color: AppColors.greyColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: const BorderSide(color: AppColors.blueColor),
      ),
      contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
    ),
  );
  static final ThemeData darkTheme = ThemeData(
    primaryColor: AppColors.darkItem,
    primaryColorDark: AppColors.lightItem,
    primaryColorLight: AppColors.darkDropDownColor,
    secondaryHeaderColor: AppColors.moonColor,
    iconTheme: const IconThemeData(color: AppColors.moonColor),
    dividerColor: AppColors.greyColor,
    scaffoldBackgroundColor: AppColors.darkBackGround,
    appBarTheme: const AppBarTheme(color: AppColors.blueColor),
    elevatedButtonTheme: const ElevatedButtonThemeData(
        style: ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(AppColors.blueColor))),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      showSelectedLabels: false,
      showUnselectedLabels: false,
      unselectedItemColor: AppColors.greyColor,
      selectedItemColor: AppColors.blueColor,
      backgroundColor: AppColors.darkItem,
    ),
    bottomAppBarTheme: const BottomAppBarTheme(
      color: AppColors.darkItem,
      shape: CircularNotchedRectangle(),
      elevation: 0,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      iconSize: 30,
      backgroundColor: AppColors.blueColor,
      elevation: 0,
      foregroundColor: AppColors.blackColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
        side: const BorderSide(width: 4, color: AppColors.blackColor),
      ),
    ),
    splashFactory: NoSplash.splashFactory,
    bottomSheetTheme:
        const BottomSheetThemeData(backgroundColor: AppColors.darkItem),
    cardTheme: const CardTheme(color: AppColors.darkItem),
    textTheme: TextTheme(
      titleLarge: GoogleFonts.poppins(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: AppColors.blackColor,
      ),
      titleMedium: GoogleFonts.poppins(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: AppColors.whiteColor,
      ),
      titleSmall: GoogleFonts.inter(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: AppColors.whiteColor,
      ),
      labelMedium: GoogleFonts.inter(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: AppColors.whiteColor,
      ),
      bodyMedium: GoogleFonts.inter(
        fontSize: 16,
        color: AppColors.whiteColor,
      ),
      bodySmall: GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: AppColors.greyColor,
      ),
      labelLarge: GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: AppColors.blackColor,
      ),
      labelSmall: GoogleFonts.inter(
        fontSize: 13,
        fontWeight: FontWeight.w600,
        color: AppColors.blackColor,
      ),
      displaySmall: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: AppColors.redColor,
      ),
      headlineMedium: GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: AppColors.whiteColor,
      ),
      headlineSmall: GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: AppColors.whiteColor,
      ),
      displayMedium: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: AppColors.whiteColor,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: const BorderSide(color: AppColors.greyColor),
      ),
      labelStyle: const TextStyle(color: AppColors.whiteColor),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: const BorderSide(color: AppColors.greyColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: const BorderSide(color: AppColors.blueColor),
      ),
      contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
    ),
  );
}
