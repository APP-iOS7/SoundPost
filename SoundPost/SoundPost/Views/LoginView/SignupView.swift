//
//  SignupView.swift
//  SoundPost
//
//  Created by 이재용 on 3/7/25.
//

import SwiftUI
import FirebaseAuth
import FirebaseCore

struct SignupView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var nickname: String = ""
    private var isAllConditionFit: Bool {isEmailVaild && isPasswordVaild && isNicknameValid}
    private var isEmailVaild: Bool {checkEmailVaild()}
    private var isPasswordVaild: Bool {checkPasswordVaild()}
    private var isNicknameValid: Bool { checkNicknameVaild() }
    
    
    var body: some View {
        VStack {
            // 이메일 텍스트 밑 텍스트필드
            HStack {
                Text("이메일")
                Spacer()
            }
            .onAppear() {
                print("Firebase is configured: \(FirebaseApp.app() != nil)")

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
            
        }
        .padding()
    }
}

extension SignupView {
    func checkEmailVaild() -> Bool {
        return true
    }
    func checkPasswordVaild() -> Bool {
        return true
    }
    
    func checkNicknameVaild() -> Bool {
        if self.nickname != "" {
            return true
        }
        return false
    }

    func signUp(email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error as NSError? {
                print(error)
                switch error.code {
                case AuthErrorCode.emailAlreadyInUse.rawValue:
                    print("❌ 이미 사용 중인 이메일입니다.")
                case AuthErrorCode.invalidEmail.rawValue:
                    print("❌ 이메일 형식이 올바르지 않습니다.")
                case AuthErrorCode.weakPassword.rawValue:
                    print("❌ 비밀번호가 너무 짧습니다. (최소 6자 이상 입력)")
                case AuthErrorCode.networkError.rawValue:
                    print("❌ 네트워크 오류. 인터넷 연결을 확인하세요.")
                case AuthErrorCode.tooManyRequests.rawValue:
                    print("❌ 너무 많은 요청이 발생했습니다. 잠시 후 다시 시도하세요.")
                case AuthErrorCode.operationNotAllowed.rawValue:
                    print("❌ 이메일/비밀번호 회원가입이 비활성화되어 있습니다.")
                default:
                    print("❌ 알 수 없는 오류 발생: \(error.localizedDescription)")
                }
            } else {
                print("✅ 회원가입 성공! 이메일: \(authResult?.user.email ?? "알 수 없음")")
            }
        }
    }

}

#Preview {
    SignupView()
}
