import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DarkTheme {
  static BorderRadius buttonBorder = BorderRadius.circular(15);
  static TextTheme textTheme = TextTheme(
    displayLarge: TextStyle(fontWeight: FontWeight.w900, fontSize: 57, height: 1),
    displayMedium: TextStyle(fontWeight: FontWeight.w900, fontSize: 45, height: 1),
    displaySmall: TextStyle(fontWeight: FontWeight.w900, fontSize: 36, height: 1),
    headlineLarge: TextStyle(fontWeight: FontWeight.w800, fontSize: 32, height: 1),
    headlineMedium: TextStyle(fontWeight: FontWeight.w800, fontSize: 28, height: 1),
    headlineSmall: TextStyle(fontWeight: FontWeight.w900, fontSize: 24, height: 1),
    titleLarge: TextStyle(fontWeight: FontWeight.w500, fontSize: 22),
    titleMedium: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
    titleSmall: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
    bodyLarge: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
    bodyMedium: TextStyle(fontWeight: FontWeight.w400, fontSize: 14),
    bodySmall: TextStyle(fontWeight: FontWeight.w400, fontSize: 12),
    labelLarge: TextStyle(fontWeight: FontWeight.w400, fontSize: 14),
    labelMedium: TextStyle(fontWeight: FontWeight.w400, fontSize: 12),
    labelSmall: TextStyle(fontWeight: FontWeight.w400, fontSize: 11),
  );

  static ColorScheme colorScheme = ColorScheme(
    brightness: Brightness.dark,
    primary: Color(0xFFB86AC7),
    onPrimary: Color(0xFF3A003F),
    secondary: Color(0xFFD6A3DE),
    onSecondary: Color(0xFF3A003F),
    tertiary: Color(0xFF9C4DA6),
    onTertiary: Color(0xFFFFFFFF),
    surface: Color(0xFF1A161B),
    onSurface: Color(0xFFEDE7EE),
    surfaceContainerHigh: Color(0xFF3A2C3E),
    onSurfaceVariant: Color(0xFFD9C7DD),
    error: Color(0xFFF2B8B5),
    onError: Color(0xFF601410),
    outline: Color(0xFF8F7A92),
    shadow: Color(0xFF000000),
    inverseSurface: Color(0xFFEDE7EE),
    onInverseSurface: Color(0xFF1F1A1D),
    inversePrimary: Color(0xFF690679),
  );

  static InputDecorationTheme inputTheme = InputDecorationTheme(
    hintStyle: textTheme.bodyLarge,
    errorStyle: textTheme.bodyLarge!.copyWith(color: colorScheme.error, overflow: TextOverflow.visible),
    labelStyle: textTheme.bodyLarge!.copyWith(height: 1),
    helperStyle: textTheme.bodySmall!.copyWith(overflow: TextOverflow.visible),
    prefixStyle: textTheme.bodyLarge,
    suffixStyle: textTheme.bodyLarge,
    contentPadding: const EdgeInsets.all(16),
    iconColor: colorScheme.primary,
    suffixIconColor: colorScheme.primary,
    prefixIconColor: colorScheme.primary,
    filled: true,
    fillColor: colorScheme.surfaceDim.withAlpha(75),
    constraints: BoxConstraints.loose(Size.infinite),
    helperMaxLines: 2,
    errorMaxLines: 2,
    errorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: colorScheme.error.withAlpha(75)),
      borderRadius: buttonBorder,
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: colorScheme.surfaceDim.withAlpha(75), width: 0),
      borderRadius: buttonBorder,
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: colorScheme.error),
      borderRadius: buttonBorder,
    ),
    disabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: colorScheme.surfaceDim.withAlpha(75), width: 0),
      borderRadius: buttonBorder,
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: colorScheme.surfaceDim.withAlpha(75), width: 0),
      borderRadius: buttonBorder,
    ),
    border: OutlineInputBorder(
      borderSide: BorderSide(color: colorScheme.surfaceDim.withAlpha(125), width: 0),
      borderRadius: buttonBorder,
    ),
  );
  static ThemeData data = ThemeData(
    scaffoldBackgroundColor: colorScheme.surface,
    fontFamily: 'Playfair',
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: colorScheme,
    elevatedButtonTheme: const ElevatedButtonThemeData(style: ButtonStyle(elevation: WidgetStatePropertyAll<double>(0))),
    dialogTheme: DialogThemeData(backgroundColor: colorScheme.surface, surfaceTintColor: colorScheme.surface),
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: colorScheme.surface,
      surfaceTintColor: colorScheme.surface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(15))),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        minimumSize: Size(10, 60),
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.surface,
        disabledBackgroundColor: colorScheme.surfaceDim.withAlpha(125),
        disabledForegroundColor: colorScheme.onSurface.withAlpha(125),
        textStyle: textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w800),
        padding: EdgeInsets.all(20),
        shape: RoundedRectangleBorder(borderRadius: buttonBorder),
        elevation: 0,
      ),
    ),
    iconButtonTheme: IconButtonThemeData(style: IconButton.styleFrom(padding: EdgeInsets.zero)),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: ButtonStyle(
        minimumSize: const WidgetStatePropertyAll<Size>(Size(10, 60)),
        elevation: const WidgetStatePropertyAll<double>(0),
        backgroundColor: WidgetStateColor.resolveWith((Set<WidgetState> states) {
          if (states.contains(WidgetState.disabled)) {
            return colorScheme.surfaceDim.withAlpha(76);
          }
          return Colors.transparent;
        }),
        foregroundColor: WidgetStatePropertyAll<Color>(colorScheme.onSurface),
        shadowColor: WidgetStatePropertyAll<Color>(colorScheme.surface),
        surfaceTintColor: WidgetStatePropertyAll<Color>(colorScheme.surface),
        side: WidgetStateProperty.resolveWith((Set<WidgetState> states) {
          if (states.contains(WidgetState.disabled)) {
            return BorderSide(color: colorScheme.surfaceDim);
          }
          return BorderSide(color: colorScheme.primary);
        }),
        shape: WidgetStatePropertyAll<OutlinedBorder>(RoundedRectangleBorder(borderRadius: buttonBorder)),
        textStyle: WidgetStatePropertyAll<TextStyle?>(textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w800)),
      ),
    ),
    progressIndicatorTheme: ProgressIndicatorThemeData(color: colorScheme.surface),
    chipTheme: ChipThemeData(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5), side: BorderSide(width: 0)),
      elevation: 0,
      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 0),
    ),
    dividerTheme: DividerThemeData(color: colorScheme.outline, thickness: .5),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: buttonBorder),
        elevation: 0,
        minimumSize: Size(10, 60),
        textStyle: textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w700),
      ),
    ),
    textTheme: textTheme,
    dropdownMenuTheme: DropdownMenuThemeData(
      inputDecorationTheme: inputTheme,
      menuStyle: MenuStyle(
        backgroundColor: WidgetStatePropertyAll<Color>(colorScheme.surface),
        surfaceTintColor: WidgetStatePropertyAll<Color>(colorScheme.surfaceDim),
        shape: WidgetStatePropertyAll<OutlinedBorder>(
          RoundedRectangleBorder(
            side: BorderSide(color: colorScheme.outline),
            borderRadius: buttonBorder,
          ),
        ),
      ),
    ),
    iconTheme: IconThemeData(size: 24, color: colorScheme.onSurface),
    inputDecorationTheme: inputTheme,
    tabBarTheme: TabBarThemeData(unselectedLabelStyle: textTheme.titleSmall, labelStyle: textTheme.titleLarge),
    appBarTheme: AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle(statusBarIconBrightness: Brightness.dark),
      shadowColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      backgroundColor: Colors.transparent,
      centerTitle: true,
      elevation: 0,
      titleTextStyle: textTheme.titleLarge!.copyWith(color: colorScheme.primary),
    ),
    navigationBarTheme: NavigationBarThemeData(
      labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
      elevation: 0,
      backgroundColor: colorScheme.primary,
      indicatorColor: Colors.transparent,
      overlayColor: WidgetStatePropertyAll(colorScheme.primary),
      surfaceTintColor: colorScheme.secondary,
      iconTheme: WidgetStatePropertyAll(
        IconThemeData(
          size: 35,
          color: colorScheme.tertiary,
        ),
      ),
      labelTextStyle: WidgetStatePropertyAll(
        textTheme.labelLarge!.copyWith(
          color: colorScheme.surface,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
  );
}
