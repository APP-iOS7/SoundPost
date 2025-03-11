# ⚡ SoundPost - “소리로 통하는 우리”

## ✨ 음성 기반 SNS
**SoundPost**는 사용자가 자유롭게 자신의 목소리를 공유하고 소통할 수 있는 음성 기반 SNS입니다. 90초 이내의 음성 게시물을 통해 감정을 나누고, 다양한 이야기로 소통할 수 있습니다.

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
- **Backend**: Firebase
- **Audio Processing**: AVFoundation

---

## 🚀 기능 소개
### 홈 화면 (HomeView2.swift)
- 최신 포스트를 한눈에 볼 수 있는 피드
- Firestore 연동으로 실시간 데이터 반영

### 프로필 화면 (ProfileView.swift)
- 탭에 따라 주요 화면 전환
- **홈(HomeView2)** & **프로필(ProfileView)** 지원

### 빠른 시작 (QuickStartButtonView.swift)
- 녹음, 파일 업로드 기능 제공
- 게시물 업로드 전 미리 듣기 가능

### 포스트 상세 화면 (PostDetailView.swift)
- 포스트 내용 확인 및 댓글 기능

---


## 📌 화면 상세
1. **HomeView2** - 홈 화면
2. **ContentView** - 메인 화면
3. **PostDetailView** - 포스트 상세 화면
4. **QuickStartButtonView** - 빠른 시작 버튼


## 🔄 업데이트 및 개선 목표
- 기능 업데이트: 포스팅의 녹음시간 제한
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

