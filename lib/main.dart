import 'package:flutter/material.dart';
import 'package:flutter_classes/widgets/expenses.dart';
import 'package:flutter/services.dart';



var kColorSchene=ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 80, 164, 114));
var kDarkColorScheme=ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 5, 99, 125),brightness: Brightness.dark);

void main(){
  // SystemChrome.setPreferredOrientations(DeviceOrientation.portraitUp as List<DeviceOrientation>).then((fn){
  
  runApp(
     MaterialApp(
      debugShowCheckedModeBanner: false,
      darkTheme: ThemeData.dark().copyWith(
        useMaterial3: true,
        colorScheme: kDarkColorScheme,
        cardTheme: CardTheme().copyWith(
            color: kDarkColorScheme.secondaryContainer,
            margin: EdgeInsets.symmetric(vertical: 8,horizontal: 16),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(style: ElevatedButton.styleFrom(
            backgroundColor: kDarkColorScheme.primaryContainer,
            foregroundColor: kDarkColorScheme.onPrimaryContainer),
          ),
      ),
      themeMode: ThemeMode.system,
      
      theme: ThemeData().copyWith(


          scaffoldBackgroundColor: Color.fromARGB(255, 174, 196, 210),
          colorScheme: kColorSchene,
          appBarTheme: AppBarTheme().copyWith(
            backgroundColor: kColorSchene.onPrimaryContainer,
            foregroundColor: kColorSchene.primaryContainer,
            elevation: 30,
            
          ),
          cardTheme: CardTheme().copyWith(
            color: kColorSchene.secondaryContainer,
            margin: EdgeInsets.symmetric(vertical: 8,horizontal: 16),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(style: ElevatedButton.styleFrom(
            backgroundColor: kColorSchene.primaryContainer,),
          ),
          textTheme: ThemeData().textTheme.copyWith(
            titleLarge: TextStyle(
              fontWeight: FontWeight.bold,
              color: kColorSchene.onSecondaryContainer,
              fontSize: 24
            )
          )
          ),

          
      home: const Expenses(),
    )
  );
}
  


