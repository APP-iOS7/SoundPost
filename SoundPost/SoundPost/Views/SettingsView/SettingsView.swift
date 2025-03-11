import SwiftUI

struct SettingsView: View {
    var body: some View {
        VStack {
            Toggle("알림", isOn: .constant(true))
            Button {
                print("로그아웃")
            } label: {
                Text("로그아웃")
                    .padding(.horizontal)
            }
            .buttonStyle(BorderedProminentButtonStyle())
            .clipShape(Capsule())
        }
        .padding()
    }
}

#Preview {
    SettingsView()
}
