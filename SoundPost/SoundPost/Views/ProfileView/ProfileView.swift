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
    @EnvironmentObject var authViewModel : AuthViewModel
    // 한 줄에 하나의 아이템만 표시되도록 그리드 설정
    private let columns = [
        GridItem(.flexible())
    ]
    
    @State var postIds : [String] = []
    @State var myPosts: [PostViewModel] = []
    @State private var showSettingsView = false
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    ProfileHeaderView(authViewModel: authViewModel)
                }
                
                ForEach(myPosts.sorted(by: { $0.uploadDate > $1.uploadDate }), id: \.postId) { post in
                    NavigationLink(destination: PostDetailView2(post: post, quickStartViewModel: QuickStartButtonViewModel(authViewModel: authViewModel, uploader: authViewModel.user))) {
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
            .navigationTitle("프로필")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        showSettingsView = true
                    }) {
                        Image(systemName: "gearshape.fill")
                    }
                }
            }
            .fullScreenCover(isPresented: $showSettingsView) {
                SettingsView()
            }
            .onAppear() {
                guard let user = authViewModel.user else {
                    print("❌ 유저 정보가 로드되지 않음")
                    return
                }
                
                postIds = user.posts
                print("✅ 유저의 포스트 ID 목록: \(postIds)")
                
                for postid in postIds {
                    FirebaseManager.shared.fetchData(collection: "posts", documentID: postid) { (result: Post?) in
                        if let newPost = result {
                            DispatchQueue.main.async {
                                Task {
                                    let postVM = PostViewModel.createPVMwithPost(post: newPost, myId: user.id!)
                                    
                                   
                                        self.myPosts.append(postVM)
                                        print("✅ 추가된 포스트: \(postVM.postId)")
                                    
                                    
                                }
                            }
                        } else {
                            print("❌ 포스트 데이터 가져오기 실패: \(postid)")
                        }
                    }
                }
            }
            .onChange(of: authViewModel.user?.posts) {
                guard let user = authViewModel.user else {
                    print("❌ 유저 정보가 로드되지 않음")
                    return
                }
                
                postIds = user.posts
                print("✅ >유저의 포스트 ID 목록: \(postIds)")
                
                for postid in postIds {
                    FirebaseManager.shared.fetchData(collection: "posts", documentID: postid) { (result: Post?) in
                        if let newPost = result {
                            DispatchQueue.main.async {
                                Task {
                                    let postVM = PostViewModel.createPVMwithPost(post: newPost, myId: user.id!)
                                    if (self.myPosts.first(where: { $0.postId == postVM.postId }) == nil) {
                                        self.myPosts.append(postVM)
                                        print("✅ 추가된 포스트: \(postVM.postId)")
                                    }
                                }
                            }
                        } else {
                            print("❌ 포스트 데이터 가져오기 실패: \(postid)")
                        }
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
            Image(systemName: "person.circle")
                .resizable()
                .frame(width: 100, height: 100)
                .clipShape(.circle)
            
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
        .tint(.primary)
}
