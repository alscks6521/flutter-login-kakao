import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:kakao_login_service/config/app_config.dart';
import 'package:kakao_login_service/screens/main_page.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'model/user_model.dart';
import 'screens/login_page.dart';

void main() {
  KakaoSdk.init(nativeAppKey: AppConfig.kakaoNativeKey);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => UserModel(
        nickname: '',
        email: '',
      ),
      child: const MaterialApp(
        home: LoginPage(),
      ),
    );
  }
}

// Future<bool> _getLoginState() async {
//   final prefs = await SharedPreferences.getInstance();
//   return prefs.getBool('isLogged') ?? false;
// }
