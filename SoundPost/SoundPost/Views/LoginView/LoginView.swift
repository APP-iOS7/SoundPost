//
//  LoginView.swift
//  SoundPost
//
//  Created by 이재용 on 3/7/25.
//

import SwiftUI

struct LoginView: View {
    var body: some View {
        VStack {
            Image(systemName: "heart.fil")
                .resizable()
                .frame(width: 80, height: 80)
                .foregroundColor(.primaryNeon)
                .border(Color.primary, width: 3)
            Text("Login")
                .font(.headline)
            
        }
    }
}

//#Preview {
//    LoginView()
//}
