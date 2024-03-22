import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';

import 'package:kakao_login_service/screens/main_page.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/user_model.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  void initLoginService(BuildContext context) async {
    try {
      var token = await UserApi.instance.loginWithKakaoTalk();
      debugPrint('카카오 로그인 성공, 액세스 토큰: ${token.accessToken}');
      var user = await UserApi.instance.me();

      // then, await의 차이를 알자.
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLogged', true);

      Provider.of<UserModel>(context, listen: false).nickname =
          user.kakaoAccount?.profile?.nickname ?? '';
      Provider.of<UserModel>(context, listen: false).profileimage =
          user.kakaoAccount?.profile?.profileImageUrl ?? '';

      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const MainPage()));

      // SharedPreferences.getInstance().then((prefs) {
      //   prefs.setBool('isLogged', true);

      //   Provider.of<UserModel>(context, listen: false).nickname =
      //       user.kakaoAccount?.profile?.nickname ?? '';
      //   Provider.of<UserModel>(context, listen: false).profileimage =
      //       user.kakaoAccount?.profile?.profileImageUrl ?? '';

      //   Navigator.pushReplacement(
      //       context, MaterialPageRoute(builder: (context) => const MainPage()));
      // });
    } catch (error) {
      debugPrint('카카오 로그인 실패 $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          child: const Text('카카오 로그인'),
          onPressed: () {
            initLoginService(context);
          },
        ),
      ),
    );
  }
}
// var token = await UserApi.instance.loginWithKakaoTalk();
//               print('카카오 로그인 성공, 액세스 토큰: ${token.accessToken}');
//               var user = await UserApi.instance.me();

//               Provider.of<UserModel>(context, listen: false).nickname =
//                   user.kakaoAccount?.profile?.nickname ?? '';
//               Provider.of<UserModel>(context, listen: false).profileimage =
//                   user.kakaoAccount?.profile?.profileImageUrl ?? '';

//               Navigator.pushReplacement(
//                   context, MaterialPageRoute(builder: (context) => const MainPage()));
    