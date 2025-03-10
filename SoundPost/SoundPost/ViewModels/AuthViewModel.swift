import FirebaseAuth
import Combine

class AuthViewModel: ObservableObject {
    
    @Published var email: String?
    @Published var uid: String? // firebase User의 id
    @Published var password: String?
    @Published var user: User? = nil
    @Published var loginStatus: Bool? = nil
    
    init() {
        print("📌 AuthViewModel 초기화 시작")
        getUserFromDefaults()
        
        print("📌 UserDefaults에서 가져온 email: \(self.email ?? "no Email")")
        print("📌 UserDefaults에서 가져온 uid: \(self.uid ?? "nil")")
        
        if let validUID = uid {
            print("✅ UID 존재함, Firestore에서 유저 정보 가져오기 시도")
            getUserByUID()
            FirebaseManager.shared.emailSignIn(email: self.email!, password: self.password!) { _, _ in
                print("자동 로그인")
                self.loginStatus = true
            }
        } else {
            print("🚨 UID 없음, 자동 로그인 불가능")
        }
    }
    
    func saveUserAtDefaults() {
        UserDefaults.standard.set(uid, forKey: "uid")
        UserDefaults.standard.set(email, forKey: "email")
        UserDefaults.standard.set(password, forKey: "password")
    }
    private func getUserFromDefaults() {
        uid = UserDefaults.standard.string(forKey: "uid") ?? nil
        email = UserDefaults.standard.string(forKey: "email") ?? nil
        password = UserDefaults.standard.string(forKey: "password") ?? nil
    }
    
    func getUserByUID() {
        FirebaseManager.shared.fetchData(collection: "users", documentID: uid ?? "") { (result: User?) in
            self.user = result
            print("✅ Firestore에서 유저 데이터 가져옴: \(self.user?.nickname ?? "의문의 실패")")
        }
    }
    
    
    
}
