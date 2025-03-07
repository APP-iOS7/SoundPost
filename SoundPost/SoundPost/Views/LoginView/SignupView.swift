//
//  SignupView.swift
//  SoundPost
//
//  Created by 이재용 on 3/7/25.
//

import SwiftUI

struct SignupView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var nickname: String = ""
    private var isAllConditionFit: Bool  = true
    private var isEmailVaild: Bool = false
    private var isPasswordVaild: Bool = false
    private var isNicknameValid: Bool = false
    
    
    var body: some View {
        VStack {
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
                print ("Login btn tapped")
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
    
    
}

#Preview {
    SignupView()
}
