import 'package:flutter/material.dart';
final colorScheme1 = ColorScheme.fromSeed(seedColor: Colors.blueAccent);
final theme1 = 
  ThemeData(
    
  colorScheme: colorScheme1,
  navigationRailTheme: NavigationRailThemeData(
    backgroundColor: colorScheme1.surfaceContainer,
  ),
  //scaffoldBackgroundColor: const Color.fromARGB(255, 226, 228, 230),
  // bottomNavigationBarTheme: BottomNavigationBarThemeData(
  //   showSelectedLabels: true,
  //   showUnselectedLabels: true,
  //   backgroundColor: colorScheme1.primary,
  //   //selectedItemColor: colorScheme1.onPrimary,
  //   //unselectedItemColor: colorScheme1.onPrimary,
  //   selectedIconTheme: IconThemeData(color: colorScheme1.onPrimary),
  //   unselectedIconTheme: IconThemeData(color: colorScheme1.onPrimary),
  //   //selectedLabelStyle: TextStyle(fontWeight: FontWeight.normal, color: colorScheme1.onPrimary),
  //   //unselectedLabelStyle: TextStyle(fontWeight: FontWeight.normal, color: colorScheme1.onPrimary),
  // ),
  appBarTheme: AppBarTheme(
    
    backgroundColor: colorScheme1.primary,
    foregroundColor: colorScheme1.onPrimary,
    surfaceTintColor: Colors.transparent,
    scrolledUnderElevation: 0.0,
        ),
  useMaterial3: true,
  dividerColor: Colors.black26,
  // // textTheme: const TextTheme(
  // //   bodyMedium: TextStyle(
  // //     color: Colors.blueAccent,
  // //     fontWeight: FontWeight.w500,
  // //     fontSize: 20,
  // //   ),
  // //   labelSmall: TextStyle(
  // //     color: Colors.black26,
  // //     fontWeight: FontWeight.w700,
  // //     fontSize: 14,
  // //   ),
  // ),
);
