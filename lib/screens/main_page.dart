import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:kakao_login_service/constants/constants.dart';
import 'package:kakao_login_service/model/friend_kakao.dart';
import 'package:kakao_login_service/model/picker_item.dart';
import 'package:kakao_login_service/temple/temple.dart';
import 'package:kakao_login_service/utils/font_styles.dart';
import 'package:provider/provider.dart';
import '../model/user_model.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel>(context);

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(title: const Text('메인 페이지')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'name: ${user.nickname}',
              style: FontDefault.defaultFont,
            ),
            Text(
              'email: ${user.email}',
              style: FontDefault.defaultFont,
            ),
            ElevatedButton(
              child: const Text('메시지 고!'),
              onPressed: () async {
                // 카카오톡 친구 목록 가져오기
                Friends friends;
                try {
                  friends = await TalkApi.instance.friends();
                  print('카카오톡 친구 목록 가져오기 성공'
                      '\n${friends.elements?.map((friend) => friend.profileNickname).join('\n')}');
                } catch (error) {
                  print('카카오톡 친구 목록 가져오기 실패 $error');
                  // 메시지를 보낼 수 있는 친구 정보 가져오기에 실패한 경우에 대한 예외 처리 필요
                  return;
                }

                if (friends.elements == null) {
                  // 메시지를 보낼 수 있는 친구가 없는 경우에 대한 예외 처리 필요
                  return;
                }

                if (friends.elements!.isEmpty) {
                  print('메시지를 보낼 친구가 없습니다 ${friends.elements}');
                } else {
                  // 서비스에 상황에 맞게 메시지 보낼 친구의 UUID를 가져옵니다.
                  // 이 예제에서는 친구 목록을 화면에 보여주고 체크박스로 선택된 친구들의 UUID를 수집하도록 구현했습니다.
                  List<String> selectedItems = await Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => FriendPage(
                        items: friends.elements!
                            .map((friend) => PickerItem(friend.uuid, friend.profileNickname ?? '',
                                friend.profileThumbnailImage))
                            .toList(),
                      ),
                    ),
                  );

                  if (selectedItems.isEmpty) {
                    // 메시지를 보낼 친구를 선택하지 않은 경우에 대한 예외 처리 필요
                    return;
                  }
                  print('선택된 친구:\n${selectedItems.join('\n')}');

                  // 메시지를 보낼 친구의 UUID 목록
                  List<String> receiverUuids = selectedItems;
                  setState(() {
                    Provider.of<UserModel>(context, listen: false).friends = selectedItems;
                  });

                  // // 사용자 정의 템플릿 ID
                  // int templateId = 106428;

                  // // 사용자 정의 템플릿으로 메시지 보내기
                  // try {
                  //   MessageSendResult result = await TalkApi.instance.sendCustomMessage(
                  //     receiverUuids: receiverUuids,
                  //     templateId: templateId,
                  //   );
                  //   print('메시지 보내기 성공 ${result.successfulReceiverUuids}');

                  //   if (result.failureInfos != null) {
                  //     print('일부 대상에게 메시지 보내기 실패'
                  //         '\n${result.failureInfos}');
                  //   }
                  // } catch (error) {
                  //   print('메시지 보내기 실패 $error');
                  // }
                }

                // // 사용자 정의 템플릿 ID
                // int templateId = 106428;
                // try {
                //   await TalkApi.instance.sendCustomMemo(templateId: templateId);
                //   print('나에게 보내기 성공');
                // } catch (error) {
                //   print('나에게 보내기 실패 $error');
                // }
              },
            ),
            ElevatedButton(
              onPressed: () async {
                List<String> receiverUuids = user.friends!;
                debugPrint("friend 메시지");
// 피드 메시지, 메시지 만들기 참고
                FeedTemplate template = defaultFeed;

                // 기본 템플릿으로 메시지 보내기
                try {
                  MessageSendResult result = await TalkApi.instance.sendDefaultMessage(
                    receiverUuids: receiverUuids,
                    template: template,
                  );
                  print('메시지 보내기 성공 ${result.successfulReceiverUuids}');

                  if (result.failureInfos != null) {
                    print('일부 대상에게 메시지 보내기 실패'
                        '\n${result.failureInfos}');
                  }
                } catch (error) {
                  print('메시지 보내기 실패 $error');
                }

                // // 메시지를 보낼 친구의 UUID 목록

                // // 사용자 정의 템플릿 ID
                // int templateId = 106428;

                // // 사용자 정의 템플릿으로 메시지 보내기
                // try {
                //   MessageSendResult result = await TalkApi.instance.sendCustomMessage(
                //     receiverUuids: receiverUuids,
                //     templateId: templateId,
                //   );
                //   print('메시지 보내기 성공 ${result.successfulReceiverUuids}');

                //   if (result.failureInfos != null) {
                //     print('일부 대상에게 메시지 보내기 실패'
                //         '\n${result.failureInfos}');
                //   }
                // } catch (error) {
                //   print('메시지 보내기 실패 $error');
                // }
              },
              child: const Text("친구"),
            )

            // Image.network(
            //   user.profileimage,
            //   width: 100,
            //   height: 100,
            //   fit: BoxFit.cover,
            // )
          ],
        ),
      ),
    );
  }
}
