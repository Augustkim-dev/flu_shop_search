import 'package:flu_shop_search/app/src/screen/list/shop_detail_screen.dart';
import 'package:flu_shop_search/app/src/screen/main/main_screen.dart';
import 'package:flu_shop_search/app/src/screen/main/spalsh_screen.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  // Supabase Connect
  await Supabase.initialize(
    url: 'https://gocpskrrkaptukxazafb.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImdvY3Bza3Jya2FwdHVreGF6YWZiIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDYyNDY4MDIsImV4cCI6MjAyMTgyMjgwMn0.Eh_livKHLJfoR90PbovE0s5JTE-pe9x7qchMY4YpS-8',
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(),
        '/main': (context) => MainScreen(),
        '/shopdetail': (context) => ShopDetailScreen(),
      },
    );
  }
}
