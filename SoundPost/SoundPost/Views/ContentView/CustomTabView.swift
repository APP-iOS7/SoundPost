import SwiftUI

struct CustomTabView: View {
    
    @Binding var selectedTab: ContentViewModel.Tab
    
    var body: some View {
            HStack {
                Spacer()
                Button {
                    selectedTab = .home
                } label: {
                    VStack {
                        Image(systemName: "house.fill")
                            .foregroundColor(selectedTab == .home ? .black : .gray)
                            .font(.title)
                        
                        Text("홈")
                            .foregroundColor(selectedTab == .home ? .black : .gray)
                            .font(.caption)
                    }
                }
                Spacer()
                Spacer()
                Button {
                    selectedTab = .quickStart
                } label: {
                    VStack {
                        Image(systemName: "plus.circle.fill")
                            .foregroundColor(selectedTab == .quickStart ? .black : .gray)
                            .font(.title)
                        
                        Text("시작")
                            .foregroundColor(selectedTab == .quickStart ? .black : .gray)
                            .font(.caption)
                    }
                }
                Spacer()
                Spacer()
                Button {
                    selectedTab = .myProfile
                } label: {
                    VStack {
                        Image(systemName: "person.fill")
                            .foregroundColor(selectedTab == .myProfile ? .black : .gray)
                            .font(.title)
                        
                        Text("프로필")
                            .foregroundColor(selectedTab == .myProfile ? .black : .gray)
                            .font(.caption)
                    }
                }
                Spacer()
            }
//            .frame(width: UIScreen.main.bounds.width, height: 85)
            .edgesIgnoringSafeArea(.bottom)

    }
}

//#Preview {
//    CustomTabView(selectedTab: $ContentViewModel().tabHandler)
//}
