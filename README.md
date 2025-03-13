# ⚡ SoundPost - “소리로 통하는 우리”

## ✨ 음성 기반 SNS
**SoundPost**는 사용자가 자유롭게 자신의 목소리를 공유하고 소통할 수 있는 음성 기반 SNS입니다. 90초 이내의 음성 게시물을 통해 감정을 나누고, 다양한 이야기로 소통할 수 있습니다.

## Targets
- 텍스팅이 어려운 저연령층
- 눈이 잘 보이지 않는 고연령층
- 문맹율이 높은 국가의 사람들
- 일반적인 SNS에 질린 사람들

---

## 🔹 기능
- 음성 녹음과 사진으로 된 포스트 업로드
- 녹음을 이용한 음성 답글 시스템
- 퀵스타트 버튼을 통한 편리한 포스팅
- 최신피드 확인 가능
- 자동 로그인 기능

---

## ⚡ 팀원
- **이재용** - FirebaseManager, StorageManager 등 파이어베이스 관련 기능 일체 & 로그인 - 회원가입 기능 
- **윤영서** - HomeView, MyPofileView 
- **최하진** - 음성 녹음, 포토 피커, 포스트 게시 등 QuickStart 기능, Comment 추가 기능

---

## 🛠 기술 스택
- **Frontend**: SwiftUI
- **Database**: FirebaseStore, FirebaseStorage
- **Authentification**: FirebaseAuth
- **Audio Processing**: AVFoundation
- **PhotosPicker**: PhotosUI 
---

## 🚀 기능 소개
### 홈 화면 (HomeView2.swift)
- 최신 포스트를 한눈에 볼 수 있는 피드
- Firestore 연동으로 실시간 데이터 반영

### 프로필 화면 (ProfileView.swift)
- 개인 프로필과 포스트를 모아둔 피드
- 설정을 통한 알림, 로그아웃 지원

### 빠른 시작 (QuickStartButtonView.swift)
- 녹음, 이미지 파일 업로드 기능 제공
- 게시물 업로드 전 미리 듣기, 재녹음 기능

### 포스트 상세 화면 (PostDetailView.swift)
- 포스트 내용 확인 및 댓글 기능

---


## 📌 화면 상세
1. **HomeView2** - 홈 화면
2. **ProfileView** - 프로필 화면
3. **PostDetailView** - 포스트 상세 화면
4. **QuickStartButtonView** - 빠른 시작 버튼
5. 
## 📱 앱 UI 미리보기

1. **HomeView2** - 홈 화면
 <img src="https://github.com/user-attachments/assets/722251d7-ab34-4c95-b506-2340497c2873" width="30%" height="30%"/>
 
2. **ProfileView** - 프로필 화면
   
<p align="center">
  <img src="https://github.com/user-attachments/assets/0aed2195-ae52-4ab4-9f53-ccf6ac86935c" width="30%" height="30%"/>
  <img src="https://github.com/user-attachments/assets/d16eeeb7-c2d1-4726-8aab-54a0a6fbf76b" width="30%" height="30%"/>
</p>

3. **PostDetailView** - 포스트 상세 화면

<p align="center">
  <img src="https://github.com/user-attachments/assets/7d3a652e-472b-4523-ab4f-d2a37c902ae8" width="30%" height="30%"/>
  <img src="https://github.com/user-attachments/assets/f9a348f2-656d-4eb8-b9a8-4500abc57639" width="30%" height="30%"/>
  <img src="https://github.com/user-attachments/assets/4ce88303-70ff-4384-a48b-0f6d1dc98365" width="30%" height="30%"/>
  <img src="https://github.com/user-attachments/assets/6acdcbcc-956c-4657-9498-71f0faccf7cc" width="30%" height="30%"/>
</p>

4. **QuickStartButtonView** - 빠른 시작 버튼
 
<p align="center">
  <img src="https://github.com/user-attachments/assets/fd8e83ab-2d83-4178-b086-061331d07d62" width="30%" height="30%"/>
  <img src="https://github.com/user-attachments/assets/882199e5-7069-4af7-a1e4-a6e6dcbde23a" width="30%" height="30%"/>
  <img src="https://github.com/user-attachments/assets/e9f1a242-e9f3-4469-9055-cd58b59acfc6" width="30%" height="30%"/>
  <img src="https://github.com/user-attachments/assets/4930c04b-2771-4527-9168-3df858e6e305" width="30%" height="30%"/>
  <img src="https://github.com/user-attachments/assets/5de38327-e32f-4ece-98a5-33f4318da8cd" width="30%" height="30%"/>
  <img src="https://github.com/user-attachments/assets/c1b1248e-d123-497a-82b1-ca76cd1e3745" width="30%" height="30%"/>
</p>



## 🔄 업데이트 및 개선 목표
- 기능 업데이트: 포스팅의 녹음시간 제한, 녹음 중 시간 UI업데이트
- 전체 검색 기능 추가 예정
- 코멘트 기능 추가

---

## 🎯 기술 요구사항
- SwiftUI, Firebase, AVFoundation
- Xcode 16.2+

💡 **피드백 환영합니다!**


팀원 회고

**이재용**
- 파이어베이스 처음 써봐서 그런지 너무 힘들었다. 일반적인 데이터베이스처럼 연계형으로 될 줄 알았는데 그게 아니어서 API호출이 잦아지는 문제가 생겼다
- 의견 교환이 많아서 재미있었다 설득하고 설득 당하는 과정에서 얻어가는게 많았다
- 스토리지와 스토어를 분리해서 관리했던 게 재미있었다.

**최하진**
- [Swift에 대한 심화 공부]
- MVVM패턴으로 구현하려고 노력하는 과정이 재밌었습니다.
- StateObject와 ObservedObjec의 차이에 대해서 공부하였습니다.
- AVFoundation을 통한 오디오 녹음, 재생을 다루는 법을 배웠습니다. 
- TabBar 커스텀과 QuickStartbuttonView의 상호작용을 만들어 기획에 가깝게 원하는 그림을 만들어 낸 점이 힘들었지만 뿌듯했습니다.

- [기획과 커뮤니케이션의 중요성]
- 이전 경험을 바탕으로 이번엔 충분한 기획과 더 많은 논의로 앱제작을 효율적으로 할 수 있었습니다. 
- 작은 버튼 위치, 뷰 배치 등 에서 각자가 익숙하게 사용하는 앱이나 손 방향 등 사용자 경험이 달라 생기는 생각의 차이를 크게 느꼈고 의견을 합의해나가는 법을 배웠습니다.

- [아쉬운 점]
- 시간관계 상 가장 기본이 되는 기능인 녹음, 포스팅, 답글 녹음, 포스팅 기능에 초점을 두고 구현해냈기 때문에 녹음 중 시간 UI 업데이트 잘 안되고 그 외 몇몇 기능을 구현 못한 점이 아쉽습니다.
