import FirebaseAuth
import Combine

class AuthViewModel: ObservableObject {
   
    @Published var email: String?
    @Published var uid: String? // firebase User의 id
    @Published var user: User? = nil
    @Published var loginStatus: Bool = false
    
    init(email: String? = nil, uid: String? = nil, user: User? = nil) {
        getUserFromDefaults()
        if uid != nil {
            getUserByUID()
        }
        
    }
    
    func saveUserAtDefaults() {
        UserDefaults.standard.set(uid, forKey: "uid")
        UserDefaults.standard.set(email, forKey: "email")
    }
    private func getUserFromDefaults() {
        uid = UserDefaults.standard.string(forKey: "uid") ?? nil
        email = UserDefaults.standard.string(forKey: "email") ?? nil
    }
    
    private func getUserByUID() {
        FirebaseManager.shared.fetchData(collection: "users", documentID: uid ?? "") { (result: User?) in
            self.user = result
            self.loginStatus = result != nil
        }
    }


    
}
