import SwiftUI
import Firebase
import FirebaseAppCheck

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        // 파베 초기화
        FirebaseApp.configure()
        // 앱체크 우회
        AppCheck.setAppCheckProviderFactory(AppCheckDebugProviderFactory())
        
        return true
    }
}

@main
struct SoundPostApp: App {
    // Firebase 초기화를 위해 AppDelegate 사용
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    var body: some Scene {
        WindowGroup {
            LoginView()
                .tint(.primary)
        }
    }
}
