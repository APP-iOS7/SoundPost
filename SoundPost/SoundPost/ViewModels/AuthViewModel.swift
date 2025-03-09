import FirebaseAuth
import Combine

class AuthViewModel: ObservableObject {
    // nil -> 로그인된 상태 아님
    @Published var email: String? = nil
    
    
    enum SignInState{
        case signedIn
        case signedOut
    }
    
    func emailAuthSignIn(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                print("error: \(error.localizedDescription)")
                
                return
            }
            
            if result != nil {
                self.email = result?.user.email
                print("사용자 이메일: \(String(describing: result?.user.email))")
                
                
            }
        }
    }
}
