import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:prototype_ss/firebase_options.dart';
import 'package:prototype_ss/page_controller.dart';
import 'package:provider/provider.dart';
import 'package:prototype_ss/provider/product_provider.dart';
import 'package:prototype_ss/provider/theme_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ProductsProvider()),
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return MaterialApp(
      title: 'Flutter Demo',
      theme: themeProvider.theme,
      home: const PageSwitcher(),
    );
  }
}