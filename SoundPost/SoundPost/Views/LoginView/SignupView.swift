import SwiftUI
import FirebaseAuth
import FirebaseCore

struct SignupView: View {
    // TODO: 회원가입하는 시점에 User 생성 후 파이어베이스에 업로드
    
    @Environment(\.dismiss) var dismiss
    
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var nickname: String = ""
    @State private var isResultShow: Bool = false
    @State private var isSignupSuccess: Bool = false
    @State private var resultText: String = ""
    
    private var isAllConditionFit: Bool {isEmailVaild && isPasswordVaild && isNicknameValid}
    private var isEmailVaild: Bool {checkEmailVaild()}
    private var isPasswordVaild: Bool {checkPasswordVaild()}
    private var isNicknameValid: Bool { checkNicknameVaild() }
    
    
    var body: some View {
        VStack {
            Text("회원가입")
                .font(.largeTitle)
            
            Spacer() .frame(height: 30)
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
            
            // 비밀번호 텍스트 밑 텍스트필드
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
            
            Spacer().frame(height: 10)
            
            // 닉네임 텍스트 밑 텍스트필드
            HStack {
                Text("닉네임")
                Spacer()
            }
            TextField("닉네임을 입력하세요", text: $nickname)
                .padding(10)
                .border(.figmaGray)
                .clipShape(.rect(cornerRadius: 5))
            
            Spacer().frame(height: 30)
            
            
            // 회원가입 버튼
            Button {
                print ("Signup btn tapped")
                signUp(email: self.email, password: self.password)
                
            } label: {
                Text("회원가입")
                    .foregroundStyle(.black)
                    .frame(maxWidth: .infinity)
                    .padding(10)
                    .background(
                        RoundedRectangle(cornerRadius: 5)
                            .foregroundStyle(isAllConditionFit ? .primaryNeon : .figmaGray)
                    )
            }
            .disabled(!isAllConditionFit)
            
        }
        .padding()
        .overlay {
            if isResultShow {
                SignupResultView(isSuccessed: isSignupSuccess, subtitle: resultText)
            }
        }
        
    }
}
struct SignupResultView: View {
    let isSuccessed: Bool
    let subtitle: String
    
    var body: some View {
        
        VStack {
            if isSuccessed {
                Image(systemName: "checkmark.circle.fill")
                    .resizable()
                    .foregroundStyle(.primaryNeon)
                    .frame(width: 100, height: 100)
            }
            else {
                Image(systemName: "xmark.circle.fill")
                    .resizable()
                    .foregroundStyle(.red)
                    .frame(width: 100, height: 100)
            }
            
            Text(subtitle)
                .font(.subheadline)
                .foregroundStyle(isSuccessed ? .primaryNeon : .red)
        }
        
    }
    
}
extension SignupView {
    func checkEmailVaild() -> Bool {
        let emailRegex = "^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
    func checkPasswordVaild() -> Bool {
        return password.count >= 6
    }
    
    func checkNicknameVaild() -> Bool {
        return !nickname.isEmpty
    }
    
    func signUp(email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error as NSError? {
                print(error)
                isResultShow = true
                isSignupSuccess = false
                
                // ✅ 0.3초 뒤에 체크마크 사라지도록 설정
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    withAnimation(.easeOut(duration: 0.3)) {
                        isResultShow = false
                    }
                }
                
                switch error.code {
                case AuthErrorCode.emailAlreadyInUse.rawValue:
                    resultText = "❌ 이미 사용 중인 이메일입니다."
                case AuthErrorCode.invalidEmail.rawValue:
                    resultText = "❌ 이메일 형식이 올바르지 않습니다."
                case AuthErrorCode.weakPassword.rawValue:
                    resultText = "❌ 비밀번호가 너무 짧습니다. (최소 6자 이상 입력)"
                case AuthErrorCode.networkError.rawValue:
                    resultText = "❌ 네트워크 오류. 인터넷 연결을 확인하세요."
                case AuthErrorCode.tooManyRequests.rawValue:
                    resultText = "❌ 너무 많은 요청이 발생했습니다. 잠시 후 다시 시도하세요."
                case AuthErrorCode.operationNotAllowed.rawValue:
                    resultText = "❌ 이메일/비밀번호 회원가입이 비활성화되어 있습니다."
                default:
                    resultText = "❌ 알 수 없는 오류 발생: \(error.localizedDescription)"
                }
            } else {
                resultText = "회원가입 성공!"
                print("✅ 회원가입 성공! 이메일: \(authResult?.user.email ?? "알 수 없음")")
                
                isResultShow = true
                isSignupSuccess = true
                
                guard let userId = authResult?.user.uid else { return }
                guard let email = authResult?.user.email else { return }
                
                FirebaseManager.shared.saveData(targetData: User(id: userId, email: email, nickname: self.nickname, isAlarmOn: true, posts: [], signupDate: Date.now.timeIntervalSince1970))
                // ✅ 0.3초 뒤에 체크마크 사라지도록 설정
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    withAnimation(.easeOut(duration: 0.3)) {
                        isResultShow = false
                        
                        dismiss()
                        
                        
                    }
                }
            }
        }
    }
    
}

//#Preview {
//    SignupView()
//}
