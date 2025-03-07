import SwiftUI
import AuthenticationServices

struct LoginView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    var body: some View {
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
                .padding(10)
                .border(.figmaGray)
                .clipShape(.rect(cornerRadius: 5))
            
            Spacer().frame(height: 10)
            
            // 비밀번호 텍스트 밑 텍스트필드
            HStack {
                Text("비밀번호")
                Spacer()
            }
            TextField("비밀번호를 입력하세요", text: $password)
                .padding(10)
                .border(.figmaGray)
                .clipShape(.rect(cornerRadius: 5))
            
            Spacer().frame(height: 30)
            
            // 로그인 버튼
            Button {
                print ("Login btn tapped")
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
            }) {
                Text("회원가입")
                    .foregroundStyle(.black)
                    .underline()
                    .padding(10)
            }
            
            Spacer().frame(height: 30)
            
            // Apple login btn
            AppleLoginView()
        }
        .padding()
        
        
    }
}

struct AppleLoginView: View {
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

#Preview {
    LoginView()
}
