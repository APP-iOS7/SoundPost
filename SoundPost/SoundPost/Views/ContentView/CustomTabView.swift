import SwiftUI

struct CustomTabView: View {
    
    @StateObject var contentViewModel: ContentViewModel
    
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                Button {
                    contentViewModel.TabSet(.home)
                } label: {
                    VStack {
                        Image(systemName: "house.fill")
                            .foregroundColor(contentViewModel.TabColor(.home))
                            .font(.title)
                        
                        Text("홈")
                            .foregroundColor(contentViewModel.TabColor(.home))
                            .font(.caption)
                    }
                }
                Spacer()
                Spacer()
                Button {
                    contentViewModel.QuickStartSet()
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
                            Text("재녹음")
                                .foregroundColor(.red)
                                .font(.caption)
                        default:
                            Image(systemName: "plus.circle.fill")
                                .foregroundColor(contentViewModel.QuickStartButtonColor())
                                .font(.title)
                            Text("포스팅")
                                .foregroundColor(contentViewModel.QuickStartButtonColor())
                                .font(.caption)
                        }
                    }
                }
                Spacer()
                Spacer()
                Button {
                    contentViewModel.TabSet(.myProfile)
                } label: {
                    VStack {
                        Image(systemName: "person.fill")
                            .foregroundColor(contentViewModel.TabColor(.myProfile))
                            .font(.title)
                        
                        Text("프로필")
                            .foregroundColor(contentViewModel.TabColor(.myProfile))
                            .font(.caption)
                    }
                }
                Spacer()
            }
            Spacer()
            Spacer()
        }
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 9.8)
            .background(
                RoundedRectangle(cornerRadius: 0)
                    .fill(.white)
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 9.8)
            )
    }
}

//#Preview {
//    CustomTabView(selectedTab: $ContentViewModel().tabHandler)
//}
