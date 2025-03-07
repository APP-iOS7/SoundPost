import Foundation

struct User {
    let email: String
    let nickname: String
    let password: String
    var isAlarmOn: Bool
    var posts: [Post] = []
    let signupDate: Date
}
