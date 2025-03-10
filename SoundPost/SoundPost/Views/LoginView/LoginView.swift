import SwiftUI
import AuthenticationServices
import FirebaseAuth

struct LoginView: View {
    // TODO: 앱 로드 시 유저 정보 확인
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var isSignupBtnTapped: Bool = false
    @StateObject private var authViewModel: AuthViewModel = AuthViewModel()
    
    var body: some View {
        
        NavigationStack {
            VStack {
                // 상단 이미지: 로고 기입 예정
                Image(systemName: "heart.fill")
                    .resizable()
                    .frame(width: 80, height: 80)
                    .foregroundColor(.primaryNeon)
                
                // 로그인 화면 표지
                Text("로그인")
                    .font(.largeTitle)
                
                Spacer().frame(height: 30)
                
                // 이메일 텍스트 밑 텍스트필드
                HStack {
                    Text("이메일")
                    Spacer()
                }
                
                TextField("이메일을 입력하세요", text: $email)
                    .autocorrectionDisabled()
                    .textInputAutocapitalization(.never)
                    .padding(10)
                    .border(.figmaGray)
                    .clipShape(.rect(cornerRadius: 5))
                
                Spacer().frame(height: 10)
                
                // 비밀번호 텍스트 및 텍스트필드
                HStack {
                    Text("비밀번호")
                    Spacer()
                }
                TextField("비밀번호를 입력하세요", text: $password)
                    .autocorrectionDisabled()
                    .textInputAutocapitalization(.never)
                    .padding(10)
                    .border(.figmaGray)
                    .clipShape(.rect(cornerRadius: 5))
                
                Spacer().frame(height: 30)
                
                // 로그인 버튼
                Button {
                    FirebaseManager.shared.emailSignIn(email: email, password: password) { email, uid in
                        // 최초 로그인 시 로그인과 uid 업데이트
                        authViewModel.email = email ?? ""
                        authViewModel.uid = uid ?? ""
                        // 최초 로그인 시 유저 디폴트에 데이터 저장
                        authViewModel.saveUserAtDefaults()
                        // 유저 정보를 스토어에서 가져와 업데이트 기존에 nil이었던 것에 값이 할당되며 컨텐츠 뷰로 이동
                        authViewModel.getUserByUID()
                        
                        
                    }
                } label: {
                    Text("로그인")
                        .foregroundStyle(.black)
                        .frame(maxWidth: .infinity)
                        .padding(10)
                        .background(
                            RoundedRectangle(cornerRadius: 5)
                                .foregroundStyle(.primaryNeon)
                        )
                }
               
                
                Button(action: {
                    print ("SignUP btn tapped")
                    isSignupBtnTapped = true
                }) {
                    Text("회원가입")
                        .foregroundStyle(.black)
                        .underline()
                        .padding(10)
                }
                
                Spacer().frame(height: 30)
                
                // Apple login btn
                AppleLoginBtnView()
            }
            .sheet(isPresented: $isSignupBtnTapped, content: {
                SignupView()
            })
            .padding()
            // user에 값이 할당되면 넘어감
            .navigationDestination(item: $authViewModel.user) { user in
                ContentView()
                    .environmentObject(authViewModel)
                    .navigationBarBackButtonHidden(true)
            }
        }
    }
}

struct AppleLoginBtnView: View {
    var body: some View {
        SignInWithAppleButton(.signIn) { request in
            // 로그인 요청 처리
            request.requestedScopes = [.fullName, .email]
        } onCompletion: { result in
            // 로그인 결과 처리
            switch result {
            case .success(let authResults):
                print("성공: \(authResults)")
            case .failure(let error):
                print("실패: \(error.localizedDescription)")
            }
        }
        .frame(maxWidth: .infinity, maxHeight: 40) // 버튼 크기 조정
        .signInWithAppleButtonStyle(.black) // 스타일 변경 가능
    }
}
//
//#Preview {
//    LoginView()
//}
