# Flutter을 이용한 Kakao_login_service 기능  

# 1차 Commit: 카카오 소셜 로그인 기능 & 동의항목 관련 정보 ( 프로필 ) 가져오기
**사용 패키지: kakao_flutter_sdk**  

<img src="https://github.com/alscks6521/login-kakao/assets/112923685/c0d8a444-a0f0-49c5-820d-50b6e48d0f12" width="20%">
<img src="https://github.com/alscks6521/login-kakao/assets/112923685/a1a59171-1fe3-40cf-8c50-8c19381432e4" width="20%">


### 친구 목록 가져오는 법 
**카카오 공식 문서** : [[https://developers.kakao.com/docs/latest/ko/message/common#kakaotalk  ](https://developers.kakao.com/docs/latest/ko/message/common#policy-request-permission) ](https://developers.kakao.com/docs/latest/ko/kakaotalk-social/common#policy-request-permission)  

#### 친구 목록을 가져오기 위해선 공식 문서에 써있듯이 "친구 정보 제공 조건"이 있다.  
이는 친구 목록과 친구 목록 가져오기 API의 응답은 다음 조건을 모두 만족하는 친구만 포함한다.  
1. 친구가 앱과 연결된 상태일 것  
2. 친구가 앱 연결 시 [카카오 서비스 내 친구 목록 제공] 동의항목에 동의한 상태일 것  
3. 친구가 숨김 또는 차단 친구가 아닐 것  
4. 친구의 프로필 공개 설정이 공개 상태일 것
