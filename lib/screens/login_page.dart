// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:kakao_login_service/constants/constants.dart';
import 'package:kakao_login_service/screens/main_page.dart';
import 'package:kakao_login_service/utils/font_styles.dart';
import 'package:provider/provider.dart';
import '../model/user_model.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  void initLoginService(BuildContext context) async {
    try {
      var token = await UserApi.instance.loginWithKakaoTalk();
      debugPrint('카카오 로그인 성공, 액세스 토큰: ${token.accessToken}');
      var user = await UserApi.instance.me();

      Provider.of<UserModel>(context, listen: false).nickname =
          user.kakaoAccount?.profile?.nickname ?? '';
      Provider.of<UserModel>(context, listen: false).email = user.kakaoAccount?.email ?? '';

      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const MainPage()));
    } catch (error) {
      debugPrint('카카오 로그인 실패 $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Kakao Login",
              style: FontDefault.bigFont,
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                initLoginService(context);
              },
              child: const Text(
                '카카오 연동하기',
                style: TextStyle(fontSize: 15),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
