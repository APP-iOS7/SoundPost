//
//  ProfileView.swift
//  SoundPost
//
//  Created by 이재용 on 3/10/25.
//

import SwiftUI
struct ProfileView: View {
    @State var isNavigationBarShowing: Bool = false
    @State private var user : User?
    
    var body: some View {
        NavigationStack {
            
            ScrollView {
                
                VStack {
                    HStack {
                        Image(systemName: "heart.fill")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .clipShape(.circle)
                        
                        
                        VStack(alignment: .leading) {
                            Text(user?.nickname ?? "알 수 없는 사용자")
                                .font(.caption)
                            
                            HStack {
                                Text(intervalToDate(self.user!.signupDate))
                                    .font(.caption)
                                    .foregroundColor(.gray)
                                Text("가입")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                            }
                            
                        }
                    }
                }
            }
            
        }
    }
}

extension ProfileView {
    func intervalToDate(_ interval: Double) -> String {
        let date = Date(timeIntervalSince1970: interval)
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: date)
    }
}

#Preview {
    ProfileView()
}
