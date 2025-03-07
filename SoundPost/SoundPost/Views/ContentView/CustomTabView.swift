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
                    
                    Text("홈")
                        .foregroundColor(selectedTab == .home ? .black : .gray)
                        .font(.caption)
                }
            }
            
            Spacer()
            Button {
                selectedTab = .quickStart
            } label: {
                VStack {
                    Image(systemName: "plus.circle.fill")
                        .foregroundColor(selectedTab == .quickStart ? .black : .gray)
                    
                    Text("시작")
                        .foregroundColor(selectedTab == .quickStart ? .black : .gray)
                        .font(.caption)
                }
            }
            Spacer()
            Button {
                selectedTab = .myProfile
            } label: {
                VStack {
                    Image(systemName: "person.fill")
                        .foregroundColor(selectedTab == .myProfile ? .black : .gray)
                    
                    Text("프로필")
                        .foregroundColor(selectedTab == .myProfile ? .black : .gray)
                        .font(.caption)
                }
            }
            Spacer()
        }
    }
}

#Preview {
    CustomTabView(selectedTab: ContentViewModel().tabHandler)
}
