import FirebaseAuth
import Combine

class AuthViewModel: ObservableObject {
    
    @Published var email: String?
    @Published var uid: String? // firebase User의 id
    @Published var password: String?
    @Published var user: User? = nil
    @Published var loginStatus: Bool? = nil
    @Published var postingFinished: Bool = false
    init() {
        print("📌 AuthViewModel 초기화 시작")
        getUserFromDefaults()
        
        print("📌 UserDefaults에서 가져온 email: \(self.email ?? "no Email")")
        print("📌 UserDefaults에서 가져온 uid: \(self.uid ?? "nil")")
        
        if let validUID = uid {
            print("✅ UID 존재함, Firestore에서 유저 정보 가져오기 시도")
            
            FirebaseManager.shared.emailSignIn(email: self.email!, password: self.password!) { _, _ in
                print("자동 로그인")
                self.loginStatus = true
                self.getUserByUID()
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
        
        print("self.uid => \(self.uid)")
        FirebaseManager.shared.fetchData(collection: "users", documentID: self.uid ?? "") { (result: User?) in
            
            print(result)
            self.user = result
            print("✅ Firestore에서 유저 데이터 가져옴: \(self.user?.nickname ?? "의문의 실패")")
        }
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
            
            // 로그아웃 시 UserDefaults에서 사용자 정보 삭제
            UserDefaults.standard.removeObject(forKey: "uid")
            UserDefaults.standard.removeObject(forKey: "email")
            UserDefaults.standard.removeObject(forKey: "password")
            
            // 프로퍼티 초기화
            self.email = nil
            self.uid = nil
            self.password = nil
            self.user = nil
            
            // 로그인 상태를 false로 설정하여 로그인 화면으로 돌아가도록 함
            self.loginStatus = false
            self.postingFinished = false
        } catch let signOutError as NSError {
            print("Error signing out: \(signOutError)")
        }
    }
}
