//
//  ProfileView.swift
//  SoundPost
//
//  Created by 이재용 on 3/10/25.
//

import SwiftUI

import SwiftUI

struct ProfileView: View {
    @State var isNavigationBarShowing: Bool = false
   @EnvironmentObject private var authViewModel : AuthViewModel
    // 한 줄에 하나의 아이템만 표시되도록 그리드 설정
    private let columns = [
        GridItem(.flexible())
    ]
    
    @State var postIds : [String] = []
    @State var myPosts: [PostViewModel] = []
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    ProfileHeaderView(authViewModel: authViewModel)
                }
                LazyVGrid(columns: columns) {
                    ForEach(myPosts, id: \.postId) { post in
                        NavigationLink(destination: PostDetailView(post: post)) {
                            VStack(spacing: 0) {
                                PostView(post: post)
                                
                                Divider()
                                    .padding(.leading)
                            }
                            .contentShape(Rectangle()) // 전체 영역을 탭 가능하게 만듦
                        }
                        .buttonStyle(PlainButtonStyle()) // 기본 버튼 스타일 제거
                    }
                }
            }
            .border(.blue)
            
            
        }
        .onAppear() {
            postIds = authViewModel.user?.posts ?? []
            for postid in postIds {
                FirebaseManager.shared.fetchData(collection: "posts", documentID: postid) { (result: Post?) in
                    if let newPost = result {
                        self.myPosts.append(PostViewModel.createPVMwithPost(post: newPost, myId: authViewModel.user?.id ?? ""))
                    }
                }
            }
        }
    }
}



struct ProfileHeaderView: View {
    @State var authViewModel : AuthViewModel
    
    var body: some View {
        HStack {
            Image(systemName: "heart.fill")
                .resizable()
                .frame(width: 100, height: 100)
                .clipShape(.circle)
                .border(.primaryNeon)
            Spacer()
                .frame(width: 30)
            VStack(alignment: .leading) {
                Text(authViewModel.user?.nickname ?? "알 수 없는 사용자")
                    .font(.headline)
                
                HStack {
                    Text(intervalToDate(authViewModel.user?.signupDate ?? 0.0))
                        .font(.caption)
                        .foregroundColor(.gray)
                    
                    Text("가입")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
            }
            Spacer()
        }
        .padding()
    }
}
extension ProfileHeaderView {
    func intervalToDate(_ interval: Double) -> String {
        let date = Date(timeIntervalSince1970: interval)
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: date)
    }
}

#Preview {
    ProfileView()
        .environmentObject(AuthViewModel())
}
