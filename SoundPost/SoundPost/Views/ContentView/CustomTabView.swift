import SwiftUI

struct CustomTabView: View {
    
    @StateObject var contentViewModel: ContentViewModel
    
    var body: some View {
            HStack {
                Spacer()
                Button {
                    contentViewModel.tabHandler = .home
                } label: {
                    VStack {
                        Image(systemName: "house.fill")
                            .foregroundColor(contentViewModel.tabHandler == .home ? .black : .gray)
                            .font(.title)
                        
                        Text("홈")
                            .foregroundColor(contentViewModel.tabHandler == .home ? .black : .gray)
                            .font(.caption)
                    }
                }
                Spacer()
                Spacer()
                Button {
                    contentViewModel.tabHandler = .quickStart
                } label: {
                    VStack {
                        switch contentViewModel.QuickStartButtonClick {
                        case 1:
                            Image(systemName: "record.circle")
                                .foregroundColor(.red)
                                .font(.title)
                            Text("녹음")
                                .foregroundColor(.red)
                                .font(.caption)
                        case 2 :
                            Image(systemName: "stop.circle.fill")
                                .foregroundColor(.red)
                                .font(.title)
                            Text("녹음중")
                                .foregroundColor(.red)
                                .font(.caption)
                        case 3 :
                            Image(systemName: "record.circle")
                                .foregroundColor(.red)
                                .font(.title)
                            Text("멈춤")
                                .foregroundColor(.red)
                                .font(.caption)
                        default:
                            Image(systemName: "plus.circle.fill")
                                .foregroundColor(contentViewModel.tabHandler == .quickStart ? .black : .gray)
                                .font(.title)
                            Text("포스팅")
                                .foregroundColor(contentViewModel.tabHandler == .quickStart ? .black : .gray)
                                .font(.caption)
                        }
                    }
                }
                Spacer()
                Spacer()
                Button {
                    contentViewModel.tabHandler = .myProfile
                } label: {
                    VStack {
                        Image(systemName: "person.fill")
                            .foregroundColor(contentViewModel.tabHandler == .myProfile ? .black : .gray)
                            .font(.title)
                        
                        Text("프로필")
                            .foregroundColor(contentViewModel.tabHandler == .myProfile ? .black : .gray)
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
