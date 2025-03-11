import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @State private var isAlarmOn: Bool = true
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            VStack {
                Toggle("알림", isOn: $isAlarmOn)
                
                Button {
                    // TODO: 로그아웃
                } label: {
                    Text("로그아웃")
                        .padding(.horizontal)
                }
                .buttonStyle(BorderedProminentButtonStyle())
                .clipShape(Capsule())
                
                Spacer()
            }
            .padding()
            .navigationTitle("설정")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        dismiss()
                    }) {
                        Image(systemName: "xmark")
                            .foregroundColor(.primary)
                    }
                }
            }
        }
    }
}

#Preview {
    SettingsView()
        .environmentObject(AuthViewModel())
        .tint(.primary)
}
