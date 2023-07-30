import 'package:flutter/material.dart';
import 'package:shop_delivery/core/app_feature/presentation/screens/initial_screen.dart';
import 'package:shop_delivery/injection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

 final res= await init().then((value) {
     runApp(const InitialScreen());
  });

}
