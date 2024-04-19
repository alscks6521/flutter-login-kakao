import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';

final FeedTemplate defaultFeed = FeedTemplate(
  content: Content(
    title: '템플릿 만들어 보내기~ 업데이트~',
    description: '#O케어 #플러터로 플러팅 #Flutter',
    imageUrl: Uri.parse(
        'https://mud-kage.kakao.com/dn/Q2iNx/btqgeRgV54P/VLdBs9cvyn8BJXB3o7N8UK/kakaolink40_original.png'),
    link: Link(
        webUrl: Uri.parse('https://developers.kakao.com'),
        mobileWebUrl: Uri.parse('https://developers.kakao.com')),
  ),
  itemContent: ItemContent(
    profileText: 'Kakao',
    profileImageUrl: Uri.parse(
        'https://mud-kage.kakao.com/dn/Q2iNx/btqgeRgV54P/VLdBs9cvyn8BJXB3o7N8UK/kakaolink40_original.png'),
    titleImageUrl: Uri.parse(
        'https://mud-kage.kakao.com/dn/Q2iNx/btqgeRgV54P/VLdBs9cvyn8BJXB3o7N8UK/kakaolink40_original.png'),
    titleImageText: 'Cheese cake',
    titleImageCategory: 'cake',
    items: [
      ItemInfo(item: 'cake1', itemOp: '1000원'),
    ],
    sum: 'total',
    sumOp: '15000원',
  ),
  social: Social(likeCount: 286, commentCount: 45, sharedCount: 845),
  buttons: [
    Button(
      title: '웹으로 보기',
      link: Link(
        webUrl: Uri.parse('https: //developers.kakao.com'),
        mobileWebUrl: Uri.parse('https: //developers.kakao.com'),
      ),
    ),
    Button(
      title: '앱으로보기',
      link: Link(
        androidExecutionParams: {'key1': 'value1', 'key2': 'value2'},
        iosExecutionParams: {'key1': 'value1', 'key2': 'value2'},
      ),
    ),
  ],
);
