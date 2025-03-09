import FirebaseAuth
import Combine

class AuthViewModel: ObservableObject {
    @Published var state: SignInState = .signedOut
    @Published var email: String = ""
    @Published var user: User? = nil
    
    
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
                self.state = .signedIn
                print("사용자 이메일: \(String(describing: result?.user.email))")
                print("사용자 이름: \(String(describing: result?.user.displayName))")
                
            }
        }
    }
}
